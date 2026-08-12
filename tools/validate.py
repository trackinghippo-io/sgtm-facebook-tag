import json, re, sys, subprocess, tempfile, os

path = sys.argv[1]
src = open(path, encoding='utf-8').read()

ok = True
parts = re.split(r'^___([A-Z_]+)___$', src, flags=re.M)
sections = {}
for i in range(1, len(parts), 2):
    sections[parts[i]] = parts[i + 1]

EXPECTED = ['TERMS_OF_SERVICE', 'INFO', 'TEMPLATE_PARAMETERS',
            'SANDBOXED_JS_FOR_SERVER', 'SERVER_PERMISSIONS', 'TESTS', 'NOTES']
got = list(sections.keys())
if got == EXPECTED:
    print("sections: correct markers, correct order")
else:
    ok = False
    print(f"SECTION MARKERS WRONG\n  expected: {EXPECTED}\n  got:      {got}")

for name in ['INFO', 'TEMPLATE_PARAMETERS', 'SERVER_PERMISSIONS']:
    try:
        obj = json.loads(sections[name])
        print(f"  {name}: valid JSON ({len(obj) if isinstance(obj, list) else 'object'})")
    except Exception as e:
        ok = False
        print(f"  {name}: INVALID JSON -> {e}")

try:
    import yaml
    t = yaml.safe_load(sections['TESTS'])
    print(f"  TESTS: valid YAML, {len(t.get('scenarios', []))} scenarios, setup={'setup' in t}")
    for s in t['scenarios']:
        assert 'name' in s and 'code' in s, s
except ImportError:
    print("  TESTS: pyyaml missing, skipped")
except Exception as e:
    ok = False
    print(f"  TESTS: INVALID YAML -> {e}")

js = sections['SANDBOXED_JS_FOR_SERVER']
with tempfile.NamedTemporaryFile('w', suffix='.js', delete=False, encoding='utf-8') as f:
    # top-level return is legal inside a Function body
    f.write("new Function(" + json.dumps(js) + ");\nconsole.log('  SANDBOXED_JS: parses');\n")
    tmp = f.name
r = subprocess.run(['node', tmp], capture_output=True, text=True)
print(r.stdout.strip() or r.stderr.strip()[:800])
if r.returncode != 0:
    ok = False
os.unlink(tmp)

# check every test scenario body also parses
try:
    import yaml
    t = yaml.safe_load(sections['TESTS'])
    bodies = [t.get('setup', '')] + [s['code'] for s in t['scenarios']]
    for i, b in enumerate(bodies):
        with tempfile.NamedTemporaryFile('w', suffix='.js', delete=False, encoding='utf-8') as f:
            f.write("new Function(" + json.dumps(b) + ");")
            tmp = f.name
        r = subprocess.run(['node', tmp], capture_output=True, text=True)
        os.unlink(tmp)
        if r.returncode != 0:
            ok = False
            print(f"  test body {i}: SYNTAX ERROR -> {r.stderr.strip()[:300]}")
    print("  test bodies: all parse")
except ImportError:
    pass

print("RESULT:", "OK" if ok else "FAILED")
sys.exit(0 if ok else 1)
