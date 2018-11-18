From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Sun, 18 Nov 2018 21:18:41 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 17
 commits: Fix PEP-8 style issues identified by pycodestyle
Message-ID: <5bf1d731cb0e9_14993f99933cb06056229b@sidekiq-asap-01-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
8a32d40b by Ben Hutchings at 2018-11-16T15:03:18Z
Fix PEP-8 style issues identified by pycodestyle

* Add recommended white-space
* Break lines so they are &lt; 80 characters long

- - - - -
0559db08 by Ben Hutchings at 2018-11-16T15:05:32Z
Remove unused imports identified by pyflakes

- - - - -
a216d60d by Ben Hutchings at 2018-11-16T15:08:25Z
kernel_sec.isssue: Use Loader.construct_scalar when loading timestamps

_IssueLoader.construct_yaml_timestamp already called
Loader.construct_scalar but did not use the result.

- - - - -
6e8ecdd9 by Ben Hutchings at 2018-11-16T16:29:08Z
webview: Fix variable/attribute names in Branch, Branches

- - - - -
c000a018 by Ben Hutchings at 2018-11-16T16:29:19Z
Move commit/branch mapping from report_affected to kernel_sec.branch module

* Add a function for branch sort keys
* Add a class for the commit/branch mapping

- - - - -
5838d699 by Ben Hutchings at 2018-11-16T16:29:19Z
Move commit list comparison from report_affected to kernel_sec.issue module

- - - - -
9785ec44 by Ben Hutchings at 2018-11-16T16:29:19Z
report_affected: Move branch-independent issue checks out of the branch loop

- - - - -
e777bee7 by Ben Hutchings at 2018-11-16T16:33:11Z
webview: Add list of issues to branch pages

- - - - -
3a370f88 by Ben Hutchings at 2018-11-16T16:45:40Z
webview: Add issue descriptions to issue lists

- - - - -
12e3c3d8 by Ben Hutchings at 2018-11-16T16:54:24Z
webview: Add a stylesheet (initially empty)

- - - - -
273d4d9c by Ben Hutchings at 2018-11-16T18:26:33Z
webview: Specify text and background colours in stylesheet

We need to specify colours for everything to ensure that more specific
rules don&#39;t conflict with user-defined colours.

- - - - -
867887e4 by Ben Hutchings at 2018-11-16T18:28:07Z
webview: Grey-out ignored issues in lists

* Set an &quot;ignored&quot; class on list items for ignored issues
* Mix text/link/visited colours with 40% white for the &quot;ignored&quot; class

- - - - -
4d06a7f2 by Ben Hutchings at 2018-11-16T18:45:25Z
webview: Move branch names and commit-branch mapping to Root class

- - - - -
7cda6dde by Ben Hutchings at 2018-11-16T18:57:54Z
webview: Add per-branch status to issue pages

- - - - -
882fe908 by Ben Hutchings at 2018-11-18T20:59:27Z
webview: Sort branch list

- - - - -
9695e007 by Ben Hutchings at 2018-11-18T21:17:45Z
webview: Set table styles

* Enable narrow borders between rows
* Increase spacing between columns
* Align headings to top right of cell

- - - - -
c4d3bc0b by Ben Hutchings at 2018-11-18T21:18:24Z
webview: Use three columns for tables on issue pages

* Insert a column between the field name and details
* Put comment authors and branch names in this column

- - - - -


16 changed files:

- scripts/cleanup.py
- scripts/import_debian.py
- scripts/import_stable.py
- scripts/import_ubuntu.py
- scripts/kernel_sec/branch.py
- scripts/kernel_sec/issue.py
- scripts/kernel_sec/version.py
- scripts/report_affected.py
- scripts/templates/branch.html
- scripts/templates/branches.html
- scripts/templates/issue.html
- scripts/templates/issues.html
- scripts/templates/root.html
- + scripts/templates/style.css
- scripts/validate.py
- scripts/webview.py


Changes:

=====================================
scripts/cleanup.py
=====================================
@@ -8,11 +8,13 @@
 
 import kernel_sec.issue
 
+
 def main():
     issues = set(kernel_sec.issue.get_list())
     for cve_id in issues:
         issue = kernel_sec.issue.load(cve_id)
         kernel_sec.issue.save(cve_id, issue)
 
+
 if __name__ == '__main__':
     main()


=====================================
scripts/import_debian.py
=====================================
@@ -20,6 +20,7 @@ import sys
 
 import kernel_sec.issue
 
+
 IMPORT_DIR = 'import/debian'
 
 LINE_BREAK_RE = re.compile(r'\n\s*')
@@ -30,6 +31,7 @@ STATUS_RE = re.compile(r'^\s*(?P<state>\S*)'
                        r'\s*(\[(?P<changerefs>(\S*,\s*)*\S*)\s*\])'
                        r'|"(?P<reason>.+)")?')
 
+
 def load_debian_issue(f):
     deb_issue = deb822.Deb822(f)
     issue = {}
@@ -86,6 +88,7 @@ def load_debian_issue(f):
 
     return issue
 
+
 def main():
     # Remove obsolete Subversion working directory
     if os.path.isdir(IMPORT_DIR + '/.svn'):
@@ -96,10 +99,10 @@ def main():
     if os.path.isdir(IMPORT_DIR + '/.git'):
         subprocess.check_call(['git', 'pull'], cwd=IMPORT_DIR)
     else:
