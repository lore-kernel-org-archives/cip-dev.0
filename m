From: masashi.kudo@cybertrust.co.jp (masashi.kudo at cybertrust.co.jp)
Date: Mon, 23 Dec 2019 00:06:16 +0000
Subject: [cip-dev] [cip-core] Package Proposal #1 (Security packages)
In-Reply-To: <TYXPR01MB180860D882554FA432EC34ACE12F0@TYXPR01MB1808.jpnprd01.prod.outlook.com>
References: <OSAPR01MB21135891687655571F2FADFAE1580@OSAPR01MB2113.jpnprd01.prod.outlook.com>
 <7d3f09c5-2b39-1a44-4e49-20de14ad9c66@siemens.com>
 <TYAPR01MB23993EFD3E091749C6DAFD62DF2D0@TYAPR01MB2399.jpnprd01.prod.outlook.com>
 <e752eb78-fa1d-6b97-884c-a5515c85521d@siemens.com>
 <OSAPR01MB2113AFF81737726CED0E26FFE12D0@OSAPR01MB2113.jpnprd01.prod.outlook.com>
 <CAFa_k0jbziJJL1AW1EPvMAboiaLLv1JeGpMWgoBQExO7zNixPw@mail.gmail.com>
 <TYXPR01MB180860D882554FA432EC34ACE12F0@TYXPR01MB1808.jpnprd01.prod.outlook.com>
Message-ID: <CAFa_k0iHbfg=SYiosCH8T9SKoF8KKZ1Kd2VfDxc27h7QQssAtQ@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Kazu-san,

I understood. Thanks very much!
--
M. Kudo

2019?12?23?(?) 8:43 <kazuhiro3.hayashi at toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>>:
Good morning Kudo-san,

>> So, please suspend this proposal process until requirements of all members become clear.
> Does this means that the above due date is extended and the new due date will be announced later?

Yes. I will share the new due date ASAP, but it would be a day in January...

Best regards,
Kazu

From: masashi.kudo@cybertrust.co.jp<mailto:masashi.kudo@cybertrust.co.jp> [mailto:masashi.kudo at cybertrust.co.jp<mailto:masashi.kudo@cybertrust.co.jp>]
Sent: Monday, December 23, 2019 7:59 AM
To: hayashi kazuhiro(? ?? ????????) <kazuhiro3.hayashi at toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>>
Cc: jan.kiszka at siemens.com<mailto:jan.kiszka@siemens.com>; kento.yoshida.wz at renesas.com<mailto:kento.yoshida.wz@renesas.com>; cip-dev at lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>; dinesh kumar(???? DS Company) <dinesh.kumar at toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>
Subject: Re: [cip-dev] [cip-core] Package Proposal #1 (Security packages)

Kazu-san,

Thanks for working on this.

  > Due Date: December 23rd
Originally, the due date was today.

> So, please suspend this proposal process until requirements of all members become clear.
Does this means that the above due date is extended and the new due date will be announced later?
Just to make sure.

Best regards,
--
M. Kudo


2019?12?20?(?) 18:59 <kazuhiro3.hayashi at toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>>:
Hello,

> On 20.12.19 03:25, Kento Yoshida wrote:
> > Thank you for your feedback, Jan.
> >
> >> Why still chrony, why not simply systemd timers? Legacy?
> >
> > We agree that systemd-timesyncd is sufficient for users who need only SNTP client functionality.
> > The reason we want to add Chrony to our core packages is to support various use cases, and because Chrony is recognized
> by CII as being a superior secure NTP implementation.
> > https://www.coreinfrastructure.org/blogs/securing-network-time/
> >
> > Since the CII aims to invest in core infrastructure, providing funding for fundamental projects, I think "chrony"
> would be more secure and sustainable.
> >
>
> Oops, I actually confused cron and chrony here. Interestingly, the
> question "can't systemd do that?" remained valid :).
>
> I agree to pick the more mature solution for this purpose.
>
> >>>    suricata:
> >>>      bin_pkgs:
> >>>        suricata:
> >>>          depends:
> >>>          - dpkg
> >>>          - python
> >>>          - python-simplejson
> >>
> >> I'm missing the new dependencies in the top-list. Didn't we agree on listing them flat?
> >> This, e.g., pulls python, currently even v2 - anything but a trivial package. Or did I miss that we have this in
> our list already?
> >
> > @kazuhiro3.hayashi at toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp> and @Dinesh Kumar,
> > Do you need a script modification to address this issue?

