From: kazuhiro3.hayashi@toshiba.co.jp (kazuhiro3.hayashi at toshiba.co.jp)
Date: Mon, 20 Jan 2020 14:24:05 +0000
Subject: [cip-dev] [cip-core] Package Proposal #2 (Minimum base packages
 in Debian)
In-Reply-To: <OSBPR01MB5127312322C246858BDFBE6EA0320@OSBPR01MB5127.jpnprd01.prod.outlook.com>
References: <TYXPR01MB1808E5730818EAB90EB9558FE1360@TYXPR01MB1808.jpnprd01.prod.outlook.com>
 <CAFa_k0h_716U9+OqYvhO4EBEYO=F6vh-VEvRQEKa+5OK8UQ8fQ@mail.gmail.com>
 <OSBPR01MB5127312322C246858BDFBE6EA0320@OSBPR01MB5127.jpnprd01.prod.outlook.com>
Message-ID: <TYXPR01MB1808FE39FEC89178080ACEF8E1320@TYXPR01MB1808.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Kudo-san,

Thank you for pointing this out.
I created the issue about this on CIP GitLab.
https://gitlab.com/cip-project/cip-core/cip-pkglist/issues/1

Best regards,
Kazu

From: cip-dev [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of masashi.kudo at cybertrust.co.jp
Sent: Monday, January 20, 2020 9:18 AM
To: cip-dev at lists.cip-project.org
Subject: Re: [cip-dev] [cip-core] Package Proposal #2 (Minimum base packages in Debian)

Hi, Kazu-san,

Agree on this proposal on behalf of Cybertrust.

BTW, libpam-runtime listed as a binary package of pam has a dependency on debconf. The debconf is shown twice. It does not affect the result, but if you have time, please double check the script..

Best regards,
--
M. Kudo

From: <kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>>
Date: 2020?1?16?(?) 17:25
Subject: [cip-dev] [cip-core] Package Proposal #2 (Minimum base packages in Debian)
To: <cip-dev at lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>>


Hello CIP Core members,

I created a simple package proposal for the packages that are installed in the "minimum base system" of Debian.
These packages are installed by
        $ debootstrap --variant=minbase buster ...

It consists of 58 source packages and 84 binary packages, including all run-time dependencies.

The common reason to propose:
"This package is included in the minimum base system of Debian (debootstrap --variant=minbase),
which is essential for all Debian binary package based systems"


I would like to start the "review" phase (Phase 2) of the attached package proposal.
https://gitlab.com/cip-project/cip-core/cip-pkglist/blob/master/doc/pdp.md#phase-2-proposal-review

Please reply with you opinion, agree or disagree.
If you cannot agree to add specific packages, please show the reasons as well.

Due Date: January 20th (The next TSC meeting)

We have only 2-3 working days for this review, but
I think it may be enough to agree or disagree the very simple reason above.
(We can extend this due date if more time required for reviews, please let me know if any requests)

Best regards,
Kazu
_______________________________________________
cip-dev mailing list
cip-dev at lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
https://lists.cip-project.org/mailman/listinfo/cip-dev
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20200120/881602ed/attachment.html>
