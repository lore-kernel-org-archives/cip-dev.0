From: nobuhiro.iwamatsu@miraclelinux.com (Nobuhiro Iwamatsu)
Date: Mon, 4 Feb 2019 18:09:02 +0900
Subject: [cip-dev] [RFC] isar-cip-core
In-Reply-To: <TY2PR01MB376906D9F7C94A8110FBB71FD06D0@TY2PR01MB3769.jpnprd01.prod.outlook.com>
References: <f3408484-dd40-ef30-6642-dd18dfe2315a@siemens.com>
	<011301d4a65b$003539f0$009fadd0$@toshiba.co.jp>
	<OSAPR01MB3763E7CB1D9FB549C5479BCED0910@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<14479548.GHWBXKJqdG@linux-if6s>
	<CAGDrK-ZTMTrZo5MZmzrc4ibPpdnHeNgC7oXTBWxqZyYGw_3dAA@mail.gmail.com>
	<D9C61175-EF60-4E72-B029-9B7BAF3AA61A@codethink.co.uk>
	<TY2PR01MB376906D9F7C94A8110FBB71FD06D0@TY2PR01MB3769.jpnprd01.prod.outlook.com>
Message-ID: <CAGDrK-a_UEaud04E7RwHJSxLy5-Fkc8npWdnRMgf6yBVaHw7iQ@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi, Daniel.

I have confirmed that the cip-core group is displayed and I can show
to the repository without login.
Thanks for your work.

Best regards,
  Nobuhiro

2019?2?4?(?) 14:37 <daniel.sangorrin@toshiba.co.jp>:
>
> Iwamatsu-san,
>
> I have fixed the permissions. Could you try again and see if it works now?
>
> Thanks,
> Daniel
>
> > -----Original Message-----
> > From: Agustin Benito Bethencourt <agustin.benito@codethink.co.uk>
> > Sent: Friday, February 1, 2019 5:36 PM
> > To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu@miraclelinux.com>
> > Cc: sangorrin daniel(????? ???? ????????) <daniel.sangorrin@toshiba.co.jp>;
> > jan.kiszka at siemens.com; cip-dev at lists.cip-project.org
> > Subject: Re: [cip-dev] [RFC] isar-cip-core
> >
> > Hi,
> >
> > On 1 February 2019 02:35:51 CET, Nobuhiro Iwamatsu <nobuhiro.iwamatsu@miraclelinux.com> wrote:
> > >Hi, Agustin.
> > >
> > >Non-members can not access newly created subgroups.
> > >Previously, since cip-core was published, I think that it is a setting
> > >problem, but how do you do?
> >
> > the  new subgroup has inherited every group member. If you cannot access the new subgroup is because you
> > were member of a different subgroup, not the top group.
> >
> > I am traveling and will not have access the next few hours (I rather do this on a laptop).
> >
> > Yo can be added by the new owners.
> >
> > @Daniel, @Jan there is a config option in the subgroup to allow people to request access.
> >
> > Best Regards
> >
> > >
> > >Best regards,
> > >  Nobuhiro
> > >
> > >2019?1?31?(?) 17:03 Agust?n Benito Bethencourt
> > ><agustin.benito@codethink.co.uk>:
> > >>
> > >> Hi jan and Daniel,
> > >>
> > >> On Thursday, 31 January 2019 06:33:53 CET
> > >daniel.sangorrin at toshiba.co.jp wrote:
> > >> > Hi Agustin,
> > >> >
> > >> > I need to create the following hierarchy on gitlab:
> > >> >
> > >> > > > > >>> cip-core/ <-- group
> > >> > > > > >>>       tiny/ <-- subgroup
> > >> > > > > >>>           deby <-- git repo (current cip-core.git)
> > >> > > > > >>>       generic/ <-- subgroup
> > >> > > > > >>>           isar <-- git repo
> > >>
> > >> I just created the new subgroup called "cip-core". I moved the
> > >project cip-core from the root tree to the new subgroup. I gave both of
> > >you owner rights in this new subgroup so you can configure it as you
> > >please. Please take a few minutes to go over the configurations so you
> > >guys can decide merge request, merge, tickets... strategies. I will be
> > >traveling the coming days but feel free to ask me through mail or IRC
> > >if you want a second opinion on how to set up the subgroup/projects. I
> > >have done it several times with a variety of use cases over the years.
> > >>
> > >> We defined a policy in which each Member company has a person as
> > >Owner of the whole CIP Group. If you think there should be two people
> > >per company to make things more fluid, please propose it. I would be
> > >fine with it. I understand sometimes it is not ideal to depend on
> > >somebody else for these things.
> > >>
> > >> I think it would be useful to agree on basic topics across the
> > >different subgroups like some common labels, milestones. boards... so
> > >we start to apply some consistency across the different groups on very
> > >basic thinks. If you think it might be a good idea I can make a
> > >proposal in the coming days.
> > >>
> > >> Best Regards
> > >>
> > >>
> > >> --
> > >> Agust?n Benito Bethencourt
> > >> Principal Consultant
> > >> Codethink Ltd
> > >> We respect your privacy.   See
> > >https://www.codethink.co.uk/privacy.html
> > >> _______________________________________________
> > >> cip-dev mailing list
> > >> cip-dev at lists.cip-project.org
> > >> https://lists.cip-project.org/mailman/listinfo/cip-dev
> >
> > --
> > Sent from my Android device with K-9 Mail. Please excuse my brevity.
