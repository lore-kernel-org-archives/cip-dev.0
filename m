From: kazuhiro3.hayashi@toshiba.co.jp (kazuhiro3.hayashi at toshiba.co.jp)
Date: Tue, 24 Dec 2019 13:03:28 +0000
Subject: [cip-dev] [cip-core] Update PDP to 3.0 (was: RE: [cip-core] Package
 Proposal #1 (Security packages))
Message-ID: <TYXPR01MB1808587B78F0706ECDFC4312E1290@TYXPR01MB1808.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Jan, Kent, and all CIP core members,

> Anyway, I will create and share a sample of proposal.yml with the flat package set,
> please review that and confirm if it matches your opinion of the "CIP maintained packages".

I would like to confirm that the following solution can satisfy our requirements.

Examples:
* proposal*.yml: The package proposal file that a proposer is creating using "generate-proposal.py"
* pkglist_buster.yml: Existing "supported" package list, that was created/updated before
(See the attached files. All information except "bin_pkgs" are dropped to simplify.)

Solution:
0. Use the same YML format as Kent's proposal (Don't change the current YML format)
1. Add a new script "check-deps.py" to check if binary packages in "depends:" are included in
   either "proposal.yml" or "pkglist_buster.yml"
2. "generate-proposal.py" runs "check-deps.py" at the end and proposer needs to
   add more packages to "proposal.yml" if unmet dependencies are reported by "check-deps.py"
3. The proposer can request the package proposal only if "check-deps.py" reports nothing

In the attached examples, the initial proposal "proposal1.yml" has an unmet dependency (= lsb-base).
"check-deps.py" reports this then the proposer add "lsb-base" source package and binary package
to the second proposal "proposal2.yml", which satisfies all run-time dependencies
so can be proposed to cip-dev.

What do you think?
If OK, we will update the scripts in https://gitlab.com/cip-project/cip-core/cip-pkglist
based on the above solution.

Best regards,
Kazu

