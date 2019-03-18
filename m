From: kazuhiro3.hayashi@toshiba.co.jp (kazuhiro3.hayashi at toshiba.co.jp)
Date: Mon, 18 Mar 2019 01:51:53 +0000
Subject: [cip-dev] about branch of meta-debian in cip-core/deby
In-Reply-To: <OSBPR01MB499953893394AAC252B66DC6D9440@OSBPR01MB4999.jpnprd01.prod.outlook.com>
References: <CAGDrK-a79Z7rc=JibAU_8TL=7GtVFocGfvne9iQ4MsCa1oGU1w@mail.gmail.com>
	<OSAPR01MB3763870A4581B882D1AC1ADAD04B0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<OSAPR01MB30444CACDE60382555A681DCE14B0@OSAPR01MB3044.jpnprd01.prod.outlook.com>
	<OSBPR01MB499953893394AAC252B66DC6D9440@OSBPR01MB4999.jpnprd01.prod.outlook.com>
Message-ID: <TY2PR01MB305133BDEEBBDE5D8386AB97E1470@TY2PR01MB3051.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Fujita-san,
CC: Jan

> In case the morty branch will be replaced by the master, current users
> will automatically switch to the master without knowing the change?
No, user can not automatically migrate from morty to master without knowing the changes
because several specifications about recipe development has been deferent between them.

Therefore, regarding deby repository, it would be better to provide branches
"morty" and "master" as follows:
	Current                  New
	master(poky:morty-based) => morty
	-                        => master(poky:master-based)
	jethro                   => remove? (no longer maintained in meta-debian)

I would like to know if we need to the common branch name in cip-core.
For example: cip-core-v1(4.4+Debian8/9?), cip-core-v2(4.19+Debian10), ...

If the both tiny(deby) and generic profile(isar) are based on the same
CIP kernel and Debian versions, we can use such common branch name above.
If not, or no benefit for users to use the common branch name, 
I would like to simply use "morty" and "master" in deby repository.

Kind regards,
Kazu

> -----Original Message-----
> From: Kazuhiro Fujita [mailto:kazuhiro.fujita.jg at renesas.com]
> Sent: Friday, March 15, 2019 11:39 AM
> To: hayashi kazuhiro(? ?? ????????)
> <kazuhiro3.hayashi@toshiba.co.jp>; sangorrin daniel(????? ????
> ????????) <daniel.sangorrin@toshiba.co.jp>;
> nobuhiro.iwamatsu at miraclelinux.com
> Cc: cip-dev at lists.cip-project.org
> Subject: RE: about branch of meta-debian in cip-core/deby
> 
> Hello Hayashi-san,
> 
> > Should we keep the morty branch and add contents of master to another
> cip-
> > core branch, or just replace the morty by the master?
> 
> In case the morty branch will be replaced by the master, current users
> will automatically switch to the master without knowing the change?
> 
> Regards,
> Fujita
> 
> 
> > -----Original Message-----
> > From: cip-dev-bounces at lists.cip-project.org
> <cip-dev-bounces@lists.cip-
> > project.org> On Behalf Of kazuhiro3.hayashi at toshiba.co.jp
> > Sent: Thursday, March 14, 2019 7:09 PM
> > To: daniel.sangorrin at toshiba.co.jp; nobuhiro.iwamatsu at miraclelinux.com
> > Cc: cip-dev at lists.cip-project.org
> > Subject: Re: [cip-dev] about branch of meta-debian in cip-core/deby
> >
> > Iwamatsu-san, Daniel,
> >
> > > > It provides debian 8 packages in OE/recipe. Is there any reason to
> > > > choose morty/debian 8?
> > In my understanding, this is the initial repository which was created
> > when the master branch (Debian 10 based) didn't exist yet.
> > We are planning to update it to the current master branch.
> >
> > I have another question about how to do that.
> > Should we keep the morty branch and add contents of master to another
> cip-
> > core branch,
> > or just replace the morty by the master?
> >
> > Regards,
> > Kazu
> >
> > > -----Original Message-----
> > > From: cip-dev-bounces at lists.cip-project.org
> > > [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of
> > > daniel.sangorrin at toshiba.co.jp
> > > Sent: Thursday, March 14, 2019 2:52 PM
> > > To: nobuhiro.iwamatsu at miraclelinux.com
> > > Cc: cip-dev at lists.cip-project.org
> > > Subject: Re: [cip-dev] about branch of meta-debian in cip-core/deby
> > >
> > > Iwamatsu-san,
> > >
> > > > -----Original Message-----
> > > > From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu@miraclelinux.com>
> > > > Sent: Wednesday, March 13, 2019 4:38 PM
> > > > To: sangorrin daniel(????? ???? ????????)
> > > <daniel.sangorrin@toshiba.co.jp>
> > > > Cc: cip-dev at lists.cip-project.org
> > > > Subject: about branch of meta-debian in cip-core/deby
> > > >
> > > > Hi, Daniel.
> > > >
> > > > I have a question about about branch of meta-debian in cip-core/deby.
> > > >
> > > > The meta-debian branch used by cip-core/deby  is morty.
> > > > It provides debian 8 packages in OE/recipe. Is there any reason to
> > > > choose morty/debian 8?
> > > > Is the reason why the mata-debian master branch is still in
> > development?
> > > > Will you/we switch to the master branch when Debian 10 is released?
> > >
> > > Yes, that's correct.
> > >
> > > Thanks,
> > > Daniel
> > > _______________________________________________
> > > cip-dev mailing list
> > > cip-dev at lists.cip-project.org
> > > https://lists.cip-project.org/mailman/listinfo/cip-dev
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
