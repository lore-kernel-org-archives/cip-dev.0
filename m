From: kazuhiro.fujita.jg@renesas.com (Kazuhiro Fujita)
Date: Wed, 24 Apr 2019 11:01:10 +0000
Subject: [cip-dev] about branch of meta-debian in cip-core/deby
In-Reply-To: <OSBPR01MB27746936339146E99ADC8AB2E1240@OSBPR01MB2774.jpnprd01.prod.outlook.com>
References: <CAGDrK-a79Z7rc=JibAU_8TL=7GtVFocGfvne9iQ4MsCa1oGU1w@mail.gmail.com>
	<OSAPR01MB3763870A4581B882D1AC1ADAD04B0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<OSAPR01MB30444CACDE60382555A681DCE14B0@OSAPR01MB3044.jpnprd01.prod.outlook.com>
	<OSBPR01MB499953893394AAC252B66DC6D9440@OSBPR01MB4999.jpnprd01.prod.outlook.com>
	<TY2PR01MB305133BDEEBBDE5D8386AB97E1470@TY2PR01MB3051.jpnprd01.prod.outlook.com>
	<OSBPR01MB4999AAFDBFB634B1F7D3350DD9400@OSBPR01MB4999.jpnprd01.prod.outlook.com>
	<OSBPR01MB2774062C0B63CAA2D0EA943FE12F0@OSBPR01MB2774.jpnprd01.prod.outlook.com>
	<OSBPR01MB27746936339146E99ADC8AB2E1240@OSBPR01MB2774.jpnprd01.prod.outlook.com>
Message-ID: <OSBPR01MB499921C7785981E6923C86C6D93C0@OSBPR01MB4999.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Hayashi-san,

Sorry for my late reply...

> -----Original Message-----
> From: kazuhiro3.hayashi at toshiba.co.jp <kazuhiro3.hayashi@toshiba.co.jp>
> Sent: Tuesday, April 16, 2019 8:53 PM
> To: Kazuhiro Fujita <kazuhiro.fujita.jg@renesas.com>
> Cc: cip-dev at lists.cip-project.org
> Subject: RE: about branch of meta-debian in cip-core/deby
> 
> Dear Fujita-san,
> 
> > In my understanding, the targets of CIP(-core)'s support are the
> followings at least:
> >
> > Kernel:
> > 	linux-4.4.y-cip & -rt
> > 	linux-4.19.y-cip & -rt
> > Debian:
> > 	Debian 8 (jessie)
> > 	Debian 9 (stretch)
> > 	Debian 10 (buster)
> > 	... and every version in future
> >
> > However, I think that there is no decision in CIP about the combination
> of
> > the above kernel versions and Debian versions, which should be supported
> by CIP.
> > This implicitly shows that all combinations could be supported, but
> > it's quite hard to test and maintain all of them.
> > I guess that the practical version combinations are very limited
> actually.
> >
> > I would like to confirm opinions about this in Isar later.
> 
> Regarding the discussion with Jan,
> I supposed that it's better to provide the following names for branches of
> tiny profile.
> https://lists.cip-project.org/pipermail/cip-dev/2019-April/002094.html
> 
> 	cip-core_jessie (Current "morty")
> 	cip-core_buster (Current "master")

This naming rule is clear and reasonable.


> 
> I would like to push the latest master branch of deby to cip-core GitLab
> and
> adjust it to work with kas later.
> 
> >
> > > >
> > > > If the both tiny(deby) and generic profile(isar) are based on the
> same
> > > > CIP kernel and Debian versions, we can use such common branch name
> above.
> > > > If not, or no benefit for users to use the common branch name,
> > > > I would like to simply use "morty" and "master" in deby repository.
> > >
> > > Using different version for tiny and generic may be confusing.
> > > In my opinion, tiny should be the subset of generic profile.
> >
> > Thank you for your opinion.
> > Regarding the supported package list, I agree that tiny should be subset
> of generic.
> > In order to use the common version (branch name) in tiny and generic,
> > and to concentrate our efforts on well-used cases,,
> > we need to make a decision about the supported version combinations
> between CIP kernel and Debian.
> 
> Here is the first draft of the version combinations (CIP & Debian)
> supported by CIP.
> https://lists.cip-project.org/pipermail/cip-dev/2019-April/002117.html
> 
> 	4.4 + stretch => SUPPORTED (necessary)
> 	4.4 + buster => NOT SUPPORTED
> 	4.4 + bullseye => NOT SUPPORTED
> 	4.19 + stretch => SUPPORTED (optional)
> 	4.19 + buster => SUPPORTED (necessary)
> 	4.19 + bullseye => SUPPORTED (optional: 4.19 should be compatible
> with bullseye userland)
> 	...

