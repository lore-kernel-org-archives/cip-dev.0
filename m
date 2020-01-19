From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Sun, 19 Jan 2020 09:25:28 +0100
Subject: [cip-dev] [cip-core] Package Proposal #2 (Minimum base packages
 in Debian)
In-Reply-To: <TYXPR01MB1808E5730818EAB90EB9558FE1360@TYXPR01MB1808.jpnprd01.prod.outlook.com>
References: <TYXPR01MB1808E5730818EAB90EB9558FE1360@TYXPR01MB1808.jpnprd01.prod.outlook.com>
Message-ID: <d4661811-8581-aec6-b5f1-160a447671b1@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 16.01.20 09:25, kazuhiro3.hayashi at toshiba.co.jp wrote:
> Hello CIP Core members,
> 
> I created a simple package proposal for the packages that are installed in the "minimum base system" of Debian.
> These packages are installed by
> 	$ debootstrap --variant=minbase buster ...
> 
> It consists of 58 source packages and 84 binary packages, including all run-time dependencies.
> 
> The common reason to propose:
> "This package is included in the minimum base system of Debian (debootstrap --variant=minbase),
> which is essential for all Debian binary package based systems"
> 
> 
> I would like to start the "review" phase (Phase 2) of the attached package proposal.
> https://gitlab.com/cip-project/cip-core/cip-pkglist/blob/master/doc/pdp.md#phase-2-proposal-review
> 
> Please reply with you opinion, agree or disagree.

Looks good to us: agree.

Jan

> If you cannot agree to add specific packages, please show the reasons as well.
> 
> Due Date: January 20th (The next TSC meeting)
> 
> We have only 2-3 working days for this review, but
> I think it may be enough to agree or disagree the very simple reason above.
> (We can extend this due date if more time required for reviews, please let me know if any requests)
> 
> Best regards,
> Kazu
> 
> 
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
