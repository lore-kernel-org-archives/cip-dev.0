From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Thu, 11 Jul 2019 04:50:34 +0000
Subject: [cip-dev] [cip-kernel-sec][RESEND 4/6] report_affected: add
 support for reporting on tags
In-Reply-To: <9f57c72f08a75a1f4a74b90c4455836b450e6ffa.camel@codethink.co.uk>
References: <20190710012450.16524-1-daniel.sangorrin@toshiba.co.jp>
	<20190710012450.16524-5-daniel.sangorrin@toshiba.co.jp>
	<9f57c72f08a75a1f4a74b90c4455836b450e6ffa.camel@codethink.co.uk>
Message-ID: <OSBPR01MB307740D9B6B44F891F2CC222D0F30@OSBPR01MB3077.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> From: Ben Hutchings <ben.hutchings@codethink.co.uk>
[...]
> > +                    if 'tag_regexp' in branch:
> > +                        # predefined in conf/branches.yml
> > +                        tag_regexp = branch['tag_regexp']
> > +                    elif branch['git_remote'] == 'stable':
> > +                        # stable format, e.g. v4.19.12
> > +                        esc_base_ver = branch['base_ver'].replace('.', '\.')
> 
> This happens to work now, but '\.' is an unrecognised escape sequence
> which is deprecated.  You presumably meant r'\.', but it might be
> clearer to use re.escape().

Thanks, you are right. I have used re.escape('.'). I didn't know this function, it's really useful not having to remember how to escape characters (I figured out I could have used \\.).

I think that the YAML strings in conf/branches.yml are being read as if they were raw strings, but if there is a problem with them let me know.

> 
> > +                        tag_regexp = r'(^v%s$|^v%s\.\d+$)' % (
> > +                            esc_base_ver, esc_base_ver)
> 
> I also expected that you would set tag_regexp for stable branches in
> the branch module along with all their other fields.  Then there's no
> need to handle them specially here.

Ah sorry about that. I have moved that code to branch.py now.

> 
> > +                    else:
> > +                        # no tag_regexp defined, or mainline
> > +                        continue
> > +
> > +                    if re.match(tag_regexp, branch_name):
> > +                        tag = branch_name
> > +                        name = branch['short_name']
> > +                        break
> > +                else:
> > +                    raise ValueError('Failed to match tag %r' % branch_name)
> > +            elif ':' in branch_name:
> > +                # a possibly custom tag, e.g. linux-4.19.y-cip:myproduct-v1
> > +                name_tuple = tuple(branch_name.split(':'))
> > +                name = name_tuple[0]
> > +                tag = name_tuple[1]
> [...]
> 
> You really can do simply:
> 
>                 name, tag = branch_name.split(':', 1)
> 
> (Tuple assignment only requires an iterable, not specifically a tuple,
> on the right hand side.)  So please use that.

Nice trick. I fixed the code.

Thanks,
Daniel


> 
> Ben.
> 
> --
> Ben Hutchings, Software Developer                         Codethink Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United Kingdom
