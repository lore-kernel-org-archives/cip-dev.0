From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 10 Jul 2019 15:40:52 +0100
Subject: [cip-dev] [cip-kernel-sec][RESEND 4/6] report_affected: add
 support for reporting on tags
In-Reply-To: <20190710012450.16524-5-daniel.sangorrin@toshiba.co.jp>
References: <20190710012450.16524-1-daniel.sangorrin@toshiba.co.jp>
	<20190710012450.16524-5-daniel.sangorrin@toshiba.co.jp>
Message-ID: <9f57c72f08a75a1f4a74b90c4455836b450e6ffa.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2019-07-10 at 10:24 +0900, Daniel Sangorrin wrote:
[...]
> --- a/scripts/report_affected.py
> +++ b/scripts/report_affected.py
[...]
> @@ -22,15 +24,47 @@ def main(git_repo, remotes,
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
> +                    if 'tag_regexp' in branch:
> +                        # predefined in conf/branches.yml
> +                        tag_regexp = branch['tag_regexp']
> +                    elif branch['git_remote'] == 'stable':
> +                        # stable format, e.g. v4.19.12
> +                        esc_base_ver = branch['base_ver'].replace('.', '\.')

This happens to work now, but '\.' is an unrecognised escape sequence
which is deprecated.  You presumably meant r'\.', but it might be
clearer to use re.escape().

> +                        tag_regexp = r'(^v%s$|^v%s\.\d+$)' % (
> +                            esc_base_ver, esc_base_ver)

I also expected that you would set tag_regexp for stable branches in
the branch module along with all their other fields.  Then there's no
need to handle them specially here.

> +                    else:
> +                        # no tag_regexp defined, or mainline
> +                        continue
> +
> +                    if re.match(tag_regexp, branch_name):
> +                        tag = branch_name
> +                        name = branch['short_name']
> +                        break
> +                else:
> +                    raise ValueError('Failed to match tag %r' % branch_name)
> +            elif ':' in branch_name:
> +                # a possibly custom tag, e.g. linux-4.19.y-cip:myproduct-v1
> +                name_tuple = tuple(branch_name.split(':'))
> +                name = name_tuple[0]
> +                tag = name_tuple[1]
[...]

You really can do simply:

                name, tag = branch_name.split(':', 1)

(Tuple assignment only requires an iterable, not specifically a tuple,
on the right hand side.)  So please use that.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
