From: kazuhiro3.hayashi@toshiba.co.jp (kazuhiro3.hayashi at toshiba.co.jp)
Date: Tue, 11 Feb 2020 05:39:43 +0000
Subject: [cip-dev] [cip-core] Package Proposal #2 (Minimum base packages
 in Debian)
In-Reply-To: <TYXPR01MB180871262DF43C33A9AC70D9E1030@TYXPR01MB1808.jpnprd01.prod.outlook.com>
References: <TYXPR01MB1808E5730818EAB90EB9558FE1360@TYXPR01MB1808.jpnprd01.prod.outlook.com>
 <TYXPR01MB1808AFBB9C4A06F0E43B8EF4E10D0@TYXPR01MB1808.jpnprd01.prod.outlook.com>
 <dc1e4578-64e7-dc3f-828c-43c907448018@renesas.com>
 <TYXPR01MB1808951D8345BDE55D6E7284E10F0@TYXPR01MB1808.jpnprd01.prod.outlook.com>
 <TYXPR01MB180871262DF43C33A9AC70D9E1030@TYXPR01MB1808.jpnprd01.prod.outlook.com>
Message-ID: <TYXPR01MB180807A649A2B91ED54DFF0FE1180@TYXPR01MB1808.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello TSC members,

> Dear TSC members,
> Could you confirm that the attached package list (proposal_minbase_20200204.yml)
> can be registered as the (initial) CIP maintained package list?

How can I proceed this confirmation?
Are there any formal process for this?

Best regards,
Kazu

> 
> Hello CIP Core members,
> 
> All CIP Core members agreed this proposal (#2), so
> I would like to conclude that this proposal is accepted by CIP Core.
> Thank you for your review!
> 
> Dear TSC members,
> Could you confirm that the attached package list (proposal_minbase_20200204.yml)
> can be registered as the (initial) CIP maintained package list?
> This is the "Phase 4" in the PDP:
> https://gitlab.com/cip-project/cip-core/cip-pkglist/-/blob/master/doc/pdp.md#phase-4-approval
> 
> 
> Just in case, I would like to share several discussions in the review process:
> 
> Q. What is the policy for the "minimum base"?
> A. The "minimum base" means here is the essential "Debian binary" packages needed for booting up.
>    These packages are installed by:
>      $ debootstrap --variant=minbase buster ...
>    and they are essential for CIP Core generic profile.
> 
> Q. Some binary packages listed in "depends:" of proposal_minbase_20200116.yml are duplicated, why?
> A. This issue was discussed in https://gitlab.com/cip-project/cip-core/cip-pkglist/issues/1
>    then fixed by https://gitlab.com/cip-project/cip-core/cip-pkglist/-/merge_requests/6
> 
> I has recreated the .yml file after the fix above (=> proposal_minbase_20200204.yml)
> then there is no change from proposal_minbase_20200116.yml in the package information
> except several minor updates. Please check the attached files (0116-0204.diff) for more details.
> 
> Best regards,
> Kazu
> 
> >
> > Hello CIP Core members,
> >
> > Thank you for your replies.
> >
> > I need to wait for replies of Codethink, Hitachi, and Moxa,
> > so would like to postpone the due date to
> > 	January 31th (Fri)
> > (Lunar New Year holiday until Jan 29th)
> >
> > Codethink
> > Cybertrust (Agreed #2)
> > Hitachi
> > Moxa
> > Renesas (Agreed #2)
> > Siemens (Agreed #2)
> > Toshiba (Agreed #2)
> >
> > Best regards,
> > Kazu
> >
> > > -----Original Message-----
> > > From: cip-dev [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Takehisa Katayama
> > > Sent: Thursday, January 23, 2020 5:07 PM
> > > To: cip-dev at lists.cip-project.org
> > > Subject: Re: [cip-dev] [cip-core] Package Proposal #2 (Minimum base packages in Debian)
> > >
> > > Hi Kazu-san,
> > >
> > > >> Please reply with you opinion, agree or disagree.
> > >
> > > Renesas agree.
> > >
> > > Thanks.
> > >
> > > Best regards,
> > > Takehisa Katayama.
> > >
> > >
> > >
> > > On 2020/01/21 9:52, kazuhiro3.hayashi at toshiba.co.jp wrote:
> > > > Hello CIP Core members,
> > > >
> > > >> Due Date: January 20th (The next TSC meeting)
> > > >
> > > > If you have not yet replied to this proposal, please send us your opinion by
> > > > 	January 23th (By the next IRC meeting)
> > > >
> > > > Best regards,
> > > > Kazu
> > > >
> > > >>
> > > >> Hello CIP Core members,
> > > >>
> > > >> I created a simple package proposal for the packages that are installed in the "minimum base system" of Debian.
> > > >> These packages are installed by
> > > >> 	$ debootstrap --variant=minbase buster ...
> > > >>
> > > >> It consists of 58 source packages and 84 binary packages, including all run-time dependencies.
> > > >>
> > > >> The common reason to propose:
> > > >> "This package is included in the minimum base system of Debian (debootstrap --variant=minbase),
> > > >> which is essential for all Debian binary package based systems"
> > > >>
> > > >>
> > > >> I would like to start the "review" phase (Phase 2) of the attached package proposal.
> > > >> https://gitlab.com/cip-project/cip-core/cip-pkglist/blob/master/doc/pdp.md#phase-2-proposal-review
> > > >>
> > > >> Please reply with you opinion, agree or disagree.
> > > >> If you cannot agree to add specific packages, please show the reasons as well.
> > > >>
> > > >> Due Date: January 20th (The next TSC meeting)
> > > >>
> > > >> We have only 2-3 working days for this review, but
> > > >> I think it may be enough to agree or disagree the very simple reason above.
> > > >> (We can extend this due date if more time required for reviews, please let me know if any requests)
> > > >>
> > > >> Best regards,
> > > >> Kazu
> > > > _______________________________________________
> > > > cip-dev mailing list
> > > > cip-dev at lists.cip-project.org
> > > > https://lists.cip-project.org/mailman/listinfo/cip-dev
> > > > .
> > > >
> > > _______________________________________________
> > > cip-dev mailing list
> > > cip-dev at lists.cip-project.org
> > > https://lists.cip-project.org/mailman/listinfo/cip-dev
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
