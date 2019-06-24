From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 24 Jun 2019 08:28:15 +0200
Subject: [cip-dev] [RFC/RFT] -cip-rt kernels for review/testing
In-Reply-To: <20190623203704.GA12734@amd>
References: <20190623203704.GA12734@amd>
Message-ID: <564b1c37-083e-5b56-7e56-abc4b9ddb7bd@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 23.06.19 22:37, Pavel Machek wrote:
> Hi!
> 
> I played a bit with -rt kernels, and here are the results.
> 

Thanks for picking this up.

> v4.19.50-rt22-cip3-rebase was reasonably easy to do, as -cip1 was
> empty. v4.4.179-rt181-cip34-rebase was more interesting.
> 
> Trees are at kernel.org:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-cip.git/log/?h=v4.4.179-rt181-cip34-rebase
> https://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-cip.git/log/?h=v4.19.50-rt22-cip3-rebase
> 
> Basically untested. Could I ask for reviews and testing?
> 
> I know that full preemption does not work on x86-32. I sent
> "PREEMPT_RT_FULL on x86-32 machine" mail to the lists
> 
> I don't know how to release useful non-rebasing trees. Is someone
> using those?

Just like the regular -cip kernel, the -rt version's primary stable feed is 
merge-based. Rebasing only comes out of the fact that a second patch series is 
involved, but I doubt many folks use that feed as source. I don't, my colleagues 
neither (AFAIK).

Please sync with Daniel Wagner on the workflow options and also on 4.4-rt 
maintenance.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
