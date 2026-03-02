Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CDFEB363D
	for <webhook@archiver.kernel.org>; Mon,  2 Mar 2026 21:47:32 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3818.1772488045148469310
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Mar 2026 13:47:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ewJbfgWd;
 spf=pass (domain: gmail.com, ip: 209.85.160.177, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506251815a3so44965051cf.0
        for <cip-dev@lists.cip-project.org>; Mon, 02 Mar 2026 13:47:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772488044; cv=none;
        d=google.com; s=arc-20240605;
        b=fkLHLTtj6MWdpRDPxL0M0z/9ISfz39WDUhTvYetk4eZO0tsA/KYjKhsTKKKLdD39Zt
         bPkP/5TFqQc/1Lonc7scP1laJOMPGu/H6WWbGFcDPxmB+4vaWYz3RDwU6LGb2fDp1vTQ
         mEy3f+3qJyaNhwscZ+gvX5kfEHwv4C9OeclAO6lYBcdXS4YlyuEalWhmItrquRzTH9yl
         vxrctUAm/yVi+WRU7WoVzO9Lo7vPehjPD1okwAXdjG1lcH9DNXzZAmIjktIRneOQKvre
         xUYVQtbpsLEZ4NUQmLSdh+5Y3j7aoss/krA7GNBfzZyiL3gSfn6tcqhn3IMubcANYzIz
         GB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4VYK7NzY99DVvm6TcQ9UyPpr9XJt10ej49YUogSXiNM=;
        fh=M9NO3O3xWt6MJThE4WSXt04/m0HiPneRE6OZg6BQzuo=;
        b=FdJmPynw1LcUxOqTPH5ZmD6jmFgeg+myaqFlcv9t6N22ycBn+Sfgzv1HLULm8drRxd
         E+LovUTIqq8Q0pZurHCGuCagfxZu2yq4sujX0MiVnIBsfQUv0vKu0vTrDTlXxp1z1qGw
         /OayKbb0icv+Vgyt9h1azpqM+Dtkqd3NeKwpsfNZdh5j5X9jpuvls0pw0cTasVM3rzex
         vzWB/ifhU94JJ226BmuyB36UH7FobWBSZxUEIIM6hKq8/7dmfVZwS1ElF2FkeUYXkfGv
         SiGDiPrNTFBWD1Bsmgk4p1ikGxoQPZRq46gryWPrElxwUSSX5choU1sZ7ymqqpqX1BF5
         GMmg==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772488044; x=1773092844; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VYK7NzY99DVvm6TcQ9UyPpr9XJt10ej49YUogSXiNM=;
        b=ewJbfgWddj8/qhVDmMSw/4CSzEAyrnM/aRJxK+/N0WHdznIV8XaQt80uj6jMtegrEA
         zZNRjwENsUgwDnof67ffWoK5RY0jscOPy4+Q8vaOsj6qpXIpJhJEX8oGSQ55iMdVKyyn
         lwEbO1kEHDK4Rm2mJ634nxJpQrD3LoU5CHTh100RwAJqRS+8IU/u5dGiGFgIJnU7j/Ey
         VvGA+YZJtGEMuVzhHJj/yDlm3BxnAR3tMMWuLIuIOFUACy0JLZ1pFnxnnpsCK9C23cLd
         PrkVfJA4TGjPAA/BJq6RCZ23eRZ927aTsOeo9lm8jYcBiofhziteoorDiU20K2wENwDM
         PPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772488044; x=1773092844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4VYK7NzY99DVvm6TcQ9UyPpr9XJt10ej49YUogSXiNM=;
        b=AvTSPML5MZAUhNdkqm8YjQT0/ovELPFZLsoC6/QMzbMe2RerY0v9+Tt0viJBB8Pvx6
         lRnnGhbIX9jL39TVLSWF6mcYPvN9QL6L5YPK6IveEph+E9uCICDGO3smGlx8S/QTLSHF
         D98Qed7slgLI1IGSaYciLP1IOx8Nxtmu5OF5+RrGueyLc97N/5V1WY2t+GKeWQDa+s8/
         MPVqhrVQxawb4PBimgsE1SwxH6kcesi+N+okGjwwEIVM3loNg2AcSRhhIB718gI6+QDT
         i/R1lQFen1Ozr4ZRZZgN0imjbEjyz08KzdjzplkaC3gMFfC/XRyR8NjD+MYtqjc5xunS
         mVOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5dEqlGcBXkC+g5ynv6Lu6o2bhtZpYgvgVZtPBA1kIFOfNHJIl5V0Wfbwf1Ywc9vFiojnqGYB8@lists.cip-project.org
X-Gm-Message-State: AOJu0YwTPbLBMnhaZRiLU4fjEQriE8RQwdVOOhm1XQk9nYDutPgIWWbK
	+rwR7zf6fkFnC5QlsK04LF3SVkIwqFyD2Kclry7u+toMZJVl8MVZ2bkLq9pGi7BB/EyU0xdWKE8
	t+uJod0H5TbeLwAjJZMuQ/0EpcIQliG8=
X-Gm-Gg: ATEYQzxzBtGnUgvRTRxKGRyc7Ut6oKvZsGsXg0wOL1mXo1Mu5sJgaETmrmbmiI+0Jyt
	dHQ9HvhAFdhXfhoPcsdP9SOcejhfbIxMqHhwue8e8P+4xhmZxDpjoJ8/j7b005QFSdwKHokKwXJ
	80iJuFddeOlbiLZCSePo01KEU1rYzgLVSkKd7RTlCI+NZq61+P2wzoJndIqehuu/39DJJm7jhfJ
	dU1S0+a7fLGpr571NFQassMdfuzBt6a9t3onrWc9pqNHVSPeGmtBhldKKxEIhlhZSe2k8fLrHIh
	XEU=
X-Received: by 2002:a05:622a:1891:b0:502:9abb:c919 with SMTP id
 d75a77b69052e-5075287910dmr178871371cf.10.1772488043898; Mon, 02 Mar 2026
 13:47:23 -0800 (PST)
MIME-Version: 1.0
References: <177241674295.4931.1639151501403818844@d14e337afe00>
In-Reply-To: <177241674295.4931.1639151501403818844@d14e337afe00>
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Tue, 3 Mar 2026 06:47:12 +0900
X-Gm-Features: AaiRm50DYvHsTAKqIbBd3kt17UCAXWaXbxN7zSNnsnVbqJQVv1UzJ5U53mNKriU
Message-ID: <CACe6DC4EcZ1hunb1ce56gR-mUbPvF=raUneJdPAisWM33MAyVw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtjaXAtZGV2XSBbUkVHUkVTU0lPTl0gY2lwL2xpbnV4LTUuMTAueS1jaXA6IChidQ==?=
	=?UTF-8?B?aWxkKSAuL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vcGd0YWJsZS5oOjQ3OjU4OiBlcnJvcjog4oCYcGh5?=
	=?UTF-8?B?c19yYW1fYmFzZeKAmSB1Li4u?=
To: bot@kernelci.org
Cc: kernelci-results@groups.io, gus@collabora.com, 
	cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Mar 2026 21:47:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22038

Hi all,

This is caused by the following commit in LTS with CONFIG_SPARSEMEM_MANUAL=
=3Dy.
  8af1c121b0102 riscv: Sparse-Memory/vmemmap out-of-bounds fix

phys_ram_base does not exist, getting in a build error. This commit
must be reverted.

Best regards,
  Nobuhiro

2026=E5=B9=B43=E6=9C=882=E6=97=A5(=E6=9C=88) 12:02 KernelCI bot via lists.c=
ip-project.org
<bot=3Dkernelci.org@lists.cip-project.org>:
>
>
>
>
>
> Hello,
>
> New build issue found on cip/linux-5.10.y-cip:
>
> ---
>  ./arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99 undeclared (first use in this function) in arch/riscv/kernel/soc.=
o (arch/riscv/kernel/soc.c) [logspec:kbuild,kbuild.compiler.error]
> ---
>
> - dashboard: https://d.kernelci.org/i/maestro:a44f11709a2b24065c2a8319015=
3e7064da24401
> - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
> - commit HEAD:  de96b8c0e298067b4bbffa294baeed909a588408
>
>
> Please include the KernelCI tag when submitting a fix:
>
> Reported-by: kernelci.org bot <bot@kernelci.org>
>
>
> Log excerpt:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>                  from arch/riscv/kernel/soc.c:7:
> ./arch/riscv/include/asm/pgtable-64.h: In function =E2=80=98pud_page=E2=
=80=99:
> ./arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99 undeclared (first use in this function)
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>    70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h:47:58: note: each undeclared identifie=
r is reported only once for each function it appears in
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>    70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
>   AS      arch/riscv/kernel/vdso/flush_icache.o
> ./arch/riscv/include/asm/pgtable.h: In function =E2=80=98pmd_page=E2=80=
=99:
> ./arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99 undeclared (first use in this function)
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h:181:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>   181 |         return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> In file included from ./include/linux/pgtable.h:6,
>                  from ./include/linux/mm.h:33,
>                  from ./include/linux/kallsyms.h:12,
>                  from ./include/linux/ftrace.h:11,
>                  from ./include/linux/init_task.h:9,
>                  from init/init_task.c:2:
> ./arch/riscv/include/asm/pgtable-64.h: In function =E2=80=98pud_page=E2=
=80=99:
> ./arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99 undeclared (first use in this function)
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>    70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h:47:58: note: each undeclared identifie=
r is reported only once for each function it appears in
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>    70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
>   AS      arch/riscv/kernel/vdso/note.o
> ./arch/riscv/include/asm/pgtable.h: In function =E2=80=98pmd_page=E2=80=
=99:
> ./arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99 undeclared (first use in this function)
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h:181:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>   181 |         return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> In file included from ./arch/riscv/include/asm/uaccess.h:11,
>                  from ./include/linux/uaccess.h:11,
>                  from ./include/linux/sched/task.h:11,
>                  from ./include/linux/sched/signal.h:9,
>                  from ./include/linux/rcuwait.h:6,
>                  from ./include/linux/percpu-rwsem.h:7,
>                  from ./include/linux/fs.h:33,
>                  from init/do_mounts_initrd.c:4:
> ./arch/riscv/include/asm/pgtable-64.h: In function =E2=80=98pud_page=E2=
=80=99:
> ./arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99 undeclared (first use in this function)
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>    70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h:47:58: note: each undeclared identifie=
r is reported only once for each function it appears in
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>    70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> In file included from ./include/linux/pgtable.h:6,
>                  from ./include/linux/mm.h:33,
>                  from arch/riscv/mm/init.c:8:
> ./arch/riscv/include/asm/pgtable-64.h: In function =E2=80=98pud_page=E2=
=80=99:
> ./arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99 undeclared (first use in this function)
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>    70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h:47:58: note: each undeclared identifie=
r is reported only once for each function it appears in
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>    70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h: In function =E2=80=98pmd_page=E2=80=
=99:
> ./arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99 undeclared (first use in this function)
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h:181:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>   181 |         return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
>   VDSOLD  arch/riscv/kernel/vdso/vdso.so.dbg
> ./arch/riscv/include/asm/pgtable.h: In function =E2=80=98pmd_page=E2=80=
=99:
> ./arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99 undeclared (first use in this function)
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h:181:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>   181 |         return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> In file included from ./arch/riscv/include/asm/uaccess.h:11,
>                  from ./include/linux/uaccess.h:11,
>                  from ./include/linux/sched/task.h:11,
>                  from ./include/linux/sched/signal.h:9,
>                  from ./include/linux/rcuwait.h:6,
>                  from ./include/linux/percpu-rwsem.h:7,
>                  from ./include/linux/fs.h:33,
>                  from init/initramfs.c:3:
> ./arch/riscv/include/asm/pgtable-64.h: In function =E2=80=98pud_page=E2=
=80=99:
> In file included from ./arch/riscv/include/asm/uaccess.h:11,
>                  from ./include/linux/uaccess.h:11,
>                  from ./include/linux/sched/task.h:11,
>                  from ./include/linux/sched/signal.h:9,
>                  from ./include/linux/sched/cputime.h:5,
>                  from kernel/sched/sched.h:11,
>                  from kernel/sched/clock.c:56:
> ./arch/riscv/include/asm/pgtable-64.h: In function =E2=80=98pud_page=E2=
=80=99:
> ./arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99 undeclared (first use in this function)
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>    70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99 undeclared (first use in this function)
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>    70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h:47:58: note: each undeclared identifie=
r is reported only once for each function it appears in
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>    70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h:47:58: note: each undeclared identifie=
r is reported only once for each function it appears in
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>    70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> In file included from ./arch/riscv/include/asm/uaccess.h:11,
>                  from ./include/linux/uaccess.h:11,
>                  from ./include/linux/sched/task.h:11,
>                  from ./include/linux/sched/signal.h:9,
>                  from ./include/linux/sched/cputime.h:5,
>                  from kernel/sched/sched.h:11,
>                  from kernel/sched/loadavg.c:9:
> ./arch/riscv/include/asm/pgtable-64.h: In function =E2=80=98pud_page=E2=
=80=99:
> ./arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99 undeclared (first use in this function)
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>    70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h:47:58: note: each undeclared identifie=
r is reported only once for each function it appears in
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>    70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h: In function =E2=80=98pmd_page=E2=80=
=99:
> ./arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99 undeclared (first use in this function)
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h:181:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>   181 |         return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h: In function =E2=80=98pmd_page=E2=80=
=99:
>   OBJCOPY arch/riscv/kernel/vdso/vdso.so
> ./arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99 undeclared (first use in this function)
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h:181:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>   181 |         return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> In file included from ./arch/riscv/include/asm/uaccess.h:11,
>                  from ./include/linux/uaccess.h:11,
>                  from ./include/linux/sched/task.h:11,
>                  from ./include/linux/sched/signal.h:9,
>                  from ./include/linux/rcuwait.h:6,
>                  from ./include/linux/percpu-rwsem.h:7,
>                  from ./include/linux/fs.h:33,
>                  from ./include/linux/seq_file.h:11,
>                  from arch/riscv/kernel/cpu.c:7:
> ./arch/riscv/include/asm/pgtable-64.h: In function =E2=80=98pud_page=E2=
=80=99:
> ./arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99 undeclared (first use in this function)
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>    70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h:47:58: note: each undeclared identifie=
r is reported only once for each function it appears in
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>    70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> In file included from ./arch/riscv/include/asm/uaccess.h:11,
>                  from ./include/linux/uaccess.h:11,
>                  from ./include/linux/sched/task.h:11,
>                  from ./include/linux/sched/signal.h:9,
>                  from kernel/locking/mutex.c:23:
> ./arch/riscv/include/asm/pgtable-64.h: In function =E2=80=98pud_page=E2=
=80=99:
> ./arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99 undeclared (first use in this function)
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>    70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h:47:58: note: each undeclared identifie=
r is reported only once for each function it appears in
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>    70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h: In function =E2=80=98pmd_page=E2=80=
=99:
>   AS      arch/riscv/kernel/vdso/vdso.o
> ./arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99 undeclared (first use in this function)
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h:181:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>   181 |         return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h: In function =E2=80=98pmd_page=E2=80=
=99:
> ./arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99 undeclared (first use in this function)
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h:181:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>   181 |         return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h: In function =E2=80=98pmd_page=E2=80=
=99:
> ./arch/riscv/include/asm/pgtable.h:47:58: error: =E2=80=98phys_ram_base=
=E2=80=99 undeclared (first use in this function)
>    47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
>       |                                                          ^~~~~~~~=
~~~~~
> ./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =
=E2=80=98vmemmap=E2=80=99
>    54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>       |                                  ^~~~~~~
> ./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =
=E2=80=98__pfn_to_page=E2=80=99
>    82 | #define pfn_to_page __pfn_to_page
>       |                     ^~~~~~~~~~~~~
> ./arch/riscv/include/asm/pgtable.h:181:16: note: in expansion of macro =
=E2=80=98pfn_to_page=E2=80=99
>   181 |         return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
>       |                ^~~~~~~~~~~
>   SO2S    arch/riscv/kernel/vdso/vdso-syms.S
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>
> # Builds where the incident occurred:
>
> ## defconfig+kselftest+lab-setup+cip://5.10.y-cip/riscv/cip_merged_defcon=
fig on (riscv):
> - compiler: gcc-14
> - config: https://files.kernelci.org/kbuild-gcc-14-riscv-510-cip-69a4e24e=
7136242fe390371e/.config
> - dashboard: https://d.kernelci.org/build/maestro:69a4e24e7136242fe390371=
e
>
>
> #kernelci issue maestro:a44f11709a2b24065c2a83190153e7064da24401
>
> --
> This is an experimental report format. Please send feedback in!
> Talk to us at kernelci@lists.linux.dev
>
> Made with love by the KernelCI team - https://kernelci.org
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#22033): https://lists.cip-project.org/g/cip-dev/messa=
ge/22033
> Mute This Topic: https://lists.cip-project.org/mt/118088284/4520494
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [iwamatsu@gmai=
l.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--=20
Nobuhiro Iwamatsu

