From: pavel@denx.de (Pavel Machek)
Date: Tue, 23 Jul 2019 14:15:35 +0200
Subject: [cip-dev] [RFC/RFT] -cip-rt kernels for review/testing
In-Reply-To: <25cee49e-ea67-0e23-87b9-6198bd5749f4@monom.org>
References: <20190623203704.GA12734@amd>
	<564b1c37-083e-5b56-7e56-abc4b9ddb7bd@siemens.com>
	<25cee49e-ea67-0e23-87b9-6198bd5749f4@monom.org>
Message-ID: <20190723121535.GA11883@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> On 6/24/19 8:28 AM, Jan Kiszka wrote:
> >On 23.06.19 22:37, Pavel Machek wrote:
> >>v4.19.50-rt22-cip3-rebase was reasonably easy to do, as -cip1 was
> >>empty. v4.4.179-rt181-cip34-rebase was more interesting.
> 
> Yep, the v4.4.179 brought some conflicts. Have you compared with my merge
> for v4.4-rt? Not sure if I understand your worklfow correctly. It looks like
> you used for the rebase branches the upstream -rt patchset and merged the
> cip branch. Is this correct?

It looks like I'll need to redo the rebase at least for 4.4. I plan to
rebase -cip specific patches on top of -rt.

> What I did for the v4.4-cip-rt and v4.19-cip-rt is following
> 
> - initial setup (only once):
> 
> took the latest cip release and applied the current/matching -rt patcheset
> 
> - regulare update:
> 
> $ cd v4.4-rt
> $ git tag -l 'v4\.4\.*' --sort=v:refname | tail
> $ git merge v4.4.120      [fixup conflicts]
> 
> # do some testing (this is on Linutronix -rt test infrastrucure)
> $ git push lxcvs -f --follow-tag HEAD:stable-maintenance-4.4.y-rt
> 
> $ srt commit
> $ srt tag
> 
> $ cd v4.4-rt-rebase
> $ git rebase -i v4.4.120  [fixup conflicts]
> $ srt commit
> $ srt tag
> 
> # check if the -rt-rebase branch is identical to v4.4-rt
> $ git diff v4.4-rt
> 
> $ srt create v4.4.115-rt130 v4.4.120-rt135
> $ srt sign v4.4.115-rt130 v4.4.120-rt135
> $ srt upload v4.4.115-rt130 v4.4.120-rt135
> $ srt push v4.4.115-rt130 v4.4.120-rt135
> 
> # XXX push missing tags
> $ git push origin v4.4.115-rt131 v4.4.116-rt132 v4.4.118-rt133
> v4.4.119-rt134
> 
> $ srt announce v4.4.115-rt130 v4.4.120-rt135 > ../announce-rt
> $ cat ../announce-rt | msmtp -t --
> 
> The srt tool is available here: https://github.com/igaw/stable-rt-tools
> It a few lines around git to make the steps consist. It is based on Steven
> Rostedt workflow. Tom Zanussi (also -rt stable maintainer) and I am using
> the tool to maintain the -rt trees.

Thanks for pointer. It does not want to run here (incompatible version
of python 3?), so let me try to do one more manual attempt, and if
that fails I'll try to fix/workaround python problems.

> If it helps, I am going to give a talk at Plubmers on how to maintain the
> -rt trees:

Thanks for pointer. I'm not sure I'll be at Plumbers.

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190723/8e8b9e02/attachment.sig>
