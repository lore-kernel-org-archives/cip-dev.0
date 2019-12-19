From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Thu, 19 Dec 2019 11:48:13 +0100
Subject: [cip-dev] [cip-core] Package Proposal #1 (Security packages)
In-Reply-To: <OSAPR01MB21135891687655571F2FADFAE1580@OSAPR01MB2113.jpnprd01.prod.outlook.com>
References: <OSAPR01MB21135891687655571F2FADFAE1580@OSAPR01MB2113.jpnprd01.prod.outlook.com>
Message-ID: <7d3f09c5-2b39-1a44-4e49-20de14ad9c66@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 09.12.19 14:54, kazuhiro3.hayashi at toshiba.co.jp wrote:
> Hello CIP Core members,
> 
> I would like to start the "review" phase (Phase 2) of the attached package proposal.
> https://gitlab.com/cip-project/cip-core/cip-pkglist/blob/master/doc/pdp.md#phase-2-proposal-review
> 
> The packages are proposed by CIP security WG to satisfy their required features.
> See the "reason" fields in the proposal for more details.
> 
> Please reply with you opinion, agree or disagree.
> If you cannot agree to add specific packages, please show the reasons as well.
> 
> Due Date: December 23rd
> (We can extend this due date if more time required for reviews, please let me know if any requests)
> 

[...]

>   chrony:
>     bin_pkgs:
>       chrony:
>         depends:
>         - init-system-helpers
>         - adduser
>         - iproute2
>         - lsb-base
>         - ucf
>         - libc6
>         - libcap2
>         - libedit2
>         - libnettle6
>         - libseccomp2
>     in_target: 'True'
>     n_cve: '10'
>     reason: For supporting IEC-62443-4-2 certification for CR 2.11, 2.11(1)
>     security_criteria: network::server, network::service

Why still chrony, why not simply systemd timers? Legacy?

>   suricata:
>     bin_pkgs:
>       suricata:
>         depends:
>         - dpkg
>         - python
>         - python-simplejson

I'm missing the new dependencies in the top-list. Didn't
we agree on listing them flat? This, e.g., pulls python, currently even  
v2 - anything but a trivial package. Or did I miss that we have this in  
our list already?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
