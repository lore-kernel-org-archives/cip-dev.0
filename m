From: kazuhiro3.hayashi@toshiba.co.jp (kazuhiro3.hayashi at toshiba.co.jp)
Date: Fri, 7 Feb 2020 09:22:00 +0000
Subject: [cip-dev] RESUME REQUEST: [cip-core] Package Proposal #1
 (Security packages)
In-Reply-To: <TYAPR01MB239971DB23CF9A17B2DCBE2ADF1C0@TYAPR01MB2399.jpnprd01.prod.outlook.com>
References: <OSAPR01MB23880B5470CDE5D534181CF5DF310@OSAPR01MB2388.jpnprd01.prod.outlook.com>
 <87a76ih15g.fsf@kokedama.swc.toshiba.co.jp>
 <TYAPR01MB2399B94CD0E5825B65F6D673DF0D0@TYAPR01MB2399.jpnprd01.prod.outlook.com>
 <877e1imxr9.fsf@kokedama.swc.toshiba.co.jp>
 <TYAPR01MB239971DB23CF9A17B2DCBE2ADF1C0@TYAPR01MB2399.jpnprd01.prod.outlook.com>
Message-ID: <TYXPR01MB18089869A671864CA47E7F42E11C0@TYXPR01MB1808.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Kent,

Thank you for reporting the problem.
I've created an issue on GitLab: https://gitlab.com/cip-project/cip-core/cip-pkglist/issues/4

However, I could not reproduce the error.
Could you join the discussion above and tell us the commit ID of `cip-pkglist` you are using and host system information?

