From: daniel.wagner@siemens.com (Daniel Wagner)
Date: Thu, 17 May 2018 10:53:21 +0200
Subject: [cip-dev] Backport for LTS 4.4.129 for LTP fnctl35 tests
In-Reply-To: <1526545991-13743-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
References: <1526545991-13743-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
Message-ID: <3cb5d568-1658-93b1-5d64-eec4eda4d9d4@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

On 05/17/2018 10:33 AM, Daniel Sangorrin wrote:
> Dear Ben,
> 
> The other day I mentioned on the list[1] that after running LTP with
> Fuego there were a few test cases failing that needed investigation.
> 
> I reviewed the first one (fcntl35 and fcntl35_64). According to the
> comments on the LTP fcntl35.c file (by Xiao Yang <yangx.jy@cn.fujitsu.com>)
> the bug tested by this test case was fixed by:
>     commit 086e774a57fba4695f14383c0818994c0b31da7c
>     Author: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
>     Date:   Tue Oct 11 13:53:43 2016 -0700
> 
> I backported that patch, see next e-mail:
> [PATCH] pipe: cap initial pipe capacity according to pipe-max-size
> 
> I tested again and confirmed that the patch fixed the bug.
> 
> Before:
> fcntl35.c:98: FAIL: an unprivileged user init the capacity of a pipe to 65536 unexpectedly, expected 4096
> After:
> fcntl35.c:101: PASS: an unprivileged user init the capacity of a pipe to 4096 successfully
> 
> If you think the patch is OK (as mentor) I can send it to the LTS mailing list myself.

Wouldn't it make sense to send it (also?) to Greg to include into the
stable trees?

Thanks,
Daniel
