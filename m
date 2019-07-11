From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Thu, 11 Jul 2019 05:02:40 +0000
Subject: [cip-dev] [cip-kernel-sec][RESEND v2 1/2] report_affected:
	add	support for reporting on tags
In-Reply-To: <20190711044425.30128-2-daniel.sangorrin@toshiba.co.jp>
References: <20190711044425.30128-1-daniel.sangorrin@toshiba.co.jp>
	<20190711044425.30128-2-daniel.sangorrin@toshiba.co.jp>
Message-ID: <OSBPR01MB3077BF16D928E16E7A797DD1D0F30@OSBPR01MB3077.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> +    for branch in branches:
> +        esc_base_ver = branch['base_ver'].replace('.', re.escape('.'))
> +        # example tags: v4.4, v4.19.12
> +        tag_regexp = r'(^v%s$|^v%s\.\d+$)' % (esc_base_ver, esc_base_ver)
> +        branch['tag_regexp'] = tag_regexp
> +

Sorry, I went too fast. I should have moved the regexp to get_base_ver_stable_branch. I will resend.

Thanks,
Daniel


>      branches.extend(_get_configured_branches('conf/branches.yml'))
>      branches.extend(
>          _get_configured_branches(
> @@ -141,7 +148,7 @@ def get_sort_key(branch):
>      return version.get_sort_key(base_ver)
> 
> 
> -def _get_commits(git_repo, end, start=None):
> +def iter_rev_list(git_repo, end, start=None):
>      if start:
>          list_expr = '%s..%s' % (start, end)
>      else:
> @@ -170,7 +177,7 @@ class CommitBranchMap:
>                                   branch['git_name'])
>              else:
>                  end = 'v' + branch['base_ver']
> -            for commit in _get_commits(git_repo, end, start):
> +            for commit in iter_rev_list(git_repo, end, start):
>                  self._commit_sort_key[commit] \
>                      = self._branch_sort_key[branch_name]
>              start = end
> diff --git a/scripts/report_affected.py b/scripts/report_affected.py
> index 0966fe1..27c39ef 100755
> --- a/scripts/report_affected.py
> +++ b/scripts/report_affected.py
> @@ -9,7 +9,9 @@
>  # Report issues affecting each stable branch.
> 
>  import argparse
> +import copy
>  import subprocess
> +import re
> 
>  import kernel_sec.branch
>  import kernel_sec.issue
> @@ -22,15 +24,38 @@ def main(git_repo, remotes,
>      if branch_names:
>          branches = []
>          for branch_name in branch_names:
> +            tag = None
>              if branch_name[0].isdigit():
>                  # 4.4 is mapped to linux-4.4.y
>                  name = 'linux-%s.y' % branch_name
> +            elif branch_name[0] == 'v':
> +                # an official tag, e.g. v4.4.92-cip11
> +                # infer branch from tag (regexp's must be specific)
> +                for branch in live_branches:
> +                    if 'tag_regexp' not in branch:
> +                        # no tag_regexp defined, or mainline
> +                        continue
> +
> +                    # predefined in branches.yml or a stable branch
> +                    if re.match(branch['tag_regexp'], branch_name):
> +                        tag = branch_name
> +                        name = branch['short_name']
> +                        break
> +                else:
> +                    raise ValueError('Failed to match tag %r' % branch_name)
> +            elif ':' in branch_name:
> +                # a possibly custom tag, e.g. linux-4.19.y-cip:myproduct-v1
> +                name, tag = branch_name.split(':', 1)
>              else:
>                  name = branch_name
> 
>              for branch in live_branches:
>                  if branch['short_name'] == name:
> -                    branches.append(branch)
> +                    # there could be multiple tags for the same branch
> +                    branch_copy = copy.deepcopy(branch)
> +                    if tag:
> +                        branch_copy['tag'] = tag
> +                    branches.append(branch_copy)
>                      break
>              else:
>                  msg = "Branch %s could not be found" % branch_name
> @@ -45,6 +70,18 @@ def main(git_repo, remotes,
> 
>      c_b_map = kernel_sec.branch.CommitBranchMap(git_repo, remotes, branches)
> 
> +    # cache tag commits and set full_name to show the tag
> +    tag_commits = {}
> +    for branch in branches:
> +        if 'tag' in branch:
> +            start = 'v' + branch['base_ver']
> +            end = branch['tag']
> +            tag_commits[end] = set(
> +                kernel_sec.branch.iter_rev_list(git_repo, end, start))
> +            branch['full_name'] = ':'.join([branch['short_name'], end])
> +        else:
> +            branch['full_name'] = branch['short_name']
> +
>      branch_issues = {}
>      issues = set(kernel_sec.issue.get_list())
> 
> @@ -65,15 +102,26 @@ def main(git_repo, remotes,
>              if not include_ignored and ignore.get(branch_name):
>                  continue
> 
> +            # Check if the branch is affected. If not and the issue was fixed
> +            # on that branch, then make sure the tag contains that fix
>              if kernel_sec.issue.affects_branch(
>                      issue, branch, c_b_map.is_commit_in_branch):
> -                branch_issues.setdefault(branch_name, []).append(cve_id)
> +                branch_issues.setdefault(
> +                    branch['full_name'], []).append(cve_id)
> +            elif 'tag' in branch and fixed:
> +                if fixed.get(branch_name, 'never') == 'never':
> +                    continue
> +                for commit in fixed[branch_name]:
> +                    if commit not in tag_commits[branch['tag']]:
> +                        branch_issues.setdefault(
> +                            branch['full_name'], []).append(cve_id)
> +                        break
> 
>      for branch in branches:
> -        branch_name = branch['short_name']
> -        print('%s:' % branch_name,
> -              *sorted(branch_issues.get(branch_name, []),
> -                      key=kernel_sec.issue.get_id_sort_key))
> +        sorted_cve_ids = sorted(
> +            branch_issues.get(branch['full_name'], []),
> +            key=kernel_sec.issue.get_id_sort_key)
> +        print('%s:' % branch['full_name'], *sorted_cve_ids)
> 
> 
>  if __name__ == '__main__':
> @@ -104,9 +152,11 @@ if __name__ == '__main__':
>                          help='include issues that have been marked as ignored')
>      parser.add_argument('branches',
>                          nargs='*',
> -                        help=('specific branch to report on '
> -                              '(default: all active branches)'),
> -                        metavar='BRANCH')
> +                        help=('specific branch[:tag] or stable tag to '
> +                              'report on (default: all active branches). '
> +                              'e.g. linux-4.14.y linux-4.4.y:v4.4.107 '
> +                              'v4.4.181-cip33 linux-4.19.y-cip:myproduct-v33'),
> +                        metavar='[BRANCH[:TAG]|TAG]')
>      args = parser.parse_args()
>      remotes = kernel_sec.branch.get_remotes(args.remote_name,
>                                              mainline=args.mainline_remote_name,
> --
> 2.17.1
> 
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
