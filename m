From: kazuhiro.fujita.jg@renesas.com (Kazuhiro Fujita)
Date: Mon, 3 Jun 2019 08:16:04 +0000
Subject: [cip-dev] about branch of meta-debian in cip-core/deby
In-Reply-To: <OSBPR01MB38623D50E602D00B44A7548AE1140@OSBPR01MB3862.jpnprd01.prod.outlook.com>
References: <CAGDrK-a79Z7rc=JibAU_8TL=7GtVFocGfvne9iQ4MsCa1oGU1w@mail.gmail.com>
	<OSAPR01MB3763870A4581B882D1AC1ADAD04B0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<OSAPR01MB30444CACDE60382555A681DCE14B0@OSAPR01MB3044.jpnprd01.prod.outlook.com>
	<OSBPR01MB499953893394AAC252B66DC6D9440@OSBPR01MB4999.jpnprd01.prod.outlook.com>
	<TY2PR01MB305133BDEEBBDE5D8386AB97E1470@TY2PR01MB3051.jpnprd01.prod.outlook.com>
	<OSBPR01MB4999AAFDBFB634B1F7D3350DD9400@OSBPR01MB4999.jpnprd01.prod.outlook.com>
	<OSBPR01MB2774062C0B63CAA2D0EA943FE12F0@OSBPR01MB2774.jpnprd01.prod.outlook.com>
	<OSBPR01MB27746936339146E99ADC8AB2E1240@OSBPR01MB2774.jpnprd01.prod.outlook.com>
	<OSBPR01MB499921C7785981E6923C86C6D93C0@OSBPR01MB4999.jpnprd01.prod.outlook.com>
	<OSBPR01MB3862C36E2D6441A61D622DA7E11D0@OSBPR01MB3862.jpnprd01.prod.outlook.com>
	<OSBPR01MB499986A053AC32691E3B3655D91E0@OSBPR01MB4999.jpnprd01.prod.outlook.com>
	<OSBPR01MB38623D50E602D00B44A7548AE1140@OSBPR01MB3862.jpnprd01.prod.outlook.com>
Message-ID: <OSBPR01MB4999AF49F6F1AAD61DB2DC37D9140@OSBPR01MB4999.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Hayashi-san,

> -----Original Message-----
> From: kazuhiro3.hayashi at toshiba.co.jp <kazuhiro3.hayashi@toshiba.co.jp>
> Sent: Monday, June 3, 2019 4:45 PM
> To: Kazuhiro Fujita <kazuhiro.fujita.jg@renesas.com>
> Cc: cip-dev at lists.cip-project.org
> Subject: RE: about branch of meta-debian in cip-core/deby
> 
> Hello Fujita-san,
> 
> > (...snipped...)
> > > Thank you for pointing it out.
> > > I would like to clarify the meaning of "optional".
> > >
> > > At this time, cip-core has two profiles (generic, tiny).
> > > After Debian buster released, each profile will provide the following
> > > kernel + Debian pares:
> > >
> > >                 generic     tiny
> > > =================================
> > > 4.4 + jessie                X
> >
> > Debian announced that their security support for jessie finishes in next
> month.
> > https://lists.debian.org/debian-security-announce/2018/msg00132.html
> 
> This announce also means that the Debian LTS team starts maintenance of
> jessie from June 2018.
> https://wiki.debian.org/LTS/

Thank you for this information.


> 
> >
> >
> > > 4.4 + stretch   X
> > > 4.19 + stretch  X(optional)
> > > 4.19 + buster   X(default)  X
> > >
> > > Regarding the generic profile, 4.19 + buster is provided by isar-cip-
> core
> > > by default,
> > > and 4.19 + stretch is also "available" by changing the settings.
> > > Example: https://lists.cip-project.org/pipermail/cip-dev/2019-
> > > April/002116.html
> > > "4.19 + stretch" here is the "optional" I initially meant.
> > >
> > > From the maintenance PoV, (in my opinion)
> > > once a pair becomes available in a profile, CIP need to keep
> maintaining
> > > (testing) it.
> > > How the test matrix should be defined is under discussion.
> > > (e.g. Duplicated tests should be avoided among the supported pairs and
> > > target boards)
> >
> > If CIP itself starts to support jessie as soon after finishing debian's
> support,
> > we must hurry to discuss about this topic.
> 
> jessie is still being maintained by LTS until June 2019.
> 
> Deby will support "building" images with CIP 4.4 and Debian 8 jessie
> sources.
> Regarding maintenance policy of jessie sources by CIP, more discussions
> are required.

