From: kazuhiro3.hayashi@toshiba.co.jp (kazuhiro3.hayashi at toshiba.co.jp)
Date: Tue, 21 Jan 2020 00:48:26 +0000
Subject: [cip-dev] RESUME REQUEST: [cip-core] Package Proposal #1
 (Security packages)
In-Reply-To: <2ed4b668-0670-21e6-c722-4b1a043a4383@siemens.com>
References: <OSAPR01MB23880B5470CDE5D534181CF5DF310@OSAPR01MB2388.jpnprd01.prod.outlook.com>
 <TYXPR01MB1808C972C58E85F8ACADBEFDE1310@TYXPR01MB1808.jpnprd01.prod.outlook.com>
 <2ed4b668-0670-21e6-c722-4b1a043a4383@siemens.com>
Message-ID: <TYXPR01MB1808126FE9E047C08B17D135E10D0@TYXPR01MB1808.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello,

> On 17.01.20 14:14, kazuhiro3.hayashi at toshiba.co.jp wrote:
> > Hello Kent,
> >
> > [...]
> >> 3. Actually several packages overlap with the proposed packages for minimum base system in Debian, so I added comment
> >> them like that.
> >
> > Thank you for taking time to check this...
> > In order to clearly show the differences of my proposal #2 and your proposal,
> > it might be better to create additional yml file where the duplicated packages are dropped.
> > I will try to create this data next week :)
> >
> >>
> >> @kazuhiro3.hayashi at toshiba.co.jp,
> >> Would you check this proposal and set the due date to review it?
> >
> > The proposal #2 is now proceeding in parallel so it's a bit difficult to decide
> > but how about setting it to Jan 27th?
> 
> As I'm not in the house next week, I will not be able to comment on the
> new list, nor vote. In any case, one week might be ok for a short,
> obvious list. But if we are talking about a list of dozens of packages,
> that will be too short.

Thank you for your reply.

I would like to change the due date to
	Feb 5th (two weeks + 3 days)
Regarding security packages, I guess more discussions about
the technical requirements of the security standard would be required,
so this change might not be enough too though.

Kazu