We need to reconsider the format of proposal.yml (and scripts as well).
It seems not to be reviewed enough.

> > Actually, proposals for run-time dependencies package of top-lists are still in preparation and are under investigation
> in the security working group.
> > The automatic outputs of the script have been used as it is for the dependencies package displayed in this proposal.
>
> We can only decide about package sets which have their runtime
> dependencies already fulfilled with the existing package set (where is
> that now, BTW?) or include these dependencies in the set.

I'm assuming the "existing package set" is the list of packages that are already accepted by CIP.
If so, there is no such list because this is the first proposal.

Also, it's difficult for me to agree with the opinion that
"all runtime dependencies must be fullfilled with the existing package set" because
1) Some dependency (binary) packages are not functionally necessary
   from the CIP's long-term support point of view (debconf, debian-archive-keyring, etc.)
2) The list including all dependencies may become big for CIP's "OSBL"
   (e.g. If following this, the security package proposal pulls around 90 packages finally)

> I only checked
> suricata because of the outstanding python dependency, but there might
> be more issue. This needs to be checked carefully again.

Yes, we need to share the concrete examples of packages, PDP steps, and the format of yml.
I will prepare this and will share in the next week.

So, please suspend this proposal process until requirements of all members become clear.

Kazu

>
> Jan
>
> >
> > Best regards,
> > Kent
> > -----Original Message-----
> > From: cip-dev <cip-dev-bounces at lists.cip-project.org<mailto:cip-dev-bounces@lists.cip-project.org>> On Behalf Of Jan Kiszka
> > Sent: Thursday, December 19, 2019 7:48 PM
> > To: kazuhiro3.hayashi at toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>; cip-dev at lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
> > Subject: Re: [cip-dev] [cip-core] Package Proposal #1 (Security packages)
> >
> > On 09.12.19 14:54, kazuhiro3.hayashi at toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp> wrote:
> >> Hello CIP Core members,
> >>
> >> I would like to start the "review" phase (Phase 2) of the attached package proposal.
> >> https://gitlab.com/cip-project/cip-core/cip-pkglist/blob/master/doc/pd
> >> p.md#phase-2-proposal-review
> >>
> >> The packages are proposed by CIP security WG to satisfy their required features.
> >> See the "reason" fields in the proposal for more details.
> >>
> >> Please reply with you opinion, agree or disagree.
> >> If you cannot agree to add specific packages, please show the reasons as well.
> >>
> >> Due Date: December 23rd
> >> (We can extend this due date if more time required for reviews, please
> >> let me know if any requests)
> >>
> >
> > [...]
> >
> >>    chrony:
> >>      bin_pkgs:
> >>        chrony:
> >>          depends:
> >>          - init-system-helpers
> >>          - adduser
> >>          - iproute2
> >>          - lsb-base
> >>          - ucf
> >>          - libc6
> >>          - libcap2
> >>          - libedit2
> >>          - libnettle6
> >>          - libseccomp2
> >>      in_target: 'True'
> >>      n_cve: '10'
> >>      reason: For supporting IEC-62443-4-2 certification for CR 2.11, 2.11(1)
> >>      security_criteria: network::server, network::service
> >
> > Why still chrony, why not simply systemd timers? Legacy?
> >
> >>    suricata:
> >>      bin_pkgs:
> >>        suricata:
> >>          depends:
> >>          - dpkg
> >>          - python
> >>          - python-simplejson
> >
> > I'm missing the new dependencies in the top-list. Didn't we agree on listing them flat? This, e.g., pulls python,
> currently even
> > v2 - anything but a trivial package. Or did I miss that we have this in our list already?
> >
> > Jan
> >
>
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
_______________________________________________
cip-dev mailing list
cip-dev at lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
https://lists.cip-project.org/mailman/listinfo/cip-dev
_______________________________________________
cip-dev mailing list
cip-dev at lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
https://lists.cip-project.org/mailman/listinfo/cip-dev
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191223/dcc53d5b/attachment-0001.html>