Agreed.


> In my understanding, whether sources in the specific Debian version should
> be maintained or not
> depends on how many CIP users are now using it in their developments
> actually.

I wish this topic will be add soon to the agenda of some important meeting.

Kind regards,
Fujita Kazuhiro


> 
> Kind regards,
> Kazu
> 
> >
> > Kind regards,
> > Fujita
> >
> >
> > >
> > > Kind regards,
> > > Kazu
> > >
> > > >
> > > > Regards,
> > > > Fujita
> > > >
> > > >
> > > > >
> > > > > Some of them would be updated in future (especially "bullseye"
> (Debian
> > > > > 11)),
> > > > > but I would like to follow this list in the future discussion.
> > > > >
> > > > > Regards,
> > > > > Kazu
> > > > >
> > > > > >
> > > > > > Regards,
> > > > > > Kazu
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Kazuhiro Fujita [mailto:kazuhiro.fujita.jg at renesas.com]
> > > > > > > Sent: Tuesday, March 19, 2019 2:52 PM
> > > > > > > To: hayashi kazuhiro(? ?? ????????)
> > > > > > > <kazuhiro3.hayashi@toshiba.co.jp>; sangorrin daniel(?????
> ?
> > > ??
> > > > > ?
> > > > > > > ????????) <daniel.sangorrin@toshiba.co.jp>;
> > > > > > > nobuhiro.iwamatsu at miraclelinux.com
> > > > > > > Cc: jan.kiszka at siemens.com; cip-dev at lists.cip-project.org
> > > > > > > Subject: RE: about branch of meta-debian in cip-core/deby
> > > > > > >
> > > > > > > Hello Hayashi-san,
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: kazuhiro3.hayashi at toshiba.co.jp
> > > > > > > <kazuhiro3.hayashi@toshiba.co.jp>
> > > > > > > > Sent: Monday, March 18, 2019 10:52 AM
> > > > > > > > To: Kazuhiro Fujita <kazuhiro.fujita.jg@renesas.com>;
> > > > > > > > daniel.sangorrin at toshiba.co.jp;
> > > nobuhiro.iwamatsu at miraclelinux.com
> > > > > > > > Cc: jan.kiszka at siemens.com; cip-dev at lists.cip-project.org
> > > > > > > > Subject: RE: about branch of meta-debian in cip-core/deby
> > > > > > > >
> > > > > > > > Hello Fujita-san,
> > > > > > > > CC: Jan
> > > > > > > >
> > > > > > > > > In case the morty branch will be replaced by the master,
> > > current
> > > > > users
> > > > > > > > > will automatically switch to the master without knowing
> the
> > > > > change?
> > > > > > > > No, user can not automatically migrate from morty to master
> > > without
> > > > > > > > knowing the changes
> > > > > > > > because several specifications about recipe development has
> been
> > > > > deferent
> > > > > > > > between them.
> > > > > > > >
> > > > > > > > Therefore, regarding deby repository, it would be better to
> > > provide
> > > > > > > > branches
> > > > > > >
> > > > > > > Agreed.
> > > > > > >
> > > > > > > > "morty" and "master" as follows:
> > > > > > > > 	Current                  New
> > > > > > > > 	master(poky:morty-based) => morty
> > > > > > > > 	-                        => master(poky:master-based)
> > > > > > > > 	jethro                   => remove? (no longer
> maintained in
> > > > > > > meta-
> > > > > > > > debian)
> > > > > > > >
> > > > > > > > I would like to know if we need to the common branch name in
> > > cip-
> > > > > core.
> > > > > > > > For example: cip-core-v1(4.4+Debian8/9?),
> > > > > > > cip-core-v2(4.19+Debian10), ...
> > > > > > >
> > > > > > > Common branch name like cip-core-xx will help many users to
> > > understand
> > > > > > > which branch they should use.
> > > > > > >
> > > > > > > However, it may not clear CIP has decided or not that each
> kernel
> > > > > > > version sticks to specific version of the other OSSs.
> > > > > > > Some people around me say that OSSs included in cip-core will
> keep
> > > > > > > these versions and maintained by CIP.
> > > > > > > For example, they believe openssl 1.0.1t will be used when
> kernel
> > > > > > > 4.4-cip is running.
> > > > > > > This may not right assumption.
> > > > > > >
> > > > > > > Is there any material explaining the update policy of cip-
> core?
> > > > > > >
> > > > > > > >
> > > > > > > > If the both tiny(deby) and generic profile(isar) are based
> on
> > > the
> > > > > same
> > > > > > > > CIP kernel and Debian versions, we can use such common
> branch
> > > name
> > > > > above.
> > > > > > > > If not, or no benefit for users to use the common branch
> name,
> > > > > > > > I would like to simply use "morty" and "master" in deby
> > > repository.
> > > > > > >
> > > > > > > Using different version for tiny and generic may be confusing.
> > > > > > > In my opinion, tiny should be the subset of generic profile.
> > > > > > >
> > > > > > > Kind regards,
> > > > > > > Fujita
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Kind regards,
> > > > > > > > Kazu
> > > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Kazuhiro Fujita
> [mailto:kazuhiro.fujita.jg at renesas.com]
> > > > > > > > > Sent: Friday, March 15, 2019 11:39 AM
> > > > > > > > > To: hayashi kazuhiro(? ?? ????????)
> > > > > > > > > <kazuhiro3.hayashi@toshiba.co.jp>; sangorrin daniel(???
> ??
> > > ?
> > > > > ?
> > > > > > > ??
> > > > > > > > > ????????) <daniel.sangorrin@toshiba.co.jp>;
> > > > > > > > > nobuhiro.iwamatsu at miraclelinux.com
> > > > > > > > > Cc: cip-dev at lists.cip-project.org
> > > > > > > > > Subject: RE: about branch of meta-debian in cip-core/deby
> > > > > > > > >
> > > > > > > > > Hello Hayashi-san,
> > > > > > > > >
> > > > > > > > > > Should we keep the morty branch and add contents of
> master
> > > to
> > > > > another
> > > > > > > > > cip-
> > > > > > > > > > core branch, or just replace the morty by the master?
> > > > > > > > >
> > > > > > > > > In case the morty branch will be replaced by the master,
> > > current
> > > > > users
> > > > > > > > > will automatically switch to the master without knowing
> the
> > > > > change?
> > > > > > > > >
> > > > > > > > > Regards,
> > > > > > > > > Fujita
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > -----Original Message-----
> > > > > > > > > > From: cip-dev-bounces at lists.cip-project.org
> > > > > > > > > <cip-dev-bounces@lists.cip-
> > > > > > > > > > project.org> On Behalf Of
> kazuhiro3.hayashi at toshiba.co.jp
> > > > > > > > > > Sent: Thursday, March 14, 2019 7:09 PM
> > > > > > > > > > To: daniel.sangorrin at toshiba.co.jp;
> > > > > > > nobuhiro.iwamatsu at miraclelinux.com
> > > > > > > > > > Cc: cip-dev at lists.cip-project.org
> > > > > > > > > > Subject: Re: [cip-dev] about branch of meta-debian in
> cip-
> > > > > core/deby
> > > > > > > > > >
> > > > > > > > > > Iwamatsu-san, Daniel,
> > > > > > > > > >
> > > > > > > > > > > > It provides debian 8 packages in OE/recipe. Is there
> any
> > > > > reason
> > > > > > > to
> > > > > > > > > > > > choose morty/debian 8?
> > > > > > > > > > In my understanding, this is the initial repository
> which
> > > was
> > > > > created
> > > > > > > > > > when the master branch (Debian 10 based) didn't exist
> yet.
> > > > > > > > > > We are planning to update it to the current master
> branch.
> > > > > > > > > >
> > > > > > > > > > I have another question about how to do that.
> > > > > > > > > > Should we keep the morty branch and add contents of
> master
> > > to
> > > > > another
> > > > > > > > > cip-
> > > > > > > > > > core branch,
> > > > > > > > > > or just replace the morty by the master?
> > > > > > > > > >
> > > > > > > > > > Regards,
> > > > > > > > > > Kazu
> > > > > > > > > >
> > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > From: cip-dev-bounces at lists.cip-project.org
> > > > > > > > > > > [mailto:cip-dev-bounces at lists.cip-project.org] On
> Behalf
> > > Of
> > > > > > > > > > > daniel.sangorrin at toshiba.co.jp
> > > > > > > > > > > Sent: Thursday, March 14, 2019 2:52 PM
> > > > > > > > > > > To: nobuhiro.iwamatsu at miraclelinux.com
> > > > > > > > > > > Cc: cip-dev at lists.cip-project.org
> > > > > > > > > > > Subject: Re: [cip-dev] about branch of meta-debian in
> cip-
> > > > > core/deby
> > > > > > > > > > >
> > > > > > > > > > > Iwamatsu-san,
> > > > > > > > > > >
> > > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > > From: Nobuhiro Iwamatsu
> > > <nobuhiro.iwamatsu@miraclelinux.com>
> > > > > > > > > > > > Sent: Wednesday, March 13, 2019 4:38 PM
> > > > > > > > > > > > To: sangorrin daniel(????? ???? ?????
> ??
> > > ?)
> > > > > > > > > > > <daniel.sangorrin@toshiba.co.jp>
> > > > > > > > > > > > Cc: cip-dev at lists.cip-project.org
> > > > > > > > > > > > Subject: about branch of meta-debian in cip-
> core/deby
> > > > > > > > > > > >
> > > > > > > > > > > > Hi, Daniel.
> > > > > > > > > > > >
> > > > > > > > > > > > I have a question about about branch of meta-debian
> in
> > > cip-
> > > > > > > > core/deby.
> > > > > > > > > > > >
> > > > > > > > > > > > The meta-debian branch used by cip-core/deby  is
> morty.
> > > > > > > > > > > > It provides debian 8 packages in OE/recipe. Is there
> any
> > > > > reason
> > > > > > > to
> > > > > > > > > > > > choose morty/debian 8?
> > > > > > > > > > > > Is the reason why the mata-debian master branch is
> still
> > > in
> > > > > > > > > > development?
> > > > > > > > > > > > Will you/we switch to the master branch when Debian
> 10
> > > is
> > > > > > > > released?
> > > > > > > > > > >
> > > > > > > > > > > Yes, that's correct.
> > > > > > > > > > >
> > > > > > > > > > > Thanks,
> > > > > > > > > > > Daniel
> > > > > > > > > > > _______________________________________________
> > > > > > > > > > > cip-dev mailing list
> > > > > > > > > > > cip-dev at lists.cip-project.org
> > > > > > > > > > > https://lists.cip-project.org/mailman/listinfo/cip-dev
> > > > > > > > > > _______________________________________________
> > > > > > > > > > cip-dev mailing list
> > > > > > > > > > cip-dev at lists.cip-project.org
> > > > > > > > > > https://lists.cip-project.org/mailman/listinfo/cip-dev
> > > > > > _______________________________________________
> > > > > > cip-dev mailing list
> > > > > > cip-dev at lists.cip-project.org
> > > > > > https://lists.cip-project.org/mailman/listinfo/cip-dev