> 
> Jan
> 
> >
> > Best regards,
> > Kazu
> >
> >>
> >> Please reply if you have any comments or questions.
> >>
> >> Kind regards,
> >> Kent
> >>
> >>> -----Original Message-----
> >>> From: kazuhiro3.hayashi at toshiba.co.jp <kazuhiro3.hayashi@toshiba.co.jp>
> >>> Sent: Friday, December 20, 2019 6:59 PM
> >>> To: jan.kiszka at siemens.com; Kento Yoshida <kento.yoshida.wz@renesas.com>;
> >>> cip-dev at lists.cip-project.org; dinesh.kumar at toshiba-tsip.com
> >>> Subject: RE: [cip-dev] [cip-core] Package Proposal #1 (Security packages)
> >>>
> >>> Hello,
> >>>
> >>>> On 20.12.19 03:25, Kento Yoshida wrote:
> >>>>> Thank you for your feedback, Jan.
> >>>>>
> >>>>>> Why still chrony, why not simply systemd timers? Legacy?
> >>>>>
> >>>>> We agree that systemd-timesyncd is sufficient for users who need only SNTP
> >>> client functionality.
> >>>>> The reason we want to add Chrony to our core packages is to support
> >>>>> various use cases, and because Chrony is recognized
> >>>> by CII as being a superior secure NTP implementation.
> >>>>> https://www.coreinfrastructure.org/blogs/securing-network-time/
> >>>>>
> >>>>> Since the CII aims to invest in core infrastructure, providing funding for
> >>> fundamental projects, I think "chrony"
> >>>> would be more secure and sustainable.
> >>>>>
> >>>>
> >>>> Oops, I actually confused cron and chrony here. Interestingly, the
> >>>> question "can't systemd do that?" remained valid :).
> >>>>
> >>>> I agree to pick the more mature solution for this purpose.
> >>>>
> >>>>>>>     suricata:
> >>>>>>>       bin_pkgs:
> >>>>>>>         suricata:
> >>>>>>>           depends:
> >>>>>>>           - dpkg
> >>>>>>>           - python
> >>>>>>>           - python-simplejson
> >>>>>>
> >>>>>> I'm missing the new dependencies in the top-list. Didn't we agree on listing
> >>> them flat?
> >>>>>> This, e.g., pulls python, currently even v2 - anything but a
> >>>>>> trivial package. Or did I miss that we have this in
> >>>> our list already?
> >>>>>
> >>>>> @kazuhiro3.hayashi at toshiba.co.jp and @Dinesh Kumar, Do you need a
> >>>>> script modification to address this issue?
> >>>
> >>> We need to reconsider the format of proposal.yml (and scripts as well).
> >>> It seems not to be reviewed enough.
> >>>
> >>>>> Actually, proposals for run-time dependencies package of top-lists
> >>>>> are still in preparation and are under investigation
> >>>> in the security working group.
> >>>>> The automatic outputs of the script have been used as it is for the
> >>> dependencies package displayed in this proposal.
> >>>>
> >>>> We can only decide about package sets which have their runtime
> >>>> dependencies already fulfilled with the existing package set (where is
> >>>> that now, BTW?) or include these dependencies in the set.
> >>>
> >>> I'm assuming the "existing package set" is the list of packages that are already
> >>> accepted by CIP.
> >>> If so, there is no such list because this is the first proposal.
> >>>
> >>> Also, it's difficult for me to agree with the opinion that "all runtime dependencies
> >>> must be fullfilled with the existing package set" because
> >>> 1) Some dependency (binary) packages are not functionally necessary
> >>>    from the CIP's long-term support point of view (debconf,
> >>> debian-archive-keyring, etc.)
> >>> 2) The list including all dependencies may become big for CIP's "OSBL"
> >>>    (e.g. If following this, the security package proposal pulls around 90 packages
> >>> finally)
> >>>
> >>>> I only checked
> >>>> suricata because of the outstanding python dependency, but there might
> >>>> be more issue. This needs to be checked carefully again.
> >>>
> >>> Yes, we need to share the concrete examples of packages, PDP steps, and the
> >>> format of yml.
> >>> I will prepare this and will share in the next week.
> >>>
> >>> So, please suspend this proposal process until requirements of all members
> >>> become clear.
> >>>
> >>> Kazu
> >>>
> >>>>
> >>>> Jan
> >>>>
> >>>>>
> >>>>> Best regards,
> >>>>> Kent
> >>>>> -----Original Message-----
> >>>>> From: cip-dev <cip-dev-bounces@lists.cip-project.org> On Behalf Of
> >>>>> Jan Kiszka
> >>>>> Sent: Thursday, December 19, 2019 7:48 PM
> >>>>> To: kazuhiro3.hayashi at toshiba.co.jp; cip-dev at lists.cip-project.org
> >>>>> Subject: Re: [cip-dev] [cip-core] Package Proposal #1 (Security
> >>>>> packages)
> >>>>>
> >>>>> On 09.12.19 14:54, kazuhiro3.hayashi at toshiba.co.jp wrote:
> >>>>>> Hello CIP Core members,
> >>>>>>
> >>>>>> I would like to start the "review" phase (Phase 2) of the attached package
> >>> proposal.
> >>>>>> https://gitlab.com/cip-project/cip-core/cip-pkglist/blob/master/doc
> >>>>>> /pd
> >>>>>> p.md#phase-2-proposal-review
> >>>>>>
> >>>>>> The packages are proposed by CIP security WG to satisfy their required
> >>> features.
> >>>>>> See the "reason" fields in the proposal for more details.
> >>>>>>
> >>>>>> Please reply with you opinion, agree or disagree.
> >>>>>> If you cannot agree to add specific packages, please show the reasons as well.
> >>>>>>
> >>>>>> Due Date: December 23rd
> >>>>>> (We can extend this due date if more time required for reviews,
> >>>>>> please let me know if any requests)
> >>>>>>
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>>>     chrony:
> >>>>>>       bin_pkgs:
> >>>>>>         chrony:
> >>>>>>           depends:
> >>>>>>           - init-system-helpers
> >>>>>>           - adduser
> >>>>>>           - iproute2
> >>>>>>           - lsb-base
> >>>>>>           - ucf
> >>>>>>           - libc6
> >>>>>>           - libcap2
> >>>>>>           - libedit2
> >>>>>>           - libnettle6
> >>>>>>           - libseccomp2
> >>>>>>       in_target: 'True'
> >>>>>>       n_cve: '10'
> >>>>>>       reason: For supporting IEC-62443-4-2 certification for CR 2.11, 2.11(1)
> >>>>>>       security_criteria: network::server, network::service
> >>>>>
> >>>>> Why still chrony, why not simply systemd timers? Legacy?
> >>>>>
> >>>>>>     suricata:
> >>>>>>       bin_pkgs:
> >>>>>>         suricata:
> >>>>>>           depends:
> >>>>>>           - dpkg
> >>>>>>           - python
> >>>>>>           - python-simplejson
> >>>>>
> >>>>> I'm missing the new dependencies in the top-list. Didn't we agree on
> >>>>> listing them flat? This, e.g., pulls python,
> >>>> currently even
> >>>>> v2 - anything but a trivial package. Or did I miss that we have this in our list
> >>> already?
> >>>>>
> >>>>> Jan
> >>>>>
> >>>>
> >>>>
> >>>> --
> >>>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate
> >>>> Competence Center Embedded Linux
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
> >
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
