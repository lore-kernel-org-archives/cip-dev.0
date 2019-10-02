From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 2 Oct 2019 10:29:45 +0200
Subject: [cip-dev] Testing results for 4.19-cip-rt
In-Reply-To: <20191002082238.GA9041@amd>
References: <20191002082238.GA9041@amd>
Message-ID: <43099417-d106-47cc-e784-4a5f25c4aa31@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 02.10.19 10:22, Pavel Machek wrote:
> Hi!
> 
> I pushed -cip-rt version to kernel.org, which got me automatic test on
> gitlab:
> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/309275693
> 
> ...compile okay, but run_tests failed; unfortunately I don't quite
> understand what went wrong with the test. Can someone help?
> 

Job #4665: Finished
   Device Type: r8a774a1-hihope-rzg2m-ex
   Device: r8a774a1-hihope-rzg2m-ex-01
   Test: healthcheck

Chris can probably explain.

I see only the Renesas lab used here, right? Are we missing something for the 
IPC227E and de0-nano-soc to be used as well?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
