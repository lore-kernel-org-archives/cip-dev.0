From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Thu, 31 Jan 2019 05:33:53 +0000
Subject: [cip-dev] [RFC] isar-cip-core
In-Reply-To: <011301d4a65b$003539f0$009fadd0$@toshiba.co.jp>
References: <f3408484-dd40-ef30-6642-dd18dfe2315a@siemens.com>
	<00ed01d4a620$26921860$73b64920$@toshiba.co.jp>
	<1be77add-abce-e4d2-4d47-d371238390bf@siemens.com>
	<010501d4a654$87230570$95691050$@toshiba.co.jp>
	<0c149643-a460-bfe8-3a14-01dd6b7d80c6@siemens.com>
	<011301d4a65b$003539f0$009fadd0$@toshiba.co.jp>
Message-ID: <OSAPR01MB3763E7CB1D9FB549C5479BCED0910@OSAPR01MB3763.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Agustin,

I need to create the following hierarchy on gitlab:

> > > >>> cip-core/ <-- group
> > > >>>       tiny/ <-- subgroup
> > > >>>           deby <-- git repo (current cip-core.git)
> > > >>>       generic/ <-- subgroup
> > > >>>           isar <-- git repo

I don't have enough permissions, could you do that for me and possibly give me permissions for anything under cip-core?

Thanks,
Daniel

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-project.org> On Behalf Of Daniel
> Sangorrin
> Sent: Monday, January 7, 2019 4:31 PM
> To: 'Jan Kiszka' <jan.kiszka@siemens.com>; 'cip-dev' <cip-dev@lists.cip-project.org>
> Subject: Re: [cip-dev] [RFC] isar-cip-core
> 
> > -----Original Message-----
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> > Sent: Monday, January 7, 2019 3:59 PM
> > To: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>; 'cip-dev' <cip-dev@lists.cip-project.org>
> > Subject: Re: [cip-dev] [RFC] isar-cip-core
> >
> >
> >
> > > -----Original Message-----
> > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > Sent: Monday, January 7, 2019 3:59 PM
> > > To: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>; 'cip-dev' <cip-dev@lists.cip-project.org>
> > > Subject: Re: [cip-dev] [RFC] isar-cip-core
> > >
> > > On 07.01.19 07:45, Daniel Sangorrin wrote:
> > > >> -----Original Message-----
> > > >> From: Jan Kiszka <jan.kiszka@siemens.com>
> > > >> Sent: Monday, January 7, 2019 2:41 PM
> > > >> To: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>; 'cip-dev' <cip-dev@lists.cip-project.org>
> > > >> Subject: Re: [cip-dev] [RFC] isar-cip-core
> > > >>
> > > >> Hi Daniel,
> > > >>
> > > >> On 07.01.19 01:30, Daniel Sangorrin wrote:
> > > >>> Hi Jan,
> > > >>>
> > > >>> Thanks for uploading isar-cip-core.
> > > >>>
> > > >>> As you noticed[1], https://gitlab.com/cip-project/cip-core/ contains a folder "deby". I created that
> folder
> > > with
> > > >> the intention of adding "isar" and other tools' metadata at the same folder level.
> > > >>>
> > > >>> cip-core/  <-- git repo
> > > >>>       deby/ <-- deby metadata
> > > >>>       isar/ <-- isar metadata
> > > >>>       eid/ <-- eid metadata
> > > >>>
> > > >>> [Note] Now that we have profiles (tiny and generic) we could add an extra folder for them.
> > > >>>
> > > >>> I think that having all of the metadata on the same repository can be good for communication. For
> > example,
> > > >> after a git-pull I might notice that you updated certain kernel configuration values under the "isar" folder
> > that
> > > >> should be applied to Deby's metadata as well.
> > > >>
> > > >> I agree that shared data like reference configs should ideally be stored in one
> > > >> place. That could be solved by having a single repos for all build systems or by
> > > >> sticking those artifacts into a separate repo. We already have
> > > >> https://gitlab.com/cip-project/cip-kernel/cip-kernel-config - maybe add the
> > > >> configs of the reference boards there?
> > > >
> > > > I said "communication" (like in a monorepo) rather than shared data, because each build tool has different
> > > methods to store that shared data. In the case of a kernel config, it will probably work fine, but there is always
> > > a possibility that we need to add some tuning on the recipe's metadata.
> > >
> > > When it comes to pure communication, the mailing list is a better place. We
> > > could route all cip-core patches through it (rather than splitting up the work
> > > in isolated MRs on gitlab).
> > >
> > > >
> > > >>> Another possibility is to use gitlab groups/subgroups in this way:
> > > >>>
> > > >>> cip-core/ <-- group
> > > >>>       tiny/ <-- subgroup
> > > >>>           deby <-- git repo
> > > >>>       generic/ <-- subgroup
> > > >>>           isar <-- git repo
> > > >>>
> > > >>> I don't have enough permissions to create groups and subgroups under cip-project though (that's the
> > > reason
> > > >> I used the folder approach).
> > > >>>
> > > >>
> > > >> I do. If we agree on the group approach, we need to rename the existing cip-core
> > > >> repo first, and flatten its folder structure. Then I can create the cip-core
> > > >> group as well as the tiny/generic subgroups and move the repo.
> > > >>
> > > >> Later on, we can factor out the kernel configs. Do you see other shared data?
> > > >
> > > > Well, one could be the list of packages for each profile. However, as I mention above it will be hard to share
> > > exactly the same files.
> > >
> > > Yes, sharing the package list 1:1 will only work if the tiny profile follows the
> > > standard Debian binary packaging structure - does/will it?
> 
> Not necessarily.
> For example, Deby follows the Open Embedded structure as far as I know.
> 
> Thanks,
> Daniel
> 
> > >
> > > >
> > > >>> Which way would you prefer?
> > > >>
> > > >> I'm leaning towards separate repos.
> > > >
> > > > OK, then let's analyze the pros and cons and decide today at the TSC meeting.
> > >
> > > Fine with me.
> > >
> > > Jan
> > >
> > > --
> > > Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> > > Corporate Competence Center Embedded Linux
> 
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