Best regards,
Kazu
> 
> Hello reviews,
> 
> Thank you for your supporting against our proposal.
> I'd like to share you the description sheet for our proposal of security packages.
> Please consider my attachment and the following note.
> 
> Note:
> 1. Added "fail2ban" as the alternative "pam-shield" because "pam-shield" is not well-maintained and replace with "fail2ban"
> 2. There are 3 packages in bottom that are under discussion to add. They are out of scope for this review but I'd like
> to explain them, so let me know your ideas if you have.
> 3. The requirements for hardware functions are out of scope for this review, but tpm2 is concrete example mentioned in
> the standard, so I'd like to add some packages related tpm2. However, they are options for only using tpm2, so let me
> know your comments against adding the packages for a specific use case.
> 
> BTW,
> 
> @kazuhiro3.hayashi at toshiba.co.jp,
> 
> I'd like to create new proposal to add "fail2ban", but the script for generating proposal shows the following error, and
> I could not generate it.
> 
> -------------------------------
> Source package name:
> Binary packages:
> 
> any>
> Traceback (most recent call last):
>   File "./generate-proposal.py", line 218, in <module>
>     generate_proposal(common.PDPProposal.ProposalInfo())
>   File "./generate-proposal.py", line 176, in generate_proposal
>     deb_src_pkg_info = prepare_src_pkg_info(apt, cve, dep_src_pkg, dep_pkg_info.keys())
>   File "./generate-proposal.py", line 51, in prepare_src_pkg_info
>     dp_list_final = gpd.get_pkg_depends(pkg, apt)
>   File "/home/yoshidak/cip-pkglist/get_pkg_depends.py", line 102, in get_pkg_depends
>     dp_list, dp_vir_pkg_dict = apt.apt_cache_get_depends_list(pkg_name)
>   File "/home/yoshidak/cip-pkglist/common.py", line 222, in apt_cache_get_depends_list
>     dp_info=c[pkg_name]
>   File "/usr/lib/python2.7/dist-packages/apt/cache.py", line 238, in __getitem__
>     raise KeyError('The cache has no package named %r' % key)
> KeyError: "The cache has no package named 'any>'"
> -------------------------------
> 
> I think that the reason is below. When I enter the information of "fail2ban", the script get the dependency for it as
> <python3:any>.
> 
> -------------------------------
> Enter the source package name: fail2ban
> Choose the required binary packages:
>         1: fail2ban
>  Input the numbers in comma separated (eg: 1,3,4): 1
> 
> fail2ban
>  Choose one of the virtual package provider: <python3:any>
>         1: python3
>  Input the number: 1
>         -<python3:any>:python3
>         -lsb-base
>  Are any of the binary packages used in target rootfs?
>         1: True
>         2: False
> -------------------------------
> 
> Would you confirm this issue?
> 
> Best regards,
> Kent
> 
> >-----Original Message-----
> >From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> >Sent: Thursday, January 23, 2020 4:35 PM
> >To: Kento Yoshida <kento.yoshida.wz@renesas.com>
> >Cc: cip-dev at lists.cip-project.org; cip-security at lists.cip-project.org
> >Subject: Re: [cip-dev] RESUME REQUEST: [cip-core] Package Proposal #1 (Security
> >packages)
> >
> >Thank you for your comments, Yoshida-san. Follow up comments inline.
> >
> >Kento Yoshida <kento.yoshida.wz@renesas.com> writes:
> >
> >> Hello and thank you for your comment, Punit,
> >>
> >>>-----Original Message-----
> >>>From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> >>>Sent: Monday, January 20, 2020 7:29 PM
> >>>To: Kento Yoshida <kento.yoshida.wz@renesas.com>
> >>>Cc: cip-dev at lists.cip-project.org; kazuhiro3.hayashi at toshiba.co.jp;
> >>>cip-security at lists.cip-project.org
> >>>Subject: Re: [cip-dev] RESUME REQUEST: [cip-core] Package Proposal #1
> >>>(Security
> >>>packages)
> >>>
> >>>Hello Yoshida-san,
> >>>
> >>>Kento Yoshida <kento.yoshida.wz@renesas.com> writes:
> >>>
> >>>> Hello,
> >>>>
> >>>> I would like to resume our proposal from security working group.
> >>>> As you know, Kazu has modified the script to generate a proposal and
> >>>> posted the
> >>>minimum base system proposal, and then I created the new proposal.
> >>>>
> >>>> The difference from the original (rev01) proposal is below:
> >>>> 1. We remove 'duplicity', 'google-authenticator', 'pam-shield' and
> >>>> 'suricata' in the
> >>>new proposal because they have an issue such as non-well maintained,
> >>>python version, too much dependencies and so on. We'll separately
> >>>propose them after solved these issues.
> >>>> 2. The new proposal shows all source package as flat. Thanks to the
> >>>> new script,
> >>>Kazu!
> >>>> 3. Actually several packages overlap with the proposed packages for
> >>>> minimum
> >>>base system in Debian, so I added comment them like that.
> >>>>
> >>>> @kazuhiro3.hayashi at toshiba.co.jp,
> >>>> Would you check this proposal and set the due date to review it?
> >>>>
> >>>> Please reply if you have any comments or questions.
> >>>
> >>>I have a comment about packages in the proposal that depend on
> >>>hardware / system features -
> >>>
> >>>* Some packages in the proposal depend on special purpose hardware to
> >>>  provide their functionality. e.g., TPM.
> >>>
> >>>  In systems, where TPM is not present (or similar functionality is
> >>> provided by alternate mechanisms), the TPM related packages will not
> >>> be useful. e.g., the non-x86 platforms in the CIP reference hardware
> >>> list.
> >>>
> >>>* Similarly, some packages require the system to be connected to the
> >>>  network.
> >>>
> >>>In both of these situations, I am wondering what is the impact on
> >>>compliance? Is there a need to also define minimal set of hardware
> >>>features expected from reference hardware to be able to meet compliance
> >requirements?
> >>>
> >>
> >> How each reference hardware satisfies the requirements should be
> >> considered by each reference hardware provider.
> >
> >Agreed.
> >
> >But without an explicit statement of the requirement, how can a hardware vendor
> >wanting to develop system for CIP users know what features to enable in their
> >system?
> >
> >> If we provide hardware mechanisms similar with TPM to protect
> >> credentials and authentications, we can meet compliance requirements.
> >
> >TPM2 specification is more than 2000 pages long with many features and
> >functions. I believe the IEC standard requires a subset of this functionality. The
> >Security WG maybe intimately familiar with the required features but for the
> >reviewers on this list, there isn't any criteria to use for evaluation.
> >
> >Stating these functional requirements explicitly will serve the dual purpose of -
> >
> >* Provide an objective criteria for evaluating the package proposal (and
> >  discuss alternatives)
> >
> >* Give hardware / system vendors the features / functions needed by CIP
> >  users.
> >
> >What do you think?
> >
> >> TPM related packages are options in only systems where TPM is
> >> implemented as you said. If supporting these packages require too much
> >> costs, the necessity of them will diminish.  Actually the standard
> >> lists TPM as a typical example, so we thought it will be useful to
> >> maintain TPM related packages for many users, but their necessities
> >> depend on supporting cost.
> >
> >I see - thanks for the background of the TPM-related packages in the proposal.
> >
> >>
> >>>To help review the package list (and also discuss alternatives), it
> >>>would help to define the underlying functionality that is required in
> >>>more detail, e.g., secure key storage, verified boot, etc. It'll make
> >>>it possible review the proposal more concretely.
> >
> >[...]