> 
> Hello Jan and CIP core members,
> 
> > Hi all,
> >
> > On 20.12.19 10:58, kazuhiro3.hayashi at toshiba.co.jp wrote:
> > >>>>>     suricata:
> > >>>>>       bin_pkgs:
> > >>>>>         suricata:
> > >>>>>           depends:
> > >>>>>           - dpkg
> > >>>>>           - python
> > >>>>>           - python-simplejson
> > >>>>
> > >>>> I'm missing the new dependencies in the top-list. Didn't we agree on listing them flat?
> > >>>> This, e.g., pulls python, currently even v2 - anything but a trivial package. Or did I miss that we have this
> > in
> > >> our list already?
> > >>>
> > >>> @kazuhiro3.hayashi at toshiba.co.jp and @Dinesh Kumar,
> > >>> Do you need a script modification to address this issue?
> > >
> > > We need to reconsider the format of proposal.yml (and scripts as well).
> > > It seems not to be reviewed enough.
> > >
> > >>> Actually, proposals for run-time dependencies package of top-lists are still in preparation and are under
> > investigation
> > >> in the security working group.
> > >>> The automatic outputs of the script have been used as it is for the dependencies package displayed in this proposal.
> > >>
> > >> We can only decide about package sets which have their runtime
> > >> dependencies already fulfilled with the existing package set (where is
> > >> that now, BTW?) or include these dependencies in the set.
> > >
> > > I'm assuming the "existing package set" is the list of packages that are already accepted by CIP.
> > > If so, there is no such list because this is the first proposal.
> >
> > Then let's define that base (minimal debootstrap) first before adding
> > further packages.
> 
> OK, let's start from defining this base.
> 
> >
> > >
> > > Also, it's difficult for me to agree with the opinion that
> > > "all runtime dependencies must be fullfilled with the existing package set" because
> > > 1) Some dependency (binary) packages are not functionally necessary
> > >     from the CIP's long-term support point of view (debconf, debian-archive-keyring, etc.)
> >
> > Anything that a Debian package requires needs to be present - otherwise
> > the package becomes broken. I can't imagine we want to propose that to
> > our users. Weaker dependencies are obviously optional.
> 
> Yes, anything required by Debian package needs to be "present",
> but it is not always necessary to "maintain" their source
> (e.g. Request them to Debian Extended LTS).
> 
> I think that there are two kinds in our "support" levels:
> (1) Just make the package available (present) in CIP at least 10 years
> (2) (1) + Keep watching the latest bugs and security issues and fixing them aggressively
> I was understanding that the CIP package list we are discussing is
> for clarifying the packages like (2).
> However, if no one in CIP care about the difference between (1) and (2),
> we should simply define the package list including all binary package dependencies, like Jan mentioned.
> 
> >
> > If we should run into a package that seems to require more than it
> > should, let's improve it by proposing a break-up upstream. Or by
> > repackaging it in meta-debian / isar-cip-core. But that should come
> > first before proposing it here.
> 
> It would be better if the both profiles can have such improved packages,
> but actually changing upstream (Debian) takes much time and effort and
> repackaging by ourselves may bring big impacts to package compatibilities,
> especially in the generic profile.
> 
> >
> > > 2) The list including all dependencies may become big for CIP's "OSBL"
> > >     (e.g. If following this, the security package proposal pulls around 90 packages finally)
> >
> > Anything in that range still seems reasonable from a maintenance
> > perspective - provided there are no "challenging" packages included. But
> > we should still check if that number is seriously needed, though.
> 
> OK, let's discuss about this number in the future proposal.
> 
> Anyway, I will create and share a sample of proposal.yml with the flat package set,
> please review that and confirm if it matches your opinion of the "CIP maintained packages".
> 
> Kazu
> 
> >
> > Jan
> >
> > >
> > >> I only checked
> > >> suricata because of the outstanding python dependency, but there might
> > >> be more issue. This needs to be checked carefully again.
> > >
> > > Yes, we need to share the concrete examples of packages, PDP steps, and the format of yml.
> > > I will prepare this and will share in the next week.
> > >
> > > So, please suspend this proposal process until requirements of all members become clear.
> > >
> > > Kazu
> > >
> > >>
> > >> Jan
> > >>
> > >>>
> > >>> Best regards,
> > >>> Kent
> > >>> -----Original Message-----
> > >>> From: cip-dev <cip-dev-bounces@lists.cip-project.org> On Behalf Of Jan Kiszka
> > >>> Sent: Thursday, December 19, 2019 7:48 PM
> > >>> To: kazuhiro3.hayashi at toshiba.co.jp; cip-dev at lists.cip-project.org
> > >>> Subject: Re: [cip-dev] [cip-core] Package Proposal #1 (Security packages)
> > >>>
> > >>> On 09.12.19 14:54, kazuhiro3.hayashi at toshiba.co.jp wrote:
> > >>>> Hello CIP Core members,
> > >>>>
> > >>>> I would like to start the "review" phase (Phase 2) of the attached package proposal.
> > >>>> https://gitlab.com/cip-project/cip-core/cip-pkglist/blob/master/doc/pd
> > >>>> p.md#phase-2-proposal-review
> > >>>>
> > >>>> The packages are proposed by CIP security WG to satisfy their required features.
> > >>>> See the "reason" fields in the proposal for more details.
> > >>>>
> > >>>> Please reply with you opinion, agree or disagree.
> > >>>> If you cannot agree to add specific packages, please show the reasons as well.
> > >>>>
> > >>>> Due Date: December 23rd
> > >>>> (We can extend this due date if more time required for reviews, please
> > >>>> let me know if any requests)
> > >>>>
> > >>>
> > >>> [...]
> > >>>
> > >>>>     chrony:
> > >>>>       bin_pkgs:
> > >>>>         chrony:
> > >>>>           depends:
> > >>>>           - init-system-helpers
> > >>>>           - adduser
> > >>>>           - iproute2
> > >>>>           - lsb-base
> > >>>>           - ucf
> > >>>>           - libc6
> > >>>>           - libcap2
> > >>>>           - libedit2
> > >>>>           - libnettle6
> > >>>>           - libseccomp2
> > >>>>       in_target: 'True'
> > >>>>       n_cve: '10'
> > >>>>       reason: For supporting IEC-62443-4-2 certification for CR 2.11, 2.11(1)
> > >>>>       security_criteria: network::server, network::service
> > >>>
> > >>> Why still chrony, why not simply systemd timers? Legacy?
> > >>>
> > >>>>     suricata:
> > >>>>       bin_pkgs:
> > >>>>         suricata:
> > >>>>           depends:
> > >>>>           - dpkg
> > >>>>           - python
> > >>>>           - python-simplejson
> > >>>
> > >>> I'm missing the new dependencies in the top-list. Didn't we agree on listing them flat? This, e.g., pulls python,
> > >> currently even
> > >>> v2 - anything but a trivial package. Or did I miss that we have this in our list already?
> > >>>
> > >>> Jan
> > >>>
> > >>
> > >>
> > >> --
> > >> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> > >> Corporate Competence Center Embedded Linux
> >
> >
> > --
> > Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> > Corporate Competence Center Embedded Linux
-------------- next part --------------
A non-text attachment was scrubbed...
Name: proposal1.yml
Type: application/octet-stream
Size: 246 bytes
Desc: proposal1.yml
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191224/d39431ae/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: proposal2.yml
Type: application/octet-stream
Size: 311 bytes
Desc: proposal2.yml
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191224/d39431ae/attachment-0001.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pkglist_buster.yml
Type: application/octet-stream
Size: 187 bytes
Desc: pkglist_buster.yml
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191224/d39431ae/attachment-0002.obj>