-        subprocess.check_call(['git', 'clone',
-                               'https://salsa.debian.org/kernel-team/kernel-sec.git',
-                               '.'],
-                              cwd=IMPORT_DIR)
+        subprocess.check_call(
+            ['git', 'clone',
+             'https://salsa.debian.org/kernel-team/kernel-sec.git', '.'],
+            cwd=IMPORT_DIR)
 
     our_issues = set(kernel_sec.issue.get_list())
     their_issues = dict((os.path.basename(name), name) for name in
@@ -126,9 +129,9 @@ def main():
             # Copy theirs
             ours = theirs
         else:
-            # Merge into ours
+            # Check that it's good to start with, then merge into ours
             ours = kernel_sec.issue.load(cve_id)
-            kernel_sec.issue.validate(ours) # check that it's good to start with
+            kernel_sec.issue.validate(ours)
             if not kernel_sec.issue.merge_into(ours, theirs):
                 continue
 
@@ -140,5 +143,6 @@ def main():
 
         kernel_sec.issue.save(cve_id, ours)
 
+
 if __name__ == '__main__':
     main()


=====================================
scripts/import_stable.py
=====================================
@@ -13,9 +13,10 @@ import argparse
 import io
 import re
 import subprocess
-import sys
 
-import kernel_sec.branch, kernel_sec.issue
+import kernel_sec.branch
+import kernel_sec.issue
+
 
 BACKPORT_COMMIT_RE = re.compile(
     r'^(?:' r'commit (%s) upstream\.'
@@ -24,10 +25,12 @@ BACKPORT_COMMIT_RE = re.compile(
     r')$'
     % ((r'[0-9a-f]{40}',) * 3))
 
+
 def update(git_repo, remote_name):
     subprocess.check_call(['git', 'remote', 'update', remote_name],
                           cwd=git_repo)
 
+
 def get_backports(git_repo, remote_name):
     branches = kernel_sec.branch.get_stable_branches(git_repo, remote_name)
     backports = {}
@@ -35,7 +38,8 @@ def get_backports(git_repo, remote_name):
     for branch_name in branches:
         base_ver = kernel_sec.branch.get_stable_branch_base_ver(branch_name)
         log_proc = subprocess.Popen(
-            # Format with hash on one line, body on following lines indented by 1
+            # Format with hash on one line, body on following lines indented
+            # by 1
             ['git', 'log', '--no-notes', '--pretty=%H%n%w(0,1,1)%b',
              'v%s..%s/%s' % (base_ver, remote_name, branch_name)],
             cwd=git_repo, stdout=subprocess.PIPE)
@@ -49,11 +53,12 @@ def get_backports(git_repo, remote_name):
                 if match:
                     mainline_commit = match.group(1) or match.group(2) \
                                       or match.group(3)
-                    backports.setdefault(mainline_commit, {}) \
-                        [branch_name] = stable_commit
+                    backports.setdefault(mainline_commit, {})[branch_name] \
+                        = stable_commit
 
     return backports
 
+
 def add_backports(issue_commits, all_backports):
     try:
         mainline_commits = issue_commits['mainline']
@@ -84,6 +89,7 @@ def add_backports(issue_commits, all_backports):
 
     return changed
 
+
 def main(git_repo, remote_name):
     update(git_repo, remote_name)
     backports = get_backports(git_repo, remote_name)
@@ -102,17 +108,20 @@ def main(git_repo, remote_name):
         if changed:
             kernel_sec.issue.save(cve_id, issue)
 
+
 if __name__ == '__main__':
     parser = argparse.ArgumentParser(
-        description=('Import information about backported fixes and regressions '
-                     'from commit messages on stable branches.'))
+        description=('Import information about backported fixes and '
+                     'regressions from commit messages on stable branches.'))
     parser.add_argument('--git-repo',
                         dest='git_repo', default='../kernel',
-                        help='git repository from which to read commit logs (default: ../kernel)',
+                        help=('git repository from which to read commit logs '
+                              '(default: ../kernel)'),
                         metavar='DIRECTORY')
     parser.add_argument('--stable-remote',
                         dest='stable_remote_name', default='stable',
-                        help='git remote for stable branches (default: stable)',
+                        help=('git remote for stable branches '
+                              '(default: stable)'),
                         metavar='NAME')
     args = parser.parse_args()
     main(args.git_repo, args.stable_remote_name)


=====================================
scripts/import_ubuntu.py
=====================================
@@ -21,6 +21,7 @@ import sys
 
 import kernel_sec.issue
 
+
 IMPORT_DIR = 'import/ubuntu'
 
 BREAK_FIX_RE = re.compile(r'^break-fix: (?:([0-9a-f]{40})|[-\w]+)'
@@ -29,6 +30,7 @@ DISCOVERED_BY_SEP_RE = re.compile(r'(?:,\s*(?:and\s+)?|\s+and\s+)')
 COMMENT_RE = re.compile(r'^(\w+)>\s+(.*)$')
 DESCRIPTION_ANDROID_RE = re.compile(r'\bAndroid\b')
 
+
 # Based on load_cve() in scripts/cve_lib.py
 def load_cve(cve, strict=False):
     '''Loads a given CVE into:
@@ -44,7 +46,7 @@ def load_cve(cve, strict=False):
     code = EXIT_OKAY
 
     data = dict()
-    data.setdefault('tags',dict())
+    data.setdefault('tags', dict())
     affected = dict()
     lastfield = None
     fields_seen = []
@@ -64,7 +66,7 @@ def load_cve(cve, strict=False):
             continue
 
         try:
-            field, value = line.split(':',1)
+            field, value = line.split(':', 1)
         except ValueError as e:
             msg += "%s: bad line '%s' (%s)\n" % (cve, line, e)
             code = EXIT_FAIL
@@ -78,9 +80,11 @@ def load_cve(cve, strict=False):
             fields_seen.append(field)
         value = value.strip()
         if field == 'Candidate':
-            data.setdefault(field,value)
-            if value != "" and not value.startswith('CVE-') and not value.startswith('UEM-') and not value.startswith('EMB-'):
-                msg += "%s: unknown Candidate '%s' (must be /(CVE|UEM|EMB)-/)\n" % (cve, value)
+            data.setdefault(field, value)
+            if value != "" and not value.startswith('CVE-') and \
+               not value.startswith('UEM-') and not value.startswith('EMB-'):
+                msg += ("%s: unknown Candidate '%s' (must be "
+                        "/(CVE|UEM|EMB)-/)\n" % (cve, value))
                 code = EXIT_FAIL
         elif 'Priority' in field:
             # For now, throw away comments on Priority fields
@@ -88,25 +92,26 @@ def load_cve(cve, strict=False):
                 value = value.split()[0]
             if 'Priority_' in field:
                 try:
-                    foo, pkg = field.split('_',1)
+                    foo, pkg = field.split('_', 1)
                 except ValueError:
-                    msg += "%s: bad field with 'Priority_': '%s'\n" % (cve, field)
+                    msg += ("%s: bad field with 'Priority_': '%s'\n" %
+                            (cve, field))
                     code = EXIT_FAIL
                     continue
-            data.setdefault(field,value)
+            data.setdefault(field, value)
         elif 'Patches_' in field:
             '''These are raw fields'''
             try:
-                foo, pkg = field.split('_',1)
+                foo, pkg = field.split('_', 1)
             except ValueError:
                 msg += "%s: bad field with 'Patches_': '%s'\n" % (cve, field)
                 code = EXIT_FAIL
                 continue
-            data.setdefault(field,value)
+            data.setdefault(field, value)
         elif 'Tags_' in field:
             '''These are processed into the "tags" hash'''
             try:
-                foo, pkg = field.split('_',1)
+                foo, pkg = field.split('_', 1)
             except ValueError:
                 msg += "%s: bad field with 'Tags_': '%s'\n" % (cve, field)
                 code = EXIT_FAIL
@@ -116,15 +121,16 @@ def load_cve(cve, strict=False):
                 data['tags'][pkg].add(word)
         elif '_' in field:
             try:
-                release, pkg = field.split('_',1)
+                release, pkg = field.split('_', 1)
             except ValueError:
                 msg += "%s: bad field with '_': '%s'\n" % (cve, field)
                 code = EXIT_FAIL
                 continue
             try:
-                info = value.split(' ',1)
+                info = value.split(' ', 1)
             except ValueError:
-                msg += "%s: missing state for '%s': '%s'\n" % (cve, field, value)
+                msg += ("%s: missing state for '%s': '%s'\n" %
+                        (cve, field, value))
                 code = EXIT_FAIL
                 continue
             state = info[0]
@@ -145,30 +151,32 @@ def load_cve(cve, strict=False):
                 notes = state
                 state = 'released'
 
-            if state not in ['needs-triage','needed','active','pending','released','deferred','DNE','ignored','not-affected']:
-                msg += "%s: %s_%s has unknown state: '%s'\n" % (cve, release, pkg, state)
+            if state not in ['needs-triage', 'needed', 'active', 'pending',
+                             'released', 'deferred', 'DNE', 'ignored',
+                             'not-affected']:
+                msg += ("%s: %s_%s has unknown state: '%s'\n" %
+                        (cve, release, pkg, state))
                 code = EXIT_FAIL
 
-            # Verify "released" kernels have version notes
-            #if state == 'released' and pkg in kernel_srcs and notes == '':
-            #    msg += "%s: %s_%s has state '%s' but lacks version note\n" % (cve, release, pkg, state)
-            #    code = EXIT_FAIL
-
             # Verify "active" states have an Assignee
             if state == 'active' and data['Assigned-to'].strip() == "":
-                msg += "%s: %s_%s has state '%s' but lacks 'Assigned-to'\n" % (cve, release, pkg, state)
+                msg += ("%s: %s_%s has state '%s' but lacks 'Assigned-to'\n" %
+                        (cve, release, pkg, state))
                 code = EXIT_FAIL
 
-            affected.setdefault(pkg,dict())
-            affected[pkg].setdefault(release,[state,notes])
-        elif field not in ['References', 'Description', 'Ubuntu-Description', 'Notes', 'Bugs', 'Assigned-to', 'Approved-by', 'PublicDate', 'PublicDateAtUSN', 'CRD', 'Discovered-by']:
+            affected.setdefault(pkg, dict())
+            affected[pkg].setdefault(release, [state, notes])
+        elif field not in ['References', 'Description', 'Ubuntu-Description',
+                           'Notes', 'Bugs', 'Assigned-to', 'Approved-by',
+                           'PublicDate', 'PublicDateAtUSN', 'CRD',
+                           'Discovered-by']:
             msg += "%s: unknown field '%s'\n" % (cve, field)
             code = EXIT_FAIL
         else:
-            data.setdefault(field,value)
+            data.setdefault(field, value)
 
     # Check for required fields
-    for field in ['Candidate','PublicDate','Description']:
+    for field in ['Candidate', 'PublicDate', 'Description']:
         if field not in data:
             msg += "%s: missing field '%s'\n" % (cve, field)
             code = EXIT_FAIL
@@ -181,7 +189,7 @@ def load_cve(cve, strict=False):
 
     # Fill in defaults for missing fields
     if 'Priority' not in data:
-        data.setdefault('Priority','untriaged')
+        data.setdefault('Priority', 'untriaged')
     # Perform override fields
     if 'PublicDateAtUSN' in data:
         data['PublicDate'] = data['PublicDateAtUSN']
@@ -194,9 +202,11 @@ def load_cve(cve, strict=False):
         raise ValueError(msg.strip())
     return data
 
+
 class NonKernelIssue(Exception):
     pass
 
+
 def load_ubuntu_issue(f):
     ubu_issue = load_cve(f)
     issue = {}
@@ -249,6 +259,7 @@ def load_ubuntu_issue(f):
 
     return issue
 
+
 # Ubuntu doesn't seem to retire issues any more, so only include issues
 # that are active and discovered either this year or last year
 def get_recent_issues():
@@ -259,13 +270,15 @@ def get_recent_issues():
         if year >= this_year - 1:
             yield (cve_id, filename)
 
+
 def main():
     os.makedirs(IMPORT_DIR, 0o777, exist_ok=True)
     if os.path.isdir(IMPORT_DIR + '/.bzr'):
         subprocess.check_call(['bzr', 'update'], cwd=IMPORT_DIR)
     else:
-        subprocess.check_call(['bzr', 'checkout', 'lp:ubuntu-cve-tracker', '.'],
-                              cwd=IMPORT_DIR)
+        subprocess.check_call(
+            ['bzr', 'checkout', 'lp:ubuntu-cve-tracker', '.'],
+            cwd=IMPORT_DIR)
 
     our_issues = set(kernel_sec.issue.get_list())
     their_issues = dict(get_recent_issues())
@@ -293,9 +306,9 @@ def main():
             # Copy theirs
             ours = theirs
         else:
-            # Merge into ours
+            # Check that it's good to start with, then merge into ours
             ours = kernel_sec.issue.load(cve_id)
-            kernel_sec.issue.validate(ours) # check that it's good to start with
+            kernel_sec.issue.validate(ours)
             if not kernel_sec.issue.merge_into(ours, theirs):
                 continue
 
@@ -307,5 +320,6 @@ def main():
 
         kernel_sec.issue.save(cve_id, ours)
 
+
 if __name__ == '__main__':
     main()


=====================================
scripts/kernel_sec/branch.py
=====================================
@@ -4,18 +4,25 @@
 # Public License, Version 3 or later. See http://www.gnu.org/copyleft/gpl.html
 # for details.
 
+import io
 import re
 import subprocess
 
+from . import version
+
+
 _STABLE_BRANCH_RE = re.compile(r'^linux-([\d.]+)\.y$')
 
+
 def get_base_ver_stable_branch(base_ver):
     return 'linux-%s.y' % base_ver
 
+
 def get_stable_branch_base_ver(branch_name):
     match = _STABLE_BRANCH_RE.match(branch_name)
     return match and match.group(1)
 
+
 def get_stable_branches(git_repo, remote_name='stable'):
     branches = []
 
@@ -36,6 +43,7 @@ def get_stable_branches(git_repo, remote_name='stable'):
 
     return branches
 
+
 def get_live_stable_branches(*args, **kwargs):
     # TODO: Pull list of longterm branches from
     # https://www.kernel.org/category/releases.html ?
@@ -61,3 +69,49 @@ def get_live_stable_branches(*args, **kwargs):
 
     return [branch_name for branch_name in get_stable_branches(*args, **kwargs)
             if branch_name not in dead_branches]
+
+
+def get_sort_key(branch):
+    if branch == 'mainline':
+        return [1000000]
+    base_ver = get_stable_branch_base_ver(branch)
+    assert base_ver is not None
+    return version.get_sort_key(base_ver)
+
+
+def _get_commits(git_repo, end, start=None):
+    if start:
+        list_expr = '%s..%s' % (start, end)
+    else:
+        list_expr = end
+
+    list_proc = subprocess.Popen(['git', 'rev-list', list_expr],
+                                 cwd=git_repo, stdout=subprocess.PIPE)
+    for line in io.TextIOWrapper(list_proc.stdout):
+        yield line.rstrip('\n')
+
+
+class CommitBranchMap:
+    def __init__(self, git_repo, mainline_remote_name, branch_names):
+        # Generate sort key for each branch
+        self._branch_sort_key = {
+            branch: get_sort_key(branch) for branch in branch_names
+        }
+
+        # Generate sort key for each commit
+        self._commit_sort_key = {}
+        start = None
+        for branch in sorted(branch_names, key=get_sort_key):
+            if branch == 'mainline':
+                end = '%s/master' % mainline_remote_name
+            else:
+                base_ver = get_stable_branch_base_ver(branch)
+                assert base_ver is not None
+                end = 'v' + base_ver
+            for commit in _get_commits(git_repo, end, start):
+                self._commit_sort_key[commit] = self._branch_sort_key[branch]
+            start = end
+
+    def is_commit_in_branch(self, commit, branch):
+        return commit in self._commit_sort_key and \
+            self._commit_sort_key[commit] <= self._branch_sort_key[branch]


=====================================
scripts/kernel_sec/issue.py
=====================================
@@ -13,21 +13,27 @@ import yaml
 import yaml.dumper
 import yaml.loader
 
+
 # Only SHA-1 for now
 _GIT_HASH_RE = re.compile(r'^[0-9a-f]{40}$')
+
+
 def is_git_hash(s):
     return _GIT_HASH_RE.match(s) is not None
 
+
 def _validate_string(name, value):
     if type(value) is str:
         return
     raise ValueError('%s must be a string' % name)
 
+
 def _validate_datetime(name, value):
     if type(value) is datetime.datetime:
         return
     raise ValueError('%s must be an ISO8601 date and time' % name)
 
+
 def _validate_sequence_string(name, value):
     if type(value) is list:
         for entry in value:
@@ -37,6 +43,7 @@ def _validate_sequence_string(name, value):
             return
     raise ValueError('%s must be a sequence of strings' % name)
 
+
 def _validate_mapping_string(name, value):
     if type(value) is dict:
         for v in value.values():
@@ -46,6 +53,7 @@ def _validate_mapping_string(name, value):
             return
     raise ValueError('%s must be a mapping to strings' % name)
 
+
 def _validate_mapping_sequence_hash(name, value):
     if type(value) is dict:
         for seq in value.values():
@@ -55,15 +63,16 @@ def _validate_mapping_sequence_hash(name, value):
                 break
             for entry in seq:
                 if type(entry) is not str or not is_git_hash(entry):
-                    break # to outer break
+                    break  # to outer break
             else:
                 continue
-            break # to top level
+            break  # to top level
         else:
             return
     raise ValueError('%s must be a mapping to sequences of git hashes' %
                      name)
 
+
 def _validate_hashmapping_string(name, value):
     if type(value) is dict:
         for h, v in value.items():
@@ -76,6 +85,7 @@ def _validate_hashmapping_string(name, value):
     raise ValueError('%s must be a mapping from git hashes to strings' %
                      name)
 
+
 _ALL_FIELDS = [
     ('description',     _validate_string),
     ('advisory',        _validate_string),
@@ -94,6 +104,7 @@ _FIELD_VALIDATOR = dict(_ALL_FIELDS)
 _FIELD_ORDER = dict((name, i) for i, (name, _) in enumerate(_ALL_FIELDS))
 _REQUIRED_FIELDS = ['description']
 
+
 def validate(issue):
     for name in _REQUIRED_FIELDS:
         if name not in issue:
@@ -107,6 +118,7 @@ def validate(issue):
         else:
             validator(name, value)
 
+
 def merge_into(ours, theirs):
     changed = False
 
@@ -161,6 +173,7 @@ def merge_into(ours, theirs):
 
     return changed
 
+
 class _IssueDumper(yaml.dumper.SafeDumper):
     # Write strings as UTF-8, not ASCII with escapes
     def __init__(self, *args, **kwargs):
@@ -174,8 +187,8 @@ class _IssueDumper(yaml.dumper.SafeDumper):
         finally:
             del self.__root
 
-    # ISO 8601 specifies 'T' to separate date & time, but for some reason PyYAML
-    # uses ' ' by default
+    # ISO 8601 specifies 'T' to separate date & time, but for some reason
+    # PyYAML uses ' ' by default
     def represent_datetime(self, data):
         return self.represent_scalar('tag:yaml.org,2002:timestamp',
                                      data.isoformat())
@@ -205,15 +218,18 @@ class _IssueDumper(yaml.dumper.SafeDumper):
 
         return super().represent_sequence(tag, sequence, flow_style)
 
-_IssueDumper.add_representer(datetime.datetime, _IssueDumper.represent_datetime)
+
+_IssueDumper.add_representer(datetime.datetime,
+                             _IssueDumper.represent_datetime)
 _IssueDumper.add_representer(str, _IssueDumper.represent_str)
 
+
 class _IssueLoader(yaml.loader.SafeLoader):
     # Keep timezone information instead of adjusting the timestamp and then
     # discarding it.
     def construct_yaml_timestamp(self, node):
         value = self.construct_scalar(node)
-        match = self.timestamp_regexp.match(node.value)
+        match = self.timestamp_regexp.match(value)
         values = match.groupdict()
         year = int(values['year'])
         month = int(values['month'])
@@ -243,32 +259,73 @@ class _IssueLoader(yaml.loader.SafeLoader):
         return datetime.datetime(year, month, day, hour, minute, second,
                                  fraction, tzinfo)
 
+
 _IssueLoader.add_constructor('tag:yaml.org,2002:timestamp',
                              _IssueLoader.construct_yaml_timestamp)
 
+
 def load_filename(name):
     with open(name) as f:
         return yaml.load(f, Loader=_IssueLoader)
 
+
 def save_filename(name, issue):
     with open(name, 'w') as f:
         yaml.dump(issue, f, Dumper=_IssueDumper)
 
+
 def get_list():
-    return [os.path.basename(name)[:-4] for name in glob.glob('issues/CVE-*.yml')]
+    return [os.path.basename(name)[:-4]
+            for name in glob.glob('issues/CVE-*.yml')]
+
 
 def get_filename(cve_id):
     return 'issues/%s.yml' % cve_id
 
+
 def load(cve_id):
     return load_filename(get_filename(cve_id))
 
+
 def save(cve_id, issue):
     save_filename(get_filename(cve_id), issue)
 
+
 # Match the "arbitrary digits" after the year
 _cve_id_arbdig_re = re.compile(r'-(\d+)$')
 
+
 # Pad "arbitrary digits" to 6 digits so string comparison works
 def get_id_sort_key(cve_id):
     return _cve_id_arbdig_re.sub(lambda m: '-%06d' % int(m.group(1)), cve_id)
+
+
+def affects_branch(issue, branch, is_commit_in_branch):
+    # If it was not introduced on this branch, and was introduced on
+    # mainline after the branch point, branch is not affected
+    introduced = issue.get('introduced-by')
+    if introduced:
+        if introduced.get('mainline') == 'never' and \
+           (branch == 'mainline' or branch not in introduced):
+            return False
+        if branch not in introduced:
+            for commit in introduced['mainline']:
+                if is_commit_in_branch(commit, branch):
+                    break
+            else:
+                return False
+
+    # If it was fixed on this branch, or fixed on mainline before
+    # the branch point, branch is not affected
+    fixed = issue.get('fixed-by', {})
+    if fixed:
+        if fixed.get(branch, 'never') != 'never':
+            return False
+        if fixed.get('mainline', 'never') != 'never':
+            for commit in fixed['mainline']:
+                if not is_commit_in_branch(commit, branch):
+                    break
+            else:
+                return False
+
+    return True


=====================================
scripts/kernel_sec/version.py
=====================================
@@ -6,8 +6,10 @@
 
 import re
 
+
 _RC_RE = re.compile('-rc(\d+)$')
 
+
 def _split(ver_str):
     # Split off any '-rc' part; split rest@dots; map to integers
     match = _RC_RE.search(ver_str)
@@ -18,6 +20,7 @@ def _split(ver_str):
         rc_n = None
     return [int(comp) for comp in ver_str.split('.')], rc_n
 
+
 def get_sort_key(ver_str):
     # Treat x -rc y as (x-1), (large), y so it sorts between x-1 stable updates
     # and x


=====================================
scripts/report_affected.py
=====================================
@@ -9,26 +9,15 @@
 # Report issues affecting each stable branch.
 
 import argparse
-import io
-import re
 import subprocess
-import sys
 
-import kernel_sec.branch, kernel_sec.issue, kernel_sec.version
+import kernel_sec.branch
+import kernel_sec.issue
+import kernel_sec.version
 
-def get_commits(git_repo, end, start=None):
-    if start:
-        list_expr = '%s..%s' % (start, end)
-    else:
-        list_expr = end
-
-    list_proc = subprocess.Popen(['git', 'rev-list', list_expr],
-                                 cwd=git_repo, stdout=subprocess.PIPE)
-    for line in io.TextIOWrapper(list_proc.stdout):
-        yield line.rstrip('\n')
 
-def main(git_repo, mainline_remote_name, stable_remote_name, only_fixed_upstream,
-         include_ignored, *branch_names):
+def main(git_repo, mainline_remote_name, stable_remote_name,
+         only_fixed_upstream, include_ignored, *branch_names):
     if branch_names:
         # Support stable release strings as shorthand for stable branches
         branch_names = [kernel_sec.branch.get_base_ver_stable_branch(name)
@@ -40,90 +29,45 @@ def main(git_repo, mainline_remote_name, stable_remote_name, only_fixed_upstream
         if not only_fixed_upstream:
             branch_names.append('mainline')
 
-    # Generate sort key for each branch
-    branch_sort_key = {}
-    for branch in branch_names:
-        if branch == 'mainline':
-            branch_sort_key[branch] = [1000000]
-        else:
-            base_ver = kernel_sec.branch.get_stable_branch_base_ver(branch)
-            assert base_ver is not None
-            branch_sort_key[branch] = kernel_sec.version.get_sort_key(base_ver)
-
-    branch_names.sort(key=(lambda branch: branch_sort_key[branch]))
-
-    # Generate sort key for each commit
-    commit_sort_key = {}
-    start = None
-    for branch in branch_names:
-        if branch == 'mainline':
-            end = '%s/master' % mainline_remote_name
-        else:
-            base_ver = kernel_sec.branch.get_stable_branch_base_ver(branch)
-            assert base_ver is not None
-            end = 'v' + base_ver
-        for commit in get_commits(git_repo, end, start):
-            commit_sort_key[commit] = branch_sort_key[branch]
-        start = end
+    branch_names.sort(key=kernel_sec.branch.get_sort_key)
+
+    c_b_map = kernel_sec.branch.CommitBranchMap(git_repo, mainline_remote_name,
+                                                branch_names)
 
     branch_issues = {}
     issues = set(kernel_sec.issue.get_list())
 
     for cve_id in issues:
         issue = kernel_sec.issue.load(cve_id)
+        ignore = issue.get('ignore', {})
+        fixed = issue.get('fixed-by', {})
 
-        for branch in branch_names:
-            # If it was not introduced on this branch, and was introduced on
-            # mainline after the branch point, branch is not affected
-            introduced = issue.get('introduced-by')
-            if introduced:
-                if introduced.get('mainline') == 'never' and \
-                   (branch == 'mainline' or branch not in introduced):
-                    continue
-                if branch not in introduced:
-                    for commit in introduced['mainline']:
-                        if commit in commit_sort_key \
-                           and commit_sort_key[commit] <= branch_sort_key[branch]:
-                            break
-                    else:
-                        continue
-
-            # Check whether it is ignored on this branch, unless we're
-            # overriding that
-            ignore = issue.get('ignore', {})
-            if not include_ignored and (ignore.get('all') or ignore.get(branch)):
-                continue
-
-            fixed = issue.get('fixed-by', {})
+        # Should this issue be ignored?
+        if (not include_ignored and ignore.get('all')) or \
+           (only_fixed_upstream and fixed.get('mainline', 'never') == 'never'):
+            continue
 
-            if only_fixed_upstream and fixed.get('mainline', 'never') == 'never':
+        for branch in branch_names:
+            # Should this issue be ignored for this branch?
+            if not include_ignored and ignore.get(branch):
                 continue
 
-            # If it was fixed on this branch, or fixed on mainline before
-            # the branch point, branch is not affected
-            if fixed:
-                if fixed.get(branch, 'never') != 'never':
-                    continue
-                if fixed.get('mainline', 'never') != 'never':
-                    for commit in fixed['mainline']:
-                        if commit not in commit_sort_key \
-                           or commit_sort_key[commit] > branch_sort_key[branch]:
-                            break
-                    else:
-                        continue
-
-            branch_issues.setdefault(branch, []).append(cve_id)
+            if kernel_sec.issue.affects_branch(
+                    issue, branch, c_b_map.is_commit_in_branch):
+                branch_issues.setdefault(branch, []).append(cve_id)
 
     for branch in branch_names:
         print('%s:' % branch, *sorted(branch_issues.get(branch, []),
                                       key=kernel_sec.issue.get_id_sort_key))
 
+
 if __name__ == '__main__':
     parser = argparse.ArgumentParser(
         description='Report unfixed CVEs in Linux kernel branches.')
     parser.add_argument('--git-repo',
                         dest='git_repo', default='../kernel',
-                        help='git repository from which to read commit logs (default: ../kernel)',
+                        help=('git repository from which to read commit logs '
+                              '(default: ../kernel)'),
                         metavar='DIRECTORY')
     parser.add_argument('--mainline-remote',
                         dest='mainline_remote_name', default='torvalds',
@@ -131,7 +75,8 @@ if __name__ == '__main__':
                         metavar='NAME')
     parser.add_argument('--stable-remote',
                         dest='stable_remote_name', default='stable',
-                        help='git remote for stable branches (default: stable)',
+                        help=('git remote for stable branches '
+                              '(default: stable)'),
                         metavar='NAME')
     parser.add_argument('--only-fixed-upstream',
                         action='store_true',
@@ -141,7 +86,8 @@ if __name__ == '__main__':
                         help='include issues that have been marked as ignored')
     parser.add_argument('branches',
                         nargs='*',
-                        help='specific branch to report on (default: all active branches)',
+                        help=('specific branch to report on '
+                              '(default: all active branches)'),
                         metavar='BRANCH')
     args = parser.parse_args()
     main(args.git_repo, args.mainline_remote_name, args.stable_remote_name,


=====================================
scripts/templates/branch.html
=====================================
@@ -1,5 +1,11 @@
+<link rel="stylesheet" href="/static/style.css">
 <title>Branch {{ name }}</title>
 <h1>Branch {{ name }}</h1>
-<p>
-  There should be a list of issues here...
-</p>
+<ul>
+  {% for cve_id, issue in issues %}
+  <li class="{% if issue.ignore and (issue.ignore.all or issue.ignore[name]) %}ignored{% endif %}">
+    <a href="/issues/{{ cve_id }}/">{{ cve_id }}</a> -
+    {{ issue.description|truncate(100) }}
+  </li>
+  {% endfor %}
+</ul>


=====================================
scripts/templates/branches.html
=====================================
@@ -1,3 +1,4 @@
+<link rel="stylesheet" href="/static/style.css">
 <title>Branches</title>
 <h1>Branches</h1>
 <p>


=====================================
scripts/templates/issue.html
=====================================
@@ -1,3 +1,4 @@
+<link rel="stylesheet" href="/static/style.css">
 <title>{{ cve_id }} - {{ issue.description|truncate(50) }}</title>
 <h1>{{ cve_id }} - {{ issue.description|truncate(50) }}</h1>
 <h2>Summary</h2>
@@ -10,6 +11,7 @@
   {% if issue.references %}
   <tr>
     <th>References</th>
+    <td/>
     <td>
       {% for url in issue.references %}
       <a href="{{ url }}">{{ url }}</a>
@@ -21,6 +23,7 @@
   {% if issue.aliases %}
   <tr>
     <th>Aliases</th>
+    <td/>
     <td>
       {% for alias in issue.aliases %}
       {{ alias }}{% if not loop.last %},{% endif %}  
@@ -30,18 +33,25 @@
   {% endif %}
   {% if issue.comments %}
   <tr>
-    <th>Comments</th>
+    <th rowspan={{ issue.comments|length }}>Comments</th>
+    {% for handle in issue.comments %}
+    <th>
+      {{ handle }}
+    </th>
     <td>
-      {% for handle in issue.comments %}
-      {{ handle }}: <q>{{ issue.comments[handle] }}</q>
-      {% if not loop.last %}<br/>{% endif %}
-      {% endfor %}
+      <q>{{ issue.comments[handle] }}</q>
     </td>
+    {% if not loop.last %}
+  </tr>
+  <tr>
+    {% endif %}
+    {% endfor %}
   </tr>
   {% endif %}
   {% if issue.reporters %}
   <tr>
     <th>Reporters</th>
+    <td/>
     <td>
       {% for rep in issue.reporters %}
       {# This may include an email address which could be linked #}
@@ -53,6 +63,7 @@
   {% if issue['embargo-end'] %}
   <tr>
     <th>Embargo</th>
+    <td/>
     <td>
       {# TODO: If embargo-end is in the future we should prominently
       flag this issue as embargoed #}
@@ -62,35 +73,46 @@
   {% endif %}
   {% if issue['introduced-by'] %}
   <tr>
-    <th>Introduced by</th>
+    <th rowspan={{ issue['introduced-by']|length }}>Introduced by</th>
+    {% for branch in issue['introduced-by'] %}
+    <th>
+      {{ branch }}
+    </th>
     <td>
-      {% for branch in issue['introduced-by'] %}
-      {{ branch }}:
       {% for commit in issue['introduced-by'][branch] %}
       <a href="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit?id={{ commit }}">{{ commit[:12] }}</a>{% if not loop.last %},{% endif %}
       {% endfor %}
-      {% if not loop.last %}<br/>{% endif %}
-      {% endfor %}
     </td>
+    {% if not loop.last %}
+  </tr>
+  <tr>
+    {% endif %}
+    {% endfor %}
   </tr>
   {% endif %}
   {% if issue['fixed-by'] %}
   <tr>
-    <th>Fixed by</th>
+    <th rowspan={{ issue['fixed-by']|length }}>Fixed by</th>
+    {% for branch in issue['fixed-by'] %}
+    <th>
+      {{ branch }}
+    </th>
     <td>
-      {% for branch in issue['fixed-by'] %}
-      {{ branch }}:
       {% for commit in issue['fixed-by'][branch] %}
       <a href="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit?id={{ commit }}">{{ commit[:12] }}</a>{% if not loop.last %},{% endif %}
       {% endfor %}
-      {% if not loop.last %}<br/>{% endif %}
-      {% endfor %}
     </td>
+    {% if not loop.last %}
+  </tr>
+  <tr>
+    {% endif %}
+    {% endfor %}
   </tr>
   {% endif %}
   {% if issue['fix-depends-on'] %}
   <tr>
     <th>Fix depends on</th>
+    <td/>
     <td>
       {% for commit in issue['fix-depends-on'] %}
       <a href="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit?id={{ commit }}">{{ commit[:12] }}</a>
@@ -100,5 +122,26 @@
     </td>
   </tr>
   {% endif %}
+  <tr>
+    <th rowspan={{ branches|length }}>Status</th>
+    {% for name, affected in branches %}
+    <th>
+      <a href="/branch/{{ name }}/">{{ name }}</a>
+    </th>
+    <td>
+      {% if not affected %}
+      {# Currently we don't distinguish between never-affected or fixed #}
+      <span class="good">not affected</span>
+      {% elif issue.ignore and (issue.ignore.all or issue.ignore[name]) %}
+      <span class="ignored">ignored</span>
+      {% else %}
+      <span class="bad">vulnerable</span>
+      {% endif %}
+    </td>
+    {% if not loop.last %}
+  </tr>
+  <tr>
+    {% endif %}
+    {% endfor %}
+  </tr>
 </table>
-{# TODO: show issue status for each branch #}


=====================================
scripts/templates/issues.html
=====================================
@@ -1,7 +1,11 @@
+<link rel="stylesheet" href="/static/style.css">
 <title>Issues</title>
 <h1>Issues</h1>
 <ul>
-  {% for cve_id in cve_ids %}
-  <li><a href="{{ cve_id }}/">{{ cve_id }}</a></li>
+  {% for cve_id, issue in cve_ids %}
+  <li class="{% if issue.ignore and issue.ignore.all %}ignored{% endif %}">
+    <a href="{{ cve_id }}/">{{ cve_id }}</a> -
+    {{ issue.description|truncate(100) }}
+  </li>
   {% endfor %}
 </ul>


=====================================
scripts/templates/root.html
=====================================
@@ -1,3 +1,4 @@
+<link rel="stylesheet" href="/static/style.css">
 <title>Kernel security tracker</title>
 <h1>Kernel security tracker</h1>
 <p>


=====================================
scripts/templates/style.css
=====================================
@@ -0,0 +1,44 @@
+body {
+    color: #000000;
+    background-color: #ffffff;
+}
+:link {
+    color: #0000ff;
+}
+:visited {
+    color: #8000c0;
+}
+
+.ignored {
+    color: #666666;
+}
+.ignored > :link {
+    color: #6666ff;
+}
+.ignored > :visited {
+    color: #b366d9;
+}
+
+.good {
+    color: #33cc33;
+}
+.bad {
+    color: #ff0000;
+}
+
+table {
+    border-collapse: collapse;
+}
+tr {
+    border-top: solid 1px;
+    border-bottom: solid 1px;
+}
+th {
+    text-align: right;
+    vertical-align: top;
+    white-space: nowrap;
+}
+th, td {
+    padding-left: 0.5em;
+    padding-right: 0.5em;
+}


=====================================
scripts/validate.py
=====================================
@@ -9,11 +9,11 @@
 import argparse
 import sys
 
-from kernel_sec.issue import get_filename, get_list, load, load_filename, validate
+from kernel_sec.issue \
+    import get_filename, get_list, load_filename, validate
 
-def main(*names):
-    import glob
 
+def main(*names):
     rc = 0
     if len(names) == 0:
         names = [get_filename(cve_id) for cve_id in get_list()]
@@ -27,6 +27,7 @@ def main(*names):
 
     sys.exit(rc)
 
+
 if __name__ == '__main__':
     parser = argparse.ArgumentParser(
         description='Validate issue files against the schema.')


=====================================
scripts/webview.py
=====================================
@@ -12,7 +12,8 @@ import os
 import cherrypy
 import jinja2
 
-import kernel_sec.branch, kernel_sec.issue
+import kernel_sec.branch
+import kernel_sec.issue
 
 
 _template_env = jinja2.Environment(
@@ -33,7 +34,8 @@ class IssueCache:
         return cache_data
 
     def _refresh_keys(self):
-        return self._refresh('issues', lambda: set(kernel_sec.issue.get_list()))
+        return self._refresh('issues',
+                             lambda: set(kernel_sec.issue.get_list()))
 
     def _refresh_issue(self, cve_id):
         filename = kernel_sec.issue.get_filename(cve_id)
@@ -58,66 +60,97 @@ _issue_cache = IssueCache()
 class Branch:
     _template = _template_env.get_template('branch.html')
 
-    def __init__(self, branch):
+    def __init__(self, name, root):
         self._name = name
+        self._root = root
 
     @cherrypy.expose
     def index(self):
-        return self._template.render(name=self._name)
+        return self._template.render(
+            name=self._name,
+            issues=[
+                (cve_id, _issue_cache[cve_id])
+                for cve_id in sorted(_issue_cache.keys(),
+                                     key=kernel_sec.issue.get_id_sort_key)
+                if kernel_sec.issue.affects_branch(
+                        _issue_cache[cve_id], self._name,
+                        self._root.is_commit_in_branch)
+            ])
 
 
 class Branches:
     _template = _template_env.get_template('branches.html')
 
-    def __init__(self, git_repo, mainline_remote_name, stable_remote_name):
-        self._names = kernel_sec.branch.get_live_stable_branches(
-            git_repo, stable_remote_name)
-        self._names.append('mainline')
+    def __init__(self, root):
+        self._root = root
 
     def _cp_dispatch(self, vpath):
-        if len(vpath) == 1 and vpath[0] in self._branches:
-            return Branch(vpath.pop())
+        if len(vpath) == 1 and vpath[0] in self._root.branch_names:
+            return Branch(vpath.pop(), self._root)
         return vpath
 
     @cherrypy.expose
     def index(self):
-        return self._template.render(names=self._names)
+        return self._template.render(names=self._root.branch_names)
 
 
 class Issue:
     _template = _template_env.get_template('issue.html')
 
-    def __init__(self, cve_id):
+    def __init__(self, cve_id, root):
         self._cve_id = cve_id
+        self._root = root
 
     @cherrypy.expose
     def index(self):
-        return self._template.render(cve_id=self._cve_id,
-                                     issue=_issue_cache[self._cve_id])
+        issue = _issue_cache[self._cve_id]
+        return self._template.render(
+            cve_id=self._cve_id,
+            issue=issue,
+            branches=[
+                (name,
+                 kernel_sec.issue.affects_branch(
+                     issue, name, self._root.is_commit_in_branch))
+                for name in self._root.branch_names
+            ])
 
 
 class Issues:
     _template = _template_env.get_template('issues.html')
 
+    def __init__(self, root):
+        self._root = root
+
     def _cp_dispatch(self, vpath):
         if len(vpath) == 1 and vpath[0] in _issue_cache:
-            return Issue(vpath.pop())
+            return Issue(vpath.pop(), self._root)
         return vpath
 
     @cherrypy.expose
     def index(self):
         return self._template.render(
-            cve_ids=sorted(_issue_cache.keys(),
-                           key=kernel_sec.issue.get_id_sort_key))
+            cve_ids=[
+                (cve_id, _issue_cache[cve_id])
+                for cve_id in sorted(_issue_cache.keys(),
+                                     key=kernel_sec.issue.get_id_sort_key)
+            ])
 
 
 class Root:
     _template = _template_env.get_template('root.html')
 
     def __init__(self, git_repo, mainline_remote_name, stable_remote_name):
-        self.branches = Branches(git_repo, mainline_remote_name,
-                                 stable_remote_name)
-        self.issues = Issues()
+        self.branch_names = kernel_sec.branch.get_live_stable_branches(
+            git_repo, stable_remote_name)
+        self.branch_names.append('mainline')
+        self.branch_names.sort(key=kernel_sec.branch.get_sort_key)
+
+        c_b_map = kernel_sec.branch.CommitBranchMap(
+            git_repo, mainline_remote_name, self.branch_names)
+        self.is_commit_in_branch = c_b_map.is_commit_in_branch
+
+        self.branches = Branches(self)
+        self.issues = Issues(self)
 
     def _cp_dispatch(self, vpath):
         if vpath[0] == 'branch':
@@ -138,7 +171,8 @@ if __name__ == '__main__':
         description='Report unfixed CVEs in Linux kernel branches.')
     parser.add_argument('--git-repo',
                         dest='git_repo', default='../kernel',
-                        help='git repository from which to read commit logs (default: ../kernel)',
+                        help=('git repository from which to read commit logs '
+                              '(default: ../kernel)'),
                         metavar='DIRECTORY')
     parser.add_argument('--mainline-remote',
                         dest='mainline_remote_name', default='torvalds',
@@ -146,8 +180,20 @@ if __name__ == '__main__':
                         metavar='NAME')
     parser.add_argument('--stable-remote',
                         dest='stable_remote_name', default='stable',
-                        help='git remote for stable branches (default: stable)',
+                        help=('git remote for stable branches '
+                              '(default: stable)'),
                         metavar='NAME')
     args = parser.parse_args()
+
+    conf = {
+        '/static/style.css': {
+            'tools.staticfile.on': True,
+            'tools.staticfile.filename':
+            os.path.abspath('scripts/templates/style.css')
+        }
+    }
+
     cherrypy.quickstart(Root(args.git_repo, args.mainline_remote_name,
-                             args.stable_remote_name))
+                             args.stable_remote_name),
+                        '/',
+                        conf)



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/58186e1acfa101dcba098736188ba445fb23fcd7...c4d3bc0b2ec59720acd1d5ab5d35904538fd1ffe

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/58186e1acfa101dcba098736188ba445fb23fcd7...c4d3bc0b2ec59720acd1d5ab5d35904538fd1ffe
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20181118/be04f5e6/attachment-0001.html>
