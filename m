From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Mon, 2 Apr 2018 07:04:50 +0200
Subject: [cip-dev] Kernel feature support
In-Reply-To: <FAF29B5BFF9BF5439C88554EE7A20506F86B25E4@MHQMBX02.moxa.com>
References: <FAF29B5BFF9BF5439C88554EE7A20506F86B25E4@MHQMBX02.moxa.com>
Message-ID: <CAEss1EL1DAZGCuQCXMNATMuQyRuTUbBiYctwUt8crDUZ46x7pQ@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Wes,

> CONFIG_ARCH_NR_GPIO=0
> CONFIG_HAVE_PREEMPT_LAZY=y
*> CONFIG_PREEMPT_NONE=y*
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT__LL is not set
> # CONFIG_PREEMPT_RTB is not set
*> # CONFIG_PREEMPT_RT_FULL is not set*
> CONFIG_HZ_FIXED=0

You should refine your rt criterion. IMHO.

Zoran
_______

On Sat, Mar 31, 2018 at 9:56 AM, Wes Huang (???) <Wes.Huang@moxa.com> wrote:

> Hi,
>
>
>
> Sorry for the late reply.
>
>
>
> Please find attached a Moxa kernel configuration using CIP kernel 4.4.
>
>
>
> *Best regards, *
>
>
>
> *Wes Huang*
>
> Software R&D
>
> *Moxa Systems*
>
> *Tel : 886-2-8919-1230 Ext.7718*
>
> *Fax: 886-2-8919-1231*
>
> Wes.Huang at moxa.com
>
> [image: Moxa_Logo]
> This email and any attached files may contain confidential and/or
> privileged information. If you are not the intended recipient (or have
> received this e-mail in error) please notify the sender immediately and
> destroy this email. Any unauthorized duplication, utilization, disclosure,
> or distribution of the material in this email and its attached files is
> strictly forbidden.
>
>
>
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180402/2ae8739e/attachment.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: image001.gif
Type: image/gif
Size: 2354 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180402/2ae8739e/attachment.gif>