If "SUPPORTED" means that CIP promise to maintain these pairs, 
it may not good idea to put "optional" choice.

In my understanding, CIP decided at the start of CIP core 
activity that CIP must maintain packages used in CIP core 
after Debian finishes its maintenance.
For example, Debian will finish their support of Stretch at 
June/2022 and CIP will maintain the packages after that day.

If "optional" means CIP will stop using that pair in future, 
putting "optional" choice may work.

Regards,
Fujita


> 
> Some of them would be updated in future (especially "bullseye" (Debian
> 11)),
> but I would like to follow this list in the future discussion.
> 
> Regards,
> Kazu
> 
> >
> > Regards,
> > Kazu
> >
> > > -----Original Message-----
> > > From: Kazuhiro Fujita [mailto:kazuhiro.fujita.jg at renesas.com]
> > > Sent: Tuesday, March 19, 2019 2:52 PM
> > > To: hayashi kazuhiro(? ?? ????????)
> > > <kazuhiro3.hayashi@toshiba.co.jp>; sangorrin daniel(????? ???
> ?
> > > ????????) <daniel.sangorrin@toshiba.co.jp>;
> > > nobuhiro.iwamatsu at miraclelinux.com
> > > Cc: jan.kiszka at siemens.com; cip-dev at lists.cip-project.org
> > > Subject: RE: about branch of meta-debian in cip-core/deby
> > >
> > > Hello Hayashi-san,
> > >
> > > > -----Original Message-----
> > > > From: kazuhiro3.hayashi at toshiba.co.jp
> > > <kazuhiro3.hayashi@toshiba.co.jp>
> > > > Sent: Monday, March 18, 2019 10:52 AM
> > > > To: Kazuhiro Fujita <kazuhiro.fujita.jg@renesas.com>;
> > > > daniel.sangorrin at toshiba.co.jp; nobuhiro.iwamatsu at miraclelinux.com
> > > > Cc: jan.kiszka at siemens.com; cip-dev at lists.cip-project.org
> > > > Subject: RE: about branch of meta-debian in cip-core/deby
> > > >
> > > > Hello Fujita-san,
> > > > CC: Jan
> > > >
> > > > > In case the morty branch will be replaced by the master, current
> users
> > > > > will automatically switch to the master without knowing the
> change?
> > > > No, user can not automatically migrate from morty to master without
> > > > knowing the changes
> > > > because several specifications about recipe development has been
> deferent
> > > > between them.
> > > >
> > > > Therefore, regarding deby repository, it would be better to provide
> > > > branches
> > >
> > > Agreed.
> > >
> > > > "morty" and "master" as follows:
> > > > 	Current                  New
> > > > 	master(poky:morty-based) => morty
> > > > 	-                        => master(poky:master-based)
> > > > 	jethro                   => remove? (no longer maintained in
> > > meta-
> > > > debian)
> > > >
> > > > I would like to know if we need to the common branch name in cip-
> core.
> > > > For example: cip-core-v1(4.4+Debian8/9?),
> > > cip-core-v2(4.19+Debian10), ...
> > >
> > > Common branch name like cip-core-xx will help many users to understand
> > > which branch they should use.
> > >
> > > However, it may not clear CIP has decided or not that each kernel
> > > version sticks to specific version of the other OSSs.
> > > Some people around me say that OSSs included in cip-core will keep
> > > these versions and maintained by CIP.
> > > For example, they believe openssl 1.0.1t will be used when kernel
> > > 4.4-cip is running.
> > > This may not right assumption.
> > >
> > > Is there any material explaining the update policy of cip-core?
> > >
> > > >
> > > > If the both tiny(deby) and generic profile(isar) are based on the
> same
> > > > CIP kernel and Debian versions, we can use such common branch name
> above.
> > > > If not, or no benefit for users to use the common branch name,
> > > > I would like to simply use "morty" and "master" in deby repository.
> > >
> > > Using different version for tiny and generic may be confusing.
> > > In my opinion, tiny should be the subset of generic profile.
> > >
> > > Kind regards,
> > > Fujita
> > >
> > >
> > > >
> > > > Kind regards,
> > > > Kazu
> > > >
> > > > > -----Original Message-----
> > > > > From: Kazuhiro Fujita [mailto:kazuhiro.fujita.jg at renesas.com]
> > > > > Sent: Friday, March 15, 2019 11:39 AM
> > > > > To: hayashi kazuhiro(? ?? ????????)
> > > > > <kazuhiro3.hayashi@toshiba.co.jp>; sangorrin daniel(????? ?
> ?
> > > ??
> > > > > ????????) <daniel.sangorrin@toshiba.co.jp>;
> > > > > nobuhiro.iwamatsu at miraclelinux.com
> > > > > Cc: cip-dev at lists.cip-project.org
> > > > > Subject: RE: about branch of meta-debian in cip-core/deby
> > > > >
> > > > > Hello Hayashi-san,
> > > > >
> > > > > > Should we keep the morty branch and add contents of master to
> another
> > > > > cip-
> > > > > > core branch, or just replace the morty by the master?
> > > > >
> > > > > In case the morty branch will be replaced by the master, current
> users
> > > > > will automatically switch to the master without knowing the
> change?
> > > > >
> > > > > Regards,
> > > > > Fujita
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: cip-dev-bounces at lists.cip-project.org
> > > > > <cip-dev-bounces@lists.cip-
> > > > > > project.org> On Behalf Of kazuhiro3.hayashi at toshiba.co.jp
> > > > > > Sent: Thursday, March 14, 2019 7:09 PM
> > > > > > To: daniel.sangorrin at toshiba.co.jp;
> > > nobuhiro.iwamatsu at miraclelinux.com
> > > > > > Cc: cip-dev at lists.cip-project.org
> > > > > > Subject: Re: [cip-dev] about branch of meta-debian in cip-
> core/deby
> > > > > >
> > > > > > Iwamatsu-san, Daniel,
> > > > > >
> > > > > > > > It provides debian 8 packages in OE/recipe. Is there any
> reason
> > > to
> > > > > > > > choose morty/debian 8?
> > > > > > In my understanding, this is the initial repository which was
> created
> > > > > > when the master branch (Debian 10 based) didn't exist yet.
> > > > > > We are planning to update it to the current master branch.
> > > > > >
> > > > > > I have another question about how to do that.
> > > > > > Should we keep the morty branch and add contents of master to
> another
> > > > > cip-
> > > > > > core branch,
> > > > > > or just replace the morty by the master?
> > > > > >
> > > > > > Regards,
> > > > > > Kazu
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: cip-dev-bounces at lists.cip-project.org
> > > > > > > [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of
> > > > > > > daniel.sangorrin at toshiba.co.jp
> > > > > > > Sent: Thursday, March 14, 2019 2:52 PM
> > > > > > > To: nobuhiro.iwamatsu at miraclelinux.com
> > > > > > > Cc: cip-dev at lists.cip-project.org
> > > > > > > Subject: Re: [cip-dev] about branch of meta-debian in cip-
> core/deby
> > > > > > >
> > > > > > > Iwamatsu-san,
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu@miraclelinux.com>
> > > > > > > > Sent: Wednesday, March 13, 2019 4:38 PM
> > > > > > > > To: sangorrin daniel(????? ???? ????????)
> > > > > > > <daniel.sangorrin@toshiba.co.jp>
> > > > > > > > Cc: cip-dev at lists.cip-project.org
> > > > > > > > Subject: about branch of meta-debian in cip-core/deby
> > > > > > > >
> > > > > > > > Hi, Daniel.
> > > > > > > >
> > > > > > > > I have a question about about branch of meta-debian in cip-
> > > > core/deby.
> > > > > > > >
> > > > > > > > The meta-debian branch used by cip-core/deby  is morty.
> > > > > > > > It provides debian 8 packages in OE/recipe. Is there any
> reason
> > > to
> > > > > > > > choose morty/debian 8?
> > > > > > > > Is the reason why the mata-debian master branch is still in
> > > > > > development?
> > > > > > > > Will you/we switch to the master branch when Debian 10 is
> > > > released?
> > > > > > >
> > > > > > > Yes, that's correct.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Daniel
> > > > > > > _______________________________________________
> > > > > > > cip-dev mailing list
> > > > > > > cip-dev at lists.cip-project.org
> > > > > > > https://lists.cip-project.org/mailman/listinfo/cip-dev
> > > > > > _______________________________________________
> > > > > > cip-dev mailing list
> > > > > > cip-dev at lists.cip-project.org
> > > > > > https://lists.cip-project.org/mailman/listinfo/cip-dev
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
