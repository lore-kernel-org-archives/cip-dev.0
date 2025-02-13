Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2A3C021A0
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 01:37:36 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
 by mx.groups.io with SMTP id smtpd.web11.9540.1739448323001307163
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Feb 2025 04:05:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=jjtgqviX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.128.174, mailfrom: bot@kernelci.org)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f88509dad2so7383647b3.3
        for <cip-dev@lists.cip-project.org>; Thu, 13 Feb 2025 04:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1739448321; x=1740053121; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bb8/uDP0Ninx/DbJWmMovKdQ0MKRXO7Kj8wB+mkNYtE=;
        b=jjtgqviX4EAxSB6C4hwrlI59swO+vPgWKqucrIZi2TvrXPEOzEB7u3M6iw40xy89wZ
         n1N/wFt9bdbOC+Kmbr7a+1hLNq7fgw0Wa/6Gu974Lpz450g1xEYbHGo+djw2jtp3h06N
         vTJaBnsHLG6jnuNsb3gLgbC2gmn9G5Ep4J5sMs04b5DlzbOkiWCEBLighCSWoXSoVekI
         tFT86MRTDfyAqq7jGfmMP+H+3S+yTtBgM9WsiOkcG8pFQkc5c6H4ezQu2I0O55W4KbQO
         OFzE+mFE3BhYGcA57nsn3N2sICGQJjQMoIPaLVTH1gk2yHEbBSI2WSZlv45J9p2JuWkZ
         sPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739448321; x=1740053121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bb8/uDP0Ninx/DbJWmMovKdQ0MKRXO7Kj8wB+mkNYtE=;
        b=Jv1NtWFxfP+kBeWeiLA9q8qlYpyZ7zVNgGOuOmgkfkq3oaGF62Atuw1dp5e0W9gxpt
         K0Xv34y0ZcEAlWc3YMl4Z5gclJsTtfoeOEcS2qV28JcwZ1AlIquBnE1KSb50UVKMkpQm
         RAx5Y6Q0RUBDWPwgcFVhcFjHf728jyFDmLECfIVow4Ml+SAQoNNb6VGqIOHKelr642ta
         j48ULponxJHpE35EZeiXrGGXeKwNxVUod9ThwvjlTcFYvymmsq2zG9uEvHMNIEgOm5Gh
         CZ/C36PlVIcu6/FU/zqVudDcx0kmUpilTmcTPQ1RGmosTDlpINHMVH5Wx1bC6uNIWX7P
         hxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBb7hgGGPAgYbPaYcRBiIAaGsKYarfsDg9r12MP9PKw3LkVsqd1Q4/LFZVTMyHi8wxVxP3zhga@lists.cip-project.org
X-Gm-Message-State: AOJu0YyLqv6hK74FoOsalVNFgVzQzc5dYlc2gsiSaDzHarZyCDlaK3on
	h9P6Lqsnv5cDwPv/+1FRPwKNEOeTjBk1DAefAbEFqrSCHrD553yDAv6/4MVdfXVlkV1tf7Ux3eP
	6v/O88MlAA2JDn5xxMvyqZqnlwhes/FS/RLHDcg==
X-Gm-Gg: ASbGncvSzo250iLrl7qAmXLqAq5RATwLrVAgDwUvEo1oBF6d6LB3+dyGbc4TI6yf14M
	xoR+bXeMl85f6dOnoawzjygLWddEwXREN0MgGsPZ6Ux6Veu1ceto11g+YRyrhm8XmVz67uPmvAg
	IBfNRdRli2GWq12dPO205cdXxuuX4n3g==
X-Google-Smtp-Source: AGHT+IG+WYIu8hMGs0XfS3pBi5fRfTXin0efSFAjvJqTStUC9A06yvtABSekpd1x4wpQlinftVXsJkC8ZxAGNkRyxVU=
X-Received: by 2002:a05:690c:6b89:b0:6f9:8916:3b66 with SMTP id
 00721157ae682-6fb1f5a6fffmr72450687b3.12.1739448318921; Thu, 13 Feb 2025
 04:05:18 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Feb 2025 04:05:17 -0800
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Feb 2025 04:05:17 -0800
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Date: Thu, 13 Feb 2025 04:05:17 -0800
X-Gm-Features: AWEUYZndTPTlE9q5y1RMTtq_bhr0VVoFnS6z3MAK4x-6egHLyO-zBtZO0JBrjjk
Message-ID: <CACo-S-1bZE7m=M8v_qfw3aHMqh-DXj84WGbdsSzh-uExXsYUGQ@mail.gmail.com>
Subject: [REGRESSION] cip/linux-4.4.y-cip: (build) in warning: arch/x86/crypto/aes-i586-asm_32 (ld) [logspec:kbuild,k...
To: kernelci-results@groups.io
Cc: gus@collabora.com, cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Feb 2025 01:37:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17834

Hello,

New build issue found on cip/linux-4.4.y-cip:

---
 in warning: arch/x86/crypto/aes-i586-asm_32 (ld)
[logspec:kbuild,kbuild.compiler.linker_error]
---

- dashboard: https://d.kernelci.org/issue/maestro:0b409eddedc3bdcf5c60bb604=
bad1e27aa4fbe86
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
- commit HEAD:  8ad5b181aef5c015360b738860b42f15d23ea8fe


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
ld: warning: arch/x86/crypto/aes-i586-asm_32.o: missing
.note.GNU-stack section implies executable stack
ld: NOTE: This behaviour is deprecated and will be removed in a future
version of the linker
  CC      kernel/fork.o
  CC      arch/x86/entry/common.o
  LD      arch/x86/crypto/built-in.o
ld: warning: arch/x86/crypto/aes-i586.o: requires executable stack
(because the .note.GNU-stack section is executable)
  CC      arch/x86/kernel/process_32.o
  CC      kernel/exec_domain.o
  CC      init/calibrate.o
  CC      init/init_task.o
  CC      init/version.o
  CC      kernel/panic.o
  CC      kernel/cpu.o
  LD      init/mounts.o
  CC      kernel/exit.o
  CC      arch/x86/kernel/signal.o
  CC      arch/x86/kernel/traps.o
  LD      init/built-in.o
  LD      certs/built-in.o
  CC      mm/filemap.o
  CC      arch/x86/entry/vdso/vma.o
  CC      mm/mempool.o
kernel/cpu.c: In function =E2=80=98notify_cpu_starting=E2=80=99:
kernel/cpu.c:740:25: warning: the comparison will always evaluate as
=E2=80=98true=E2=80=99 for the address of =E2=80=98frozen_cpus=E2=80=99 wil=
l never be NULL [-Waddress]
  740 |         if (frozen_cpus !=3D NULL && cpumask_test_cpu(cpu, frozen_c=
pus))
      |                         ^~
kernel/cpu.c:585:22: note: =E2=80=98frozen_cpus=E2=80=99 declared here
  585 | static cpumask_var_t frozen_cpus;
      |                      ^~~~~~~~~~~
  CC      arch/x86/entry/vdso/vdso32-setup.o
  CC      arch/x86/kernel/irq.o
  CC      arch/x86/kernel/irq_32.o
  CC      kernel/softirq.o
  LDS     arch/x86/entry/vdso/vdso32/vdso32.lds
  CC      arch/x86/entry/vdso/vdso32/vclock_gettime.o
  CC      mm/oom_kill.o
  AS      arch/x86/entry/vdso/vdso32/note.o
  AS      arch/x86/entry/vdso/vdso32/system_call.o
  HOSTCC  arch/x86/entry/vdso/vdso2c
  CC      arch/x86/kernel/dumpstack_32.o
  CC      kernel/resource.o
  VDSO    arch/x86/entry/vdso/vdso32.so.dbg
ld: warning: arch/x86/entry/vdso/vdso32/system_call.o: missing
.note.GNU-stack section implies executable stack
ld: NOTE: This behaviour is deprecated and will be removed in a future
version of the linker
  OBJCOPY arch/x86/entry/vdso/vdso32.so
  VDSO2C  arch/x86/entry/vdso/vdso-image-32.c
  CC      arch/x86/entry/vdso/vdso-image-32.o
  CC      arch/x86/kernel/time.o
  CC      arch/x86/kernel/ioport.o
  CC      kernel/sysctl.o
  LD      arch/x86/entry/vdso/built-in.o
  CC      arch/x86/entry/vsyscall/vsyscall_gtod.o
  CC      kernel/sysctl_binary.o
  CC      arch/x86/kernel/dumpstack.o
  CC      arch/x86/kernel/nmi.o
  LD      arch/x86/entry/vsyscall/built-in.o
  LD      arch/x86/entry/built-in.o
ld: warning: arch/x86/entry/thunk_32.o: missing .note.GNU-stack
section implies executable stack
ld: NOTE: This behaviour is deprecated and will be removed in a future
version of the linker
WARNING: arch/x86/entry/built-in.o (.discard.nospec): unexpected
non-allocatable section.
Did you forget to use "ax"/"aw" in a .S file?
Note that for example <linux/init.h> contains
section definitions for use in .S files.

WARNING: arch/x86/entry/built-in.o (.discard.retpoline_safe):
unexpected non-allocatable section.
Did you forget to use "ax"/"aw" in a .S file?
Note that for example <linux/init.h> contains
section definitions for use in .S files.

  CC      arch/x86/mm/init.o
  CC      mm/maccess.o
  CC      arch/x86/kernel/ldt.o
  CC      kernel/capability.o
  CC      arch/x86/kernel/setup.o
  CC      kernel/ptrace.o
  CC      mm/page_alloc.o
  CC      mm/page-writeback.o
  CC      fs/open.o
  CC      arch/x86/mm/init_32.o
  CC      arch/x86/mm/fault.o
  CC      kernel/user.o
  CC      arch/x86/kernel/x86_init.o
  CC      arch/x86/kernel/i8259.o
  CC      kernel/signal.o
  CC      arch/x86/mm/ioremap.o
  CC      arch/x86/kernel/irqinit.o
  CC      fs/read_write.o
  CC      arch/x86/mm/extable.o
  CC      arch/x86/mm/pageattr.o
  CC      arch/x86/mm/mmap.o
  CC      arch/x86/kernel/jump_label.o
  CC      arch/x86/mm/pat.o
  CC      arch/x86/mm/pgtable.o
  CC      arch/x86/kernel/irq_work.o
  CC      mm/readahead.o
  CC      arch/x86/mm/physaddr.o
  CC      arch/x86/kernel/probe_roms.o
  CC      arch/x86/mm/gup.o
  CC      arch/x86/mm/setup_nx.o
  CC      fs/file_table.o
  CC      arch/x86/mm/tlb.o
  CC      mm/swap.o
  CC      arch/x86/mm/pat_rbtree.o
  CC      arch/x86/kernel/i386_ksyms_32.o
  CC      arch/x86/kernel/ksysfs.o
  CC      arch/x86/mm/pgtable_32.o
  CC      fs/super.o
  CC      arch/x86/mm/iomap_32.o
  CC      arch/x86/mm/hugetlbpage.o
  CC      mm/truncate.o
  CC      arch/x86/kernel/bootflag.o
  CC      arch/x86/mm/highmem_32.o
  CC      kernel/sys.o
  CC      arch/x86/kernel/e820.o
  CC      mm/vmscan.o
  CC      fs/char_dev.o
  CC      fs/stat.o
  LD      arch/x86/mm/built-in.o
  LD      arch/x86/net/built-in.o
  CC      arch/x86/platform/atom/pmc_atom.o
  LD      arch/x86/platform/ce4100/built-in.o
  CC      arch/x86/platform/efi/quirks.o
  CC      fs/exec.o
  LD      arch/x86/platform/atom/built-in.o
  CC      arch/x86/platform/efi/efi.o
  CC      fs/pipe.o
  CC      arch/x86/kernel/pci-dma.o
  CC      arch/x86/platform/efi/efi_32.o
  AS      arch/x86/platform/efi/efi_stub_32.o
  CC      fs/namei.o
  CC      arch/x86/kernel/quirks.o
  CC      arch/x86/kernel/topology.o
  LD      arch/x86/platform/efi/built-in.o
ld: warning: arch/x86/platform/efi/efi_stub_32.o: missing
.note.GNU-stack section implies executable stack
ld: NOTE: This behaviour is deprecated and will be removed in a future
version of the linker
  LD      arch/x86/platform/geode/built-in.o
  LD      arch/x86/platform/goldfish/built-in.o
  CC      arch/x86/platform/intel/iosf_mbi.o
  CC      kernel/kmod.o
  CC      arch/x86/kernel/kdebugfs.o
  CC      fs/fcntl.o
  CC      arch/x86/kernel/alternative.o
  LD      arch/x86/platform/intel/built-in.o
  LD      arch/x86/platform/intel-mid/built-in.o
  LD      arch/x86/platform/intel-quark/built-in.o
  LD      arch/x86/platform/iris/built-in.o
  LD      arch/x86/platform/olpc/built-in.o
  LD      arch/x86/platform/scx200/built-in.o
  LD      arch/x86/platform/sfi/built-in.o
  LD      arch/x86/platform/ts5500/built-in.o
  CC      arch/x86/kernel/i8253.o
  LD      arch/x86/platform/uv/built-in.o
  LD      arch/x86/platform/built-in.o
  CC      fs/ioctl.o
ld: warning: arch/x86/platform/efi/built-in.o: requires executable
stack (because the .note.GNU-stack section is executable)
  CC      arch/x86/realmode/init.o
  CC      kernel/workqueue.o
  AS      arch/x86/realmode/rm/header.o
  CC      arch/x86/kernel/pci-nommu.o
  CC      arch/x86/kernel/hw_breakpoint.o
  CC      fs/readdir.o
  AS      arch/x86/realmode/rm/trampoline_32.o
  AS      arch/x86/realmode/rm/stack.o
  AS      arch/x86/realmode/rm/reboot.o
  CC      fs/select.o
  CC      arch/x86/kernel/tsc.o
  CC      mm/shmem.o
  CC      fs/dcache.o
  CC      arch/x86/kernel/tsc_msr.o
  AS      arch/x86/realmode/rm/wakeup_asm.o
  CC      arch/x86/kernel/io_delay.o
  CC      arch/x86/realmode/rm/wakemain.o
  CC      arch/x86/realmode/rm/video-mode.o
  CC      arch/x86/kernel/rtc.o
  AS      arch/x86/realmode/rm/copy.o
  CC      arch/x86/kernel/pci-iommu_table.o
  AS      arch/x86/realmode/rm/bioscall.o
  CC      fs/inode.o
  CC      arch/x86/kernel/resource.o
  AS      arch/x86/kernel/irqflags.o
  CC      arch/x86/realmode/rm/regs.o
  CC      arch/x86/realmode/rm/video-vga.o
  CC      fs/attr.o
  CC      arch/x86/kernel/process.o
  CC      fs/bad_inode.o
  CC      arch/x86/realmode/rm/video-vesa.o
  CC      fs/file.o
  CC      fs/filesystems.o
  CC      arch/x86/realmode/rm/video-bios.o
arch/x86/kernel/process.c: In function =E2=80=98amd_e400_remove_cpu=E2=80=
=99:
arch/x86/kernel/process.c:539:31: warning: the comparison will always
evaluate as =E2=80=98true=E2=80=99 for the address of =E2=80=98amd_e400_c1e=
_mask=E2=80=99 will never
be NULL [-Waddress]
  539 |         if (amd_e400_c1e_mask !=3D NULL)
      |                               ^~
arch/x86/kernel/process.c:535:22: note: =E2=80=98amd_e400_c1e_mask=E2=80=99=
 declared here
  535 | static cpumask_var_t amd_e400_c1e_mask;
      |                      ^~~~~~~~~~~~~~~~~
  PASYMS  arch/x86/realmode/rm/pasyms.h
  LDS     arch/x86/realmode/rm/realmode.lds
  LD      arch/x86/realmode/rm/realmode.elf
ld: warning: arch/x86/realmode/rm/bioscall.o: missing .note.GNU-stack
section implies executable stack
ld: NOTE: This behaviour is deprecated and will be removed in a future
version of the linker
  RELOCS  arch/x86/realmode/rm/realmode.relocs
  OBJCOPY arch/x86/realmode/rm/realmode.bin
  AS      arch/x86/realmode/rmpiggy.o
  CC      mm/util.o
  CC      fs/namespace.o
  CC      kernel/pid.o
  CC      fs/seq_file.o
  LD      arch/x86/realmode/built-in.o
ld: warning: arch/x86/realmode/rmpiggy.o: missing .note.GNU-stack
section implies executable stack
ld: NOTE: This behaviour is deprecated and will be removed in a future
version of the linker
  CC      fs/xattr.o
  CC      arch/x86/kernel/acpi/boot.o
  CC      fs/libfs.o
  CC      mm/mmzone.o
  CC      arch/x86/kernel/apic/apic.o
  CC      kernel/task_work.o
  CC      mm/vmstat.o
  CC      fs/fs-writeback.o
  CC      fs/pnode.o
  CC      arch/x86/kernel/acpi/sleep.o
  CC      kernel/extable.o
  CC      fs/splice.o
  AS      arch/x86/kernel/acpi/wakeup_32.o
  CC      kernel/params.o
  CC      fs/sync.o
  CC      arch/x86/kernel/acpi/cstate.o
  CC      mm/backing-dev.o
  LD      arch/x86/kernel/acpi/built-in.o
ld: warning: arch/x86/kernel/acpi/wakeup_32.o: missing .note.GNU-stack
section implies executable stack
ld: NOTE: This behaviour is deprecated and will be removed in a future
version of the linker
  CC      arch/x86/kernel/cpu/intel_cacheinfo.o
  CC      fs/utimes.o
  CC      arch/x86/kernel/apic/apic_noop.o
  CC      fs/stack.o
  CC      kernel/kthread.o
  CC      kernel/sys_ni.o
  CC      kernel/nsproxy.o
  CC      arch/x86/kernel/apic/ipi.o
  CC      fs/fs_struct.o
  CC      fs/statfs.o
  CC      mm/mm_init.o
  CC      arch/x86/kernel/cpu/scattered.o
  CC      fs/fs_pin.o
  CC      kernel/notifier.o
  CC      mm/mmu_context.o
  CC      arch/x86/kernel/apic/vector.o
  CC      arch/x86/kernel/cpu/topology.o
  CC      mm/percpu.o
  CC      arch/x86/kernel/fpu/init.o
  CC      arch/x86/kernel/cpu/common.o
  CC      arch/x86/kernel/cpu/rdrand.o
  CC      mm/slab_common.o
  CC      arch/x86/kernel/fpu/bugs.o
  CC      arch/x86/kernel/cpu/match.o
  CC      kernel/ksysfs.o
  CC      fs/nsfs.o
  CC      arch/x86/kernel/fpu/core.o
  CC      arch/x86/kernel/fpu/regset.o
  CC      arch/x86/kernel/apic/hw_nmi.o
  CC      fs/buffer.o
  CC      kernel/cred.o
  CC      arch/x86/kernel/apic/io_apic.o
  CC      arch/x86/kernel/fpu/signal.o
  CC      arch/x86/kernel/fpu/xstate.o
  CC      arch/x86/kernel/cpu/bugs.o
  CC      kernel/reboot.o
  CC      kernel/async.o
  CC      arch/x86/kernel/cpu/proc.o
  CC      mm/compaction.o
  LD      arch/x86/kernel/fpu/built-in.o
  CC      arch/x86/kernel/kprobes/core.o
  MKCAP   arch/x86/kernel/cpu/capflags.c
  CC      kernel/range.o
  CC      kernel/smpboot.o
  CC      kernel/groups.o
  CC      arch/x86/kernel/cpu/powerflags.o
  CC      arch/x86/kernel/cpu/intel.o
  CC      arch/x86/kernel/kprobes/opt.o
  CC      kernel/events/core.o
  CC      kernel/bpf/core.o
  LD      arch/x86/kernel/kprobes/built-in.o
  CC      arch/x86/kernel/cpu/tsx.o
  CC      arch/x86/kernel/apic/msi.o
  CC      arch/x86/kernel/ptrace.o
  CC      fs/block_dev.o
  CC      arch/x86/kernel/cpu/amd.o
  CC      mm/vmacache.o
  CC      arch/x86/kernel/apic/htirq.o
  CC      mm/interval_tree.o
  CC      mm/list_lru.o
  CC      arch/x86/kernel/cpu/centaur.o
  CC      arch/x86/kernel/apic/probe_32.o
  CC      arch/x86/kernel/cpu/transmeta.o
  CC      mm/workingset.o
  CC      fs/direct-io.o
  CC      mm/debug.o
  LD      arch/x86/kernel/apic/built-in.o
  CC      arch/x86/kernel/tls.o
  CC      arch/x86/kernel/cpu/perf_event.o
  LD      kernel/bpf/built-in.o
  CC      kernel/irq/irqdesc.o
  CC      mm/gup.o
  CC      mm/highmem.o
  CC      arch/x86/kernel/step.o
  CC      kernel/irq/handle.o
  CC      fs/mpage.o
  CC      fs/proc_namespace.o
  CC      mm/memory.o
  CC      fs/autofs4/init.o
  CC      kernel/irq/manage.o
  CC      fs/autofs4/inode.o
  CC      fs/configfs/inode.o
  CC      fs/configfs/file.o
  CC      kernel/irq/spurious.o
  CC      fs/autofs4/root.o
  CC      fs/configfs/dir.o
  CC      kernel/irq/resend.o
  CC      arch/x86/kernel/cpu/perf_event_amd.o
  CC      fs/autofs4/symlink.o
  CC      fs/configfs/symlink.o
  CC      kernel/irq/chip.o
  CC      fs/autofs4/waitq.o
  CC      fs/configfs/mount.o
  CC      arch/x86/kernel/cpu/perf_event_amd_uncore.o
  CC      fs/autofs4/expire.o
  CC      mm/mincore.o
  CC      fs/configfs/item.o
  CC      fs/autofs4/dev-ioctl.o
  CC      kernel/events/ring_buffer.o
  CC      kernel/irq/dummychip.o
  CC      kernel/irq/devres.o
  CC      kernel/irq/autoprobe.o
  LD      fs/configfs/configfs.o
  LD      fs/configfs/built-in.o
  CC      fs/debugfs/inode.o
  CC      arch/x86/kernel/cpu/perf_event_p6.o
  CC      kernel/irq/irqdomain.o
  CC      kernel/irq/proc.o
  CC      mm/mlock.o
  CC      kernel/irq/migration.o
  LD      fs/autofs4/autofs4.o
  LD      fs/autofs4/built-in.o
  CC      fs/devpts/inode.o
  CC      arch/x86/kernel/cpu/perf_event_knc.o
  CC      kernel/events/callchain.o
  CC      kernel/irq/pm.o
  CC      kernel/irq/msi.o
  CC      fs/debugfs/file.o
  CC      kernel/events/hw_breakpoint.o
  CC      arch/x86/kernel/cpu/perf_event_p4.o
  LD      fs/devpts/devpts.o
  CC      mm/mmap.o
  LD      fs/efivarfs/built-in.o
  LD      fs/devpts/built-in.o
  LD      fs/exofs/built-in.o
  CC      fs/exportfs/expfs.o
  CC      fs/ext4/balloc.o
  CC      fs/fat/cache.o
  LD      kernel/irq/built-in.o
  CC      fs/fat/dir.o
  LD      fs/debugfs/debugfs.o
  LD      fs/debugfs/built-in.o
  CC      fs/hugetlbfs/inode.o
  LD      fs/exportfs/exportfs.o
  LD      fs/exportfs/built-in.o
  CC      fs/isofs/namei.o
  LD      kernel/events/built-in.o
  LD      kernel/livepatch/built-in.o
  CC      fs/isofs/inode.o
  CC      kernel/locking/mutex.o
  CC      arch/x86/kernel/cpu/perf_event_intel_lbr.o
  CC      kernel/locking/semaphore.o
  CC      arch/x86/kernel/cpu/perf_event_intel_ds.o
  CC      kernel/locking/rwsem.o
  LD      fs/hugetlbfs/hugetlbfs.o
  LD      fs/hugetlbfs/built-in.o
  CC      fs/jbd2/transaction.o
  CC      kernel/locking/percpu-rwsem.o
  CC      fs/fat/fatent.o
  CC      fs/isofs/dir.o
  CC      fs/ext4/bitmap.o
  CC      fs/isofs/util.o
  CC      kernel/locking/mutex-debug.o
  CC      fs/isofs/rock.o
  CC      kernel/locking/lockdep.o
  CC      fs/isofs/export.o
  CC      fs/ext4/dir.o
  CC      mm/mprotect.o
  CC      arch/x86/kernel/cpu/perf_event_intel.o
  CC      fs/fat/file.o
  CC      fs/isofs/joliet.o
  CC      fs/isofs/compress.o
  CC      mm/mremap.o
  CC      mm/msync.o
  CC      fs/jbd2/commit.o
  CC      fs/ext4/file.o
  CC      fs/fat/inode.o
  CC      fs/fat/misc.o
  LD      fs/isofs/isofs.o
  LD      fs/isofs/built-in.o
  CC      kernel/power/qos.o
  CC      mm/rmap.o
  CC      arch/x86/kernel/cpu/perf_event_intel_rapl.o
  CC      fs/ext4/fsync.o
  CC      kernel/power/main.o
  CC      kernel/locking/lockdep_proc.o
  CC      fs/jbd2/recovery.o
  CC      kernel/power/console.o
  CC      kernel/power/process.o
  CC      arch/x86/kernel/cpu/perf_event_intel_cqm.o
  CC      fs/fat/nfs.o
  CC      kernel/locking/spinlock.o
  CC      mm/vmalloc.o
  CC      kernel/power/suspend.o
  CC      kernel/locking/osq_lock.o
  CC      fs/ext4/ialloc.o
  CC      fs/fat/namei_vfat.o
  CC      kernel/power/hibernate.o
  CC      fs/jbd2/checkpoint.o
  CC      kernel/locking/lglock.o
  CC      arch/x86/kernel/cpu/perf_event_intel_pt.o
  CC      kernel/power/snapshot.o
  CC      kernel/locking/rtmutex.o
  CC      fs/fat/namei_msdos.o
  CC      kernel/power/swap.o
  CC      fs/jbd2/revoke.o
  CC      arch/x86/kernel/cpu/perf_event_intel_bts.o
  CC      mm/pagewalk.o
  CC      kernel/locking/rtmutex-debug.o
  CC      mm/pgtable-generic.o
  LD      fs/fat/fat.o
  CC      fs/jbd2/journal.o
  LD      fs/fat/vfat.o
  LD      fs/fat/msdos.o
  LD      fs/fat/built-in.o
  CC      fs/kernfs/mount.o
  CC      arch/x86/kernel/cpu/perf_event_intel_cstate.o
  CC      kernel/locking/spinlock_debug.o
  CC      fs/kernfs/inode.o
  CC      fs/ext4/inode.o
  CC      mm/process_vm_access.o
  CC      kernel/power/user.o
  CC      fs/kernfs/dir.o
  CC      kernel/locking/rwsem-xadd.o
  CC      arch/x86/kernel/cpu/perf_event_intel_uncore.o
  CC      fs/kernfs/file.o
  CC      mm/init-mm.o
  CC      kernel/locking/qrwlock.o
  CC      kernel/power/poweroff.o
  LD      kernel/power/built-in.o
  CC      mm/nobootmem.o
  CC      kernel/printk/printk.o
  LD      kernel/locking/built-in.o
  CC      kernel/rcu/update.o
  CC      fs/kernfs/symlink.o
  CC      mm/fadvise.o
  CC      mm/madvise.o
  LD      fs/kernfs/built-in.o
  CC      kernel/rcu/sync.o
  CC      fs/lockd/clntlock.o
  CC      arch/x86/kernel/cpu/perf_event_intel_uncore_snb.o
  CC      kernel/rcu/srcu.o
  CC      fs/lockd/clntproc.o
  CC      mm/memblock.o
  LD      fs/jbd2/jbd2.o
  LD      fs/jbd2/built-in.o
  CC      fs/nfs/client.o
  CC      kernel/rcu/tree.o
  CC      arch/x86/kernel/cpu/perf_event_intel_uncore_snbep.o
  CC      fs/nfs/dir.o
  LD      kernel/printk/built-in.o
  CC      kernel/sched/core.o
  CC      mm/page_io.o
  CC      fs/lockd/clntxdr.o
  CC      mm/swap_state.o
  CC      kernel/sched/loadavg.o
kernel/sched/core.c: In function =E2=80=98sched_init=E2=80=99:
  CC      arch/x86/kernel/cpu/perf_event_intel_uncore_nhmex.o
kernel/sched/core.c:7619:30: warning: the comparison will always
evaluate as =E2=80=98false=E2=80=99 for the address of =E2=80=98cpu_isolate=
d_map=E2=80=99 will never
be NULL [-Waddress]
 7619 |         if (cpu_isolated_map =3D=3D NULL)
      |                              ^~
kernel/sched/core.c:288:15: note: =E2=80=98cpu_isolated_map=E2=80=99 declar=
ed here
  288 | cpumask_var_t cpu_isolated_map;
      |               ^~~~~~~~~~~~~~~~
  CC      fs/lockd/host.o
  CC      kernel/sched/clock.o
  CC      mm/swapfile.o
  CC      kernel/sched/cputime.o
  CC      arch/x86/kernel/cpu/perf_event_msr.o
  CC      fs/lockd/svc.o
  LD      kernel/rcu/built-in.o
  CC      arch/x86/kernel/cpu/mcheck/mce.o
  CC      kernel/sched/idle_task.o
  CC      arch/x86/kernel/cpu/microcode/core.o
  CC      fs/ext4/page-io.o
  CC      arch/x86/kernel/cpu/microcode/intel.o
  CC      fs/nfs/file.o
  CC      fs/lockd/svclock.o
  CC      arch/x86/kernel/cpu/microcode/intel_lib.o
  CC      fs/ext4/ioctl.o
  CC      arch/x86/kernel/cpu/microcode/amd.o
  CC      fs/nfs/getroot.o
  CC      mm/dmapool.o
  CC      arch/x86/kernel/cpu/mcheck/mce-severity.o
  CC      mm/hugetlb.o
  CC      fs/lockd/svcshare.o
  LD      arch/x86/kernel/cpu/microcode/microcode.o
  CC      fs/nfs/inode.o
  LD      arch/x86/kernel/cpu/microcode/built-in.o
  CC      arch/x86/kernel/cpu/mtrr/main.o
  CC      fs/ext4/namei.o
  CC      arch/x86/kernel/cpu/mcheck/mce-genpool.o
  CC      fs/nfs/super.o
  CC      arch/x86/kernel/cpu/mcheck/mce_intel.o
  CC      fs/lockd/svcproc.o
  CC      arch/x86/kernel/cpu/mtrr/if.o
  CC      arch/x86/kernel/cpu/mcheck/mce_amd.o
  CC      arch/x86/kernel/cpu/mtrr/generic.o
  CC      fs/lockd/svcsubs.o
  CC      kernel/sched/fair.o
  CC      arch/x86/kernel/cpu/mcheck/threshold.o
  CC      arch/x86/kernel/cpu/mcheck/therm_throt.o
  CC      arch/x86/kernel/cpu/mtrr/cleanup.o
  CC      fs/lockd/mon.o
  CC      arch/x86/kernel/cpu/mtrr/amd.o
  CC      fs/nfs/direct.o
  CC      mm/page_poison.o
  CC      fs/nfs/pagelist.o
  CC      arch/x86/kernel/cpu/mtrr/cyrix.o
  LD      arch/x86/kernel/cpu/mcheck/built-in.o
  CC      arch/x86/kernel/cpu/perfctr-watchdog.o
  CC      mm/slub.o
  CC      arch/x86/kernel/cpu/mtrr/centaur.o
  CC      arch/x86/kernel/cpu/perf_event_amd_ibs.o
  CC      fs/lockd/xdr.o
  LD      arch/x86/kernel/cpu/mtrr/built-in.o
  CC      fs/lockd/clnt4xdr.o
  CC      fs/ext4/super.o
  CC      fs/nfs/read.o
  CC      arch/x86/kernel/cpu/capflags.o
  CC      fs/nfs/symlink.o
  LD      arch/x86/kernel/cpu/built-in.o
  CC      fs/lockd/xdr4.o
  CC      arch/x86/kernel/i8237.o
  CC      fs/lockd/svc4proc.o
  CC      arch/x86/kernel/stacktrace.o
  CC      arch/x86/kernel/reboot.o
  CC      fs/nfs/unlink.o
  CC      fs/nfs/write.o
  CC      fs/lockd/procfs.o
  CC      fs/nfs/namespace.o
  CC      arch/x86/kernel/msr.o
  LD      fs/lockd/lockd.o
  LD      fs/lockd/built-in.o
  CC      fs/nfs_common/nfsacl.o
  CC      kernel/sched/rt.o
  CC      arch/x86/kernel/cpuid.o
  CC      fs/nfs_common/grace.o
  CC      fs/nfs/mount_clnt.o
  CC      arch/x86/kernel/early-quirks.o
  CC      fs/nfs/nfstrace.o
  CC      mm/migrate.o
  LD      fs/nfs_common/nfs_acl.o
  LD      fs/nfs_common/built-in.o
  CC      fs/nls/nls_base.o
  CC      fs/nfs/nfsroot.o
  CC      kernel/sched/deadline.o
  CC      arch/x86/kernel/smp.o
  CC      fs/nls/nls_cp437.o
  CC      fs/nls/nls_ascii.o
  CC      fs/nfs/sysctl.o
  CC      fs/nls/nls_iso8859-1.o
  CC      mm/kmemleak.o
  CC      fs/nfs/nfs2super.o
  CC      fs/nls/nls_utf8.o
  CC      arch/x86/kernel/smpboot.o
  LD      fs/nls/built-in.o
  CC      fs/notify/fsnotify.o
  CC      fs/nfs/proc.o
  CC      kernel/sched/stop_task.o
  CC      fs/nfs/nfs2xdr.o
  CC      fs/nfs/nfs3super.o
  CC      fs/notify/notification.o
  CC      kernel/sched/wait.o
  CC      mm/early_ioremap.o
  CC      arch/x86/kernel/tsc_sync.o
  CC      fs/notify/group.o
  CC      fs/nfs/nfs3client.o
  CC      fs/nfs/nfs3proc.o
  CC      mm/page_ext.o
  CC      arch/x86/kernel/setup_percpu.o
  CC      kernel/sched/completion.o
  CC      fs/notify/inode_mark.o
  CC      fs/nfs/nfs3xdr.o
  CC      mm/frame_vector.o
  CC      arch/x86/kernel/mpparse.o
  CC      fs/nfs/nfs3acl.o
  CC      kernel/sched/idle.o
  CC      fs/notify/mark.o
  LD      mm/built-in.o
  CC      ipc/util.o
  CC      fs/nfs/nfs4proc.o
  CC      kernel/sched/cpupri.o
  CC      arch/x86/kernel/reboot_fixups_32.o
  CC      fs/notify/vfsmount_mark.o
  CC      kernel/sched/cpudeadline.o
  CC      kernel/sched/stats.o
  CC      arch/x86/kernel/trace_clock.o
  CC      ipc/msgutil.o
  CC      arch/x86/kernel/machine_kexec_32.o
  CC      fs/notify/fdinfo.o
  CC      kernel/sched/cpuacct.o
  CC      fs/nfs/nfs4xdr.o
  CC      fs/nfs/nfs4state.o
  CC      ipc/msg.o
  CC      fs/notify/dnotify/dnotify.o
  AS      arch/x86/kernel/relocate_kernel_32.o
  CC      arch/x86/kernel/crash.o
  LD      kernel/sched/built-in.o
  CC      kernel/time/time.o
  LD      fs/notify/dnotify/built-in.o
  LD      fs/notify/fanotify/built-in.o
  CC      fs/notify/inotify/inotify_fsnotify.o
  CC      arch/x86/kernel/crash_dump_32.o
  CC      kernel/time/timer.o
  CC      fs/notify/inotify/inotify_user.o
  CC      ipc/sem.o
  CC      arch/x86/kernel/module.o
  CC      fs/ext4/symlink.o
  CC      arch/x86/kernel/doublefault.o
  LD      fs/notify/inotify/built-in.o
  LD      fs/notify/built-in.o
  CC      fs/proc/task_mmu.o
  CC      fs/ext4/hash.o
  CC      arch/x86/kernel/early_printk.o
  CC      fs/ext4/resize.o
  CC      arch/x86/kernel/hpet.o
  CC      fs/ext4/extents.o
  CC      kernel/time/hrtimer.o
  CC      fs/proc/inode.o
  CC      fs/nfs/nfs4renewd.o
  CC      ipc/shm.o
  CC      fs/proc/root.o
  CC      arch/x86/kernel/amd_nb.o
  CC      fs/nfs/nfs4super.o
  CC      fs/proc/base.o
  CC      kernel/time/itimer.o
  CC      fs/ext4/ext4_jbd2.o
  CC      arch/x86/kernel/pcspeaker.o
  CC      fs/nfs/nfs4file.o
  CC      arch/x86/kernel/check.o
  CC      ipc/syscall.o
  CC      fs/nfs/delegation.o
  CC      kernel/time/posix-timers.o
  CC      arch/x86/kernel/sysfb.o
  CC      ipc/ipc_sysctl.o
  CC      arch/x86/kernel/sysfb_efi.o
  CC      ipc/mqueue.o
  CC      arch/x86/kernel/perf_regs.o
  CC      fs/ext4/migrate.o
  CC      arch/x86/kernel/tracepoint.o
  AS      arch/x86/kernel/head_32.o
  CC      arch/x86/kernel/head32.o
  CC      arch/x86/kernel/head.o
  CC      kernel/time/posix-cpu-timers.o
  CC      fs/proc/generic.o
  LDS     arch/x86/kernel/vmlinux.lds
  LD      arch/x86/kernel/built-in.o
  CC      fs/proc/array.o
ld: warning: arch/x86/kernel/acpi/built-in.o: requires executable
stack (because the .note.GNU-stack section is executable)
  LD      arch/x86/built-in.o
ld: warning: arch/x86/entry/built-in.o: requires executable stack
(because the .note.GNU-stack section is executable)
WARNING: arch/x86/built-in.o (.discard.nospec): unexpected
non-allocatable section.
Did you forget to use "ax"/"aw" in a .S file?
Note that for example <linux/init.h> contains
section definitions for use in .S files.

WARNING: arch/x86/built-in.o (.discard.retpoline_safe): unexpected
non-allocatable section.
Did you forget to use "ax"/"aw" in a .S file?
Note that for example <linux/init.h> contains
section definitions for use in .S files.

  CC      security/integrity/iint.o
  CC      security/keys/gc.o
  CC      fs/nfs/nfs4idmap.o
  CC      fs/proc/fd.o
  CC      security/integrity/integrity_audit.o
  CC      ipc/namespace.o
  CC      security/keys/key.o
  CC      fs/proc/proc_tty.o
  LD      security/integrity/integrity.o
  CC      kernel/time/timekeeping.o
  LD      security/integrity/built-in.o
  GEN     security/selinux/flask.h security/selinux/av_permissions.h
  CC      security/selinux/avc.o
  CC      ipc/mq_sysctl.o
  CC      fs/proc/cmdline.o
  CC      fs/proc/consoles.o
  LD      ipc/built-in.o
  CC      crypto/api.o
  CC      security/keys/keyring.o
  CC      fs/proc/cpuinfo.o
  CC      fs/ext4/mballoc.o
  CC      fs/proc/devices.o
  CC      fs/proc/interrupts.o
  CC      fs/proc/loadavg.o
  CC      fs/nfs/callback.o
  CC      fs/proc/meminfo.o
  CC      crypto/cipher.o
  CC      fs/proc/stat.o
  CC      security/selinux/hooks.o
  CC      security/keys/keyctl.o
  CC      kernel/time/ntp.o
  CC      fs/proc/uptime.o
  CC      crypto/compress.o
  CC      crypto/memneq.o
  CC      fs/nfs/callback_xdr.o
  CC      fs/proc/version.o
  CC      kernel/time/clocksource.o
  CC      crypto/crypto_wq.o
  CC      fs/proc/softirqs.o
  CC      fs/nfs/callback_proc.o
  CC      security/keys/permission.o
  CC      fs/proc/namespaces.o
  CC      crypto/algapi.o
  CC      security/keys/process_keys.o
  CC      fs/proc/self.o
  CC      kernel/time/jiffies.o
  CC      fs/proc/thread_self.o
  CC      fs/proc/proc_sysctl.o
  CC      kernel/time/timer_list.o
  CC      fs/nfs/nfs4namespace.o
  CC      security/keys/request_key.o
  CC      fs/nfs/nfs4getroot.o
  CC      kernel/time/timeconv.o
  CC      crypto/scatterwalk.o
  CC      kernel/time/timecounter.o
  CC      kernel/time/posix-clock.o
  CC      security/keys/request_key_auth.o
  CC      fs/nfs/nfs4client.o
  CC      fs/nfs/nfs4session.o
  CC      crypto/proc.o
  CC      fs/proc/proc_net.o
  CC      security/keys/user_defined.o
kernel/time/posix-clock.c: In function =E2=80=98pc_clock_settime=E2=80=99:
kernel/time/posix-clock.c:345:38: warning: passing argument 1 of
=E2=80=98timespec64_valid_strict=E2=80=99 from incompatible pointer type
[-Wincompatible-pointer-types]
  345 |         if (!timespec64_valid_strict(ts))
      |                                      ^~
      |                                      |
      |                                      const struct timespec *
In file included from include/linux/time.h:7,
                 from include/linux/ktime.h:24,
                 from include/linux/rcupdate.h:47,
                 from include/linux/idr.h:18,
                 from include/linux/kernfs.h:14,
                 from include/linux/sysfs.h:15,
                 from include/linux/kobject.h:21,
                 from include/linux/device.h:17,
                 from kernel/time/posix-clock.c:20:
include/linux/time64.h:181:69: note: expected =E2=80=98const struct timespe=
c64
*=E2=80=99 but argument is of type =E2=80=98const struct timespec *=E2=80=
=99
  181 | static inline bool timespec64_valid_strict(const struct timespec64 =
*ts)
      |                                            ~~~~~~~~~~~~~~~~~~~~~~~~=
~^~
  CC      kernel/time/alarmtimer.o
  CC      crypto/aead.o
  CC      security/keys/proc.o
  CC      fs/proc/kcore.o
  CC      fs/nfs/dns_resolve.o
  CC      security/selinux/selinuxfs.o
  CC      fs/nfs/nfs4trace.o
  CC      security/keys/sysctl.o
  CC      kernel/time/clockevents.o
  LD      security/keys/built-in.o
  CC      security/commoncap.o
  CC      fs/proc/vmcore.o
  CC      crypto/ablkcipher.o
  CC      fs/ext4/block_validity.o
  CC      fs/proc/kmsg.o
  CC      fs/proc/page.o
  CC      kernel/time/tick-common.o
  CC      fs/ext4/move_extent.o
  CC      security/selinux/netlink.o
  CC      security/selinux/nlmsgtab.o
  LD      fs/proc/proc.o
  LD      fs/proc/built-in.o
  CC      fs/quota/dquot.o
  CC      crypto/blkcipher.o
  CC      crypto/skcipher.o
  CC      crypto/chainiv.o
  CC      kernel/time/tick-broadcast.o
  CC      security/selinux/netif.o
  CC      fs/ext4/mmp.o
  CC      fs/quota/quota_v2.o
  CC      fs/nfs/nfs4sysctl.o
  CC      crypto/eseqiv.o
  CC      crypto/seqiv.o
  CC      kernel/time/tick-broadcast-hrtimer.o
  CC      kernel/time/tick-oneshot.o
  CC      security/selinux/netnode.o
  CC      fs/ext4/indirect.o
  CC      kernel/time/tick-sched.o
  LD      fs/nfs/nfs.o
  CC      fs/ramfs/inode.o
  LD      fs/nfs/nfsv2.o
  LD      fs/nfs/nfsv3.o
  LD      fs/nfs/nfsv4.o
  LD      fs/nfs/built-in.o
  CC      kernel/time/timer_stats.o
  CC      crypto/echainiv.o
  CC      fs/sysfs/file.o
  CC      fs/ramfs/file-mmu.o
  CC      crypto/ahash.o
  CC      security/selinux/netport.o
  CC      fs/quota/quota_tree.o
  CC      crypto/shash.o
  CC      fs/sysfs/dir.o
  LD      fs/ramfs/ramfs.o
  LD      fs/ramfs/built-in.o
  CC      fs/tracefs/inode.o
  CC      kernel/time/timekeeping_debug.o
  CC      fs/sysfs/symlink.o
  LD      kernel/time/built-in.o
  CC      kernel/trace/trace_clock.o
  CC      fs/quota/quota.o
  CC      kernel/trace/ring_buffer.o
  CC      fs/sysfs/mount.o
  CC      security/selinux/exports.o
  LD      fs/tracefs/tracefs.o
  LD      fs/tracefs/built-in.o
  CC      crypto/pcompress.o
  CC      kernel/trace/trace.o
  CC      security/selinux/ss/ebitmap.o
  CC      security/selinux/ss/hashtab.o
  CC      fs/sysfs/group.o
  CC      fs/ext4/extents_status.o
  CC      security/selinux/ss/symtab.o
kernel/trace/trace.c: In function =E2=80=98test_cpu_buff_start=E2=80=99:
kernel/trace/trace.c:2701:13: warning: the comparison will always
evaluate as =E2=80=98true=E2=80=99 for the address of =E2=80=98started=E2=
=80=99 will never be NULL
[-Waddress]
 2701 |         if (iter->started && cpumask_test_cpu(iter->cpu, iter->star=
ted))
      |             ^~~~
In file included from kernel/trace/trace.h:15,
                 from kernel/trace/trace.c:46:
include/linux/trace_events.h:91:33: note: =E2=80=98started=E2=80=99 declare=
d here
   91 |         cpumask_var_t           started;
      |                                 ^~~~~~~
kernel/trace/trace.c:2707:13: warning: the comparison will always
evaluate as =E2=80=98true=E2=80=99 for the address of =E2=80=98started=E2=
=80=99 will never be NULL
[-Waddress]
 2707 |         if (iter->started)
      |             ^~~~
include/linux/trace_events.h:91:33: note: =E2=80=98started=E2=80=99 declare=
d here
   91 |         cpumask_var_t           started;
      |                                 ^~~~~~~
  CC      crypto/akcipher.o
  LD      fs/sysfs/built-in.o
  CC      crypto/algboss.o
  CC      security/selinux/ss/sidtab.o
  CC      fs/quota/kqid.o
  CC      fs/quota/netlink.o
  CC      security/selinux/ss/avtab.o
  CC      crypto/testmgr.o
  CC      crypto/hmac.o
  CC      security/selinux/ss/policydb.o
  LD      fs/quota/built-in.o
  CC      fs/eventpoll.o
  CC      crypto/crypto_null.o
  CC      crypto/md5.o
  CC      security/selinux/ss/services.o
  CC      kernel/trace/trace_output.o
  CC      crypto/sha1_generic.o
  CC      fs/ext4/xattr.o
  CC      crypto/sha256_generic.o
  CC      crypto/gf128mul.o
  CC      fs/anon_inodes.o
  CC      kernel/trace/trace_seq.o
  CC      crypto/cbc.o
  CC      fs/signalfd.o
  CC      kernel/trace/trace_stat.o
  CC      crypto/ctr.o
  CC      kernel/trace/trace_printk.o
  CC      security/selinux/ss/conditional.o
  CC      fs/ext4/xattr_user.o
  CC      security/selinux/ss/mls.o
  CC      fs/timerfd.o
  CC      kernel/trace/trace_sched_switch.o
  CC      crypto/gcm.o
  CC      kernel/trace/trace_nop.o
  CC      fs/ext4/xattr_trusted.o
  CC      security/selinux/ss/status.o
  CC      security/selinux/netlabel.o
  CC      kernel/trace/blktrace.o
  CC      fs/ext4/inline.o
  CC      fs/ext4/readpage.o
  CC      fs/ext4/sysfs.o
  CC      fs/ext4/acl.o
  CC      fs/ext4/xattr_security.o
  CC      crypto/ccm.o
  CC      crypto/des_generic.o
  CC      crypto/aes_generic.o
  LD      security/selinux/selinux.o
  CC      crypto/arc4.o
  CC      fs/eventfd.o
  LD      security/selinux/built-in.o
  CC      security/min_addr.o
  CC      security/security.o
  CC      crypto/crc32c_generic.o
  CC      fs/aio.o
  LD      fs/ext4/ext4.o
  CC      kernel/trace/trace_events.o
  CC      crypto/authenc.o
  LD      fs/ext4/built-in.o
  CC      fs/locks.o
  CC      crypto/authencesn.o
  CC      crypto/rng.o
  CC      crypto/drbg.o
  CC      crypto/jitterentropy.o
  CC      crypto/jitterentropy-kcapi.o
  CC      fs/binfmt_misc.o
  CC      crypto/ghash-generic.o
  LD      crypto/crypto.o
  LD      crypto/crypto_algapi.o
  LD      crypto/crypto_blkcipher.o
  LD      crypto/crypto_hash.o
  LD      crypto/cryptomgr.o
  CC      fs/binfmt_script.o
  CC      security/inode.o
  LD      crypto/jitterentropy_rng.o
  CC      security/lsm_audit.o
  CC      fs/binfmt_elf.o
  CC      fs/mbcache.o
  LD      crypto/built-in.o
  CC      kernel/trace/trace_export.o
  CC      fs/posix_acl.o
  CC      kernel/trace/trace_event_perf.o
  CC      fs/coredump.o
  CC      fs/drop_caches.o
  CC      kernel/trace/trace_events_filter.o
  LD      security/built-in.o
  CC      kernel/trace/trace_events_trigger.o
  CC      block/bio.o
  CC      fs/fhandle.o
  CC      fs/dcookies.o
  CC      block/elevator.o
  CC      block/blk-core.o
  CC      block/blk-tag.o
  CC      block/blk-sysfs.o
  LD      fs/built-in.o
  CC      drivers/acpi/tables.o
  CC      kernel/trace/trace_kprobe.o
  CC      block/blk-flush.o
  CC      kernel/trace/power-traces.o
  CC      drivers/acpi/blacklist.o
  CC      block/blk-settings.o
  CC      block/blk-ioc.o
  CC      block/blk-map.o
  CC      drivers/acpi/osl.o
  CC      block/blk-exec.o
  CC      block/blk-merge.o
  CC      block/blk-softirq.o
  CC      kernel/trace/rpm-traces.o
  CC      block/blk-timeout.o
  CC      block/blk-iopoll.o
  CC      kernel/trace/trace_probe.o
  CC      block/blk-lib.o
  CC      block/blk-mq.o
  CC      drivers/acpi/utils.o
  CC      block/blk-mq-tag.o
  CC      block/blk-mq-sysfs.o
  CC      block/blk-mq-cpu.o
  CC      block/blk-mq-cpumap.o
  CC      drivers/acpi/reboot.o
  LD      kernel/trace/built-in.o
  CC      kernel/freezer.o
  CC      block/ioctl.o
  CC      block/genhd.o
  CC      block/scsi_ioctl.o
  CC      drivers/acpi/nvs.o
  CC      block/partition-generic.o
  CC      kernel/profile.o
  CC      block/ioprio.o
  CC      drivers/acpi/wakeup.o
kernel/profile.c: In function =E2=80=98profile_cpu_callback=E2=80=99:
kernel/profile.c:366:35: warning: the comparison will always evaluate
as =E2=80=98true=E2=80=99 for the address of =E2=80=98prof_cpu_mask=E2=80=
=99 will never be NULL
[-Waddress]
  366 |                 if (prof_cpu_mask !=3D NULL)
      |                                   ^~
kernel/profile.c:47:22: note: =E2=80=98prof_cpu_mask=E2=80=99 declared here
   47 | static cpumask_var_t prof_cpu_mask;
      |                      ^~~~~~~~~~~~~
kernel/profile.c:373:35: warning: the comparison will always evaluate
as =E2=80=98true=E2=80=99 for the address of =E2=80=98prof_cpu_mask=E2=80=
=99 will never be NULL
[-Waddress]
  373 |                 if (prof_cpu_mask !=3D NULL)
      |                                   ^~
kernel/profile.c:47:22: note: =E2=80=98prof_cpu_mask=E2=80=99 declared here
   47 | static cpumask_var_t prof_cpu_mask;
      |                      ^~~~~~~~~~~~~
kernel/profile.c: In function =E2=80=98profile_tick=E2=80=99:
kernel/profile.c:414:47: warning: the comparison will always evaluate
as =E2=80=98true=E2=80=99 for the address of =E2=80=98prof_cpu_mask=E2=80=
=99 will never be NULL
[-Waddress]
  414 |         if (!user_mode(regs) && prof_cpu_mask !=3D NULL &&
      |                                               ^~
kernel/profile.c:47:22: note: =E2=80=98prof_cpu_mask=E2=80=99 declared here
   47 | static cpumask_var_t prof_cpu_mask;
      |                      ^~~~~~~~~~~~~
  CC      drivers/acpi/sleep.o
  CC      block/partitions/check.o
  CC      drivers/acpi/device_sysfs.o
  CC      kernel/stacktrace.o
  CC      block/bounce.o
  CC      block/bsg.o
  CC      kernel/futex.o
  CC      block/partitions/amiga.o
  CC      block/partitions/mac.o
  CC      block/partitions/msdos.o
  CC      drivers/acpi/device_pm.o
  CC      drivers/acpi/proc.o
  CC      block/noop-iosched.o
  CC      block/partitions/osf.o
  CC      block/partitions/sgi.o
  CC      drivers/acpi/bus.o
  CC      block/deadline-iosched.o
  CC      drivers/acpi/glue.o
  CC      block/cfq-iosched.o
  CC      block/partitions/sun.o
  CC      block/partitions/efi.o
  CC      block/partitions/karma.o
  CC      drivers/acpi/scan.o
  CC      kernel/dma.o
  CC      drivers/acpi/resource.o
  LD      drivers/amba/built-in.o
  CC      kernel/smp.o
  CC      drivers/ata/libata-core.o
  CC      kernel/uid16.o
  LD      block/partitions/built-in.o
  CC      kernel/module.o
  CC      drivers/ata/libata-scsi.o
  CC      drivers/acpi/acpi_processor.o
  CC      kernel/kallsyms.o
  CC      drivers/acpi/processor_core.o
  CC      kernel/acct.o
  CC      drivers/acpi/processor_pdc.o
  CC      drivers/acpi/ec.o
  CC      drivers/acpi/dock.o
  CC      drivers/acpi/pci_root.o
  CC      drivers/acpi/pci_link.o
  CC      kernel/kexec_core.o
  CC      drivers/acpi/pci_irq.o
  LD      block/built-in.o
  CC      sound/sound_core.o
  CC      drivers/acpi/acpi_lpss.o
  CC      drivers/ata/libata-eh.o
  CC      drivers/acpi/acpi_apd.o
  CC      drivers/acpi/acpi_platform.o
  LD      sound/arm/built-in.o
  LD      sound/atmel/built-in.o
  CC      sound/core/sound.o
  CC      kernel/kexec.o
  CC      drivers/acpi/acpi_pnp.o
  CC      drivers/acpi/int340x_thermal.o
  CC      kernel/cgroup.o
  CC      drivers/acpi/power.o
  CC      sound/core/init.o
  CC      drivers/acpi/event.o
  CC      drivers/acpi/sysfs.o
  CC      kernel/cgroup_freezer.o
  CC      drivers/acpi/property.o
  CC      drivers/acpi/acpi_cmos_rtc.o
  CC      drivers/ata/libata-transport.o
  CC      drivers/acpi/debugfs.o
  CC      kernel/cpuset.o
  CC      sound/core/memory.o
  CC      drivers/acpi/acpi_lpat.o
  CC      drivers/acpi/acpica/dsargs.o
  CC      sound/core/control.o
  CC      drivers/acpi/ac.o
  CC      drivers/acpi/acpica/dscontrol.o
  CC      drivers/acpi/acpica/dsdebug.o
  CC      drivers/ata/libata-trace.o
  CC      drivers/acpi/acpica/dsfield.o
  CC      drivers/acpi/acpica/dsinit.o
  CC      drivers/acpi/button.o
  CC      drivers/ata/libata-sff.o
  CC      drivers/acpi/acpica/dsmethod.o
  CC      drivers/ata/libata-pmp.o
  CC      drivers/acpi/acpica/dsmthdat.o
  CC      drivers/acpi/fan.o
  CC      sound/core/misc.o
  CC      drivers/acpi/acpica/dsobject.o
firmware/Makefile:44: target
'firmware/amdgpu/green_sardine_dmcub.bin.gen.S' given more than once
in the same rule
  MK_FW   firmware/amdgpu/dcn_3_1_6_dmcub.bin.gen.S
  MK_FW   firmware/amdgpu/gc_10_3_7_ce.bin.gen.S
  MK_FW   firmware/amdgpu/gc_10_3_7_me.bin.gen.S
  MK_FW   firmware/amdgpu/gc_10_3_7_mec2.bin.gen.S
  MK_FW   firmware/amdgpu/gc_10_3_7_mec.bin.gen.S
  MK_FW   firmware/amdgpu/gc_10_3_7_pfp.bin.gen.S
  MK_FW   firmware/amdgpu/gc_10_3_7_rlc.bin.gen.S
  MK_FW   firmware/amdgpu/green_sardine_asd.bin.gen.S
  MK_FW   firmware/amdgpu/green_sardine_ce.bin.gen.S
  MK_FW   firmware/amdgpu/green_sardine_sdma.bin.gen.S
  MK_FW   firmware/amdgpu/green_sardine_dmcub.bin.gen.S
  MK_FW   firmware/amdgpu/green_sardine_pfp.bin.gen.S
  MK_FW   firmware/amdgpu/green_sardine_vcn.bin.gen.S
  MK_FW   firmware/amdgpu/green_sardine_ta.bin.gen.S
  MK_FW   firmware/amdgpu/green_sardine_me.bin.gen.S
  MK_FW   firmware/amdgpu/green_sardine_mec.bin.gen.S
  MK_FW   firmware/amdgpu/green_sardine_mec2.bin.gen.S
  MK_FW   firmware/amdgpu/green_sardine_rlc.bin.gen.S
  MK_FW   firmware/amdgpu/psp_13_0_8_asd.bin.gen.S
  MK_FW   firmware/amdgpu/psp_13_0_8_ta.bin.gen.S
  MK_FW   firmware/amdgpu/psp_13_0_8_toc.bin.gen.S
  MK_FW   firmware/amdgpu/raven2_asd.bin.gen.S
  MK_FW   firmware/amdgpu/raven2_ce.bin.gen.S
  MK_FW   firmware/amdgpu/raven2_gpu_info.bin.gen.S
  MK_FW   firmware/amdgpu/raven2_me.bin.gen.S
  MK_FW   firmware/amdgpu/raven2_mec2.bin.gen.S
  MK_FW   firmware/amdgpu/raven2_mec.bin.gen.S
  MK_FW   firmware/amdgpu/raven2_pfp.bin.gen.S
  MK_FW   firmware/amdgpu/raven2_rlc.bin.gen.S
  MK_FW   firmware/amdgpu/raven2_sdma.bin.gen.S
  MK_FW   firmware/amdgpu/raven2_ta.bin.gen.S
  MK_FW   firmware/amdgpu/raven2_vcn.bin.gen.S
  MK_FW   firmware/amdgpu/raven_kicker_rlc.bin.gen.S
  MK_FW   firmware/amdgpu/sdma_5_2_7.bin.gen.S
  MK_FW   firmware/amdgpu/stoney_ce.bin.gen.S
  MK_FW   firmware/amdgpu/stoney_me.bin.gen.S
  MK_FW   firmware/amdgpu/stoney_mec.bin.gen.S
  MK_FW   firmware/amdgpu/stoney_pfp.bin.gen.S
  MK_FW   firmware/amdgpu/stoney_rlc.bin.gen.S
  MK_FW   firmware/amdgpu/stoney_sdma.bin.gen.S
  MK_FW   firmware/amdgpu/stoney_uvd.bin.gen.S
  MK_FW   firmware/amdgpu/stoney_vce.bin.gen.S
  CC      kernel/utsname.o
  MK_FW   firmware/amdgpu/yellow_carp_vcn.bin.gen.S
  MK_FW   firmware/i915/glk_dmc_ver1_04.bin.gen.S
  MK_FW   firmware/i915/kbl_dmc_ver1_04.bin.gen.S
  MK_FW   firmware/rtl_nic/rtl8153a-4.fw.gen.S
  MK_FW   firmware/rtl_nic/rtl8153b-2.fw.gen.S
  MK_FW   firmware/ath10k/QCA6174/hw3.0/firmware-6.bin.gen.S
  MK_FW   firmware/ath10k/QCA6174/hw3.0/board-2.bin.gen.S
  MK_FW   firmware/rtw88/rtw8822c_fw.bin.gen.S
  MK_FW   firmware/rtw88/rtw8822c_wow_fw.bin.gen.S
  MK_FW   firmware/rtw89/rtw8852a_fw.bin.gen.S
  MK_FW   firmware/iwlwifi-so-a0-gf-a0-86.ucode.gen.S
  MK_FW   firmware/iwlwifi-so-a0-gf-a0.pnvm.gen.S
  MK_FW   firmware/iwlwifi-QuZ-a0-hr-b0-77.ucode.gen.S
  MK_FW   firmware/iwlwifi-7265D-29.ucode.gen.S
  MK_FW   firmware/iwlwifi-cc-a0-77.ucode.gen.S
  MK_FW   firmware/mediatek/WIFI_RAM_CODE_MT7961_1.bin.gen.S
  MK_FW   firmware/mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin.gen.S
  MK_FW   firmware/iwlwifi-9000-pu-b0-jf-b0-46.ucode.gen.S
  AS      firmware/amdgpu/dcn_3_1_6_dmcub.bin.gen.o
  AS      firmware/amdgpu/gc_10_3_7_ce.bin.gen.o
  CC      drivers/acpi/acpi_video.o
  AS      firmware/amdgpu/gc_10_3_7_me.bin.gen.o
  AS      firmware/amdgpu/gc_10_3_7_mec2.bin.gen.o
  AS      firmware/amdgpu/gc_10_3_7_mec.bin.gen.o
  AS      firmware/amdgpu/gc_10_3_7_pfp.bin.gen.o
  AS      firmware/amdgpu/gc_10_3_7_rlc.bin.gen.o
  AS      firmware/amdgpu/green_sardine_asd.bin.gen.o
  AS      firmware/amdgpu/green_sardine_ce.bin.gen.o
  CC      drivers/acpi/acpica/dsopcode.o
  AS      firmware/amdgpu/green_sardine_sdma.bin.gen.o
  CC      sound/core/device.o
  AS      firmware/amdgpu/green_sardine_dmcub.bin.gen.o
  CC      kernel/pid_namespace.o
  AS      firmware/amdgpu/green_sardine_pfp.bin.gen.o
  AS      firmware/amdgpu/green_sardine_vcn.bin.gen.o
  AS      firmware/amdgpu/green_sardine_ta.bin.gen.o
  AS      firmware/amdgpu/green_sardine_me.bin.gen.o
  AS      firmware/amdgpu/green_sardine_mec.bin.gen.o
  AS      firmware/amdgpu/green_sardine_mec2.bin.gen.o
  AS      firmware/amdgpu/green_sardine_rlc.bin.gen.o
  AS      firmware/amdgpu/psp_13_0_8_asd.bin.gen.o
  AS      firmware/amdgpu/psp_13_0_8_ta.bin.gen.o
  AS      firmware/amdgpu/psp_13_0_8_toc.bin.gen.o
  CC      arch/x86/pci/i386.o
  AS      firmware/amdgpu/raven2_asd.bin.gen.o
  AS      firmware/amdgpu/raven2_ce.bin.gen.o
  AS      firmware/amdgpu/raven2_gpu_info.bin.gen.o
  AS      firmware/amdgpu/raven2_me.bin.gen.o
  AS      firmware/amdgpu/raven2_mec2.bin.gen.o
  AS      firmware/amdgpu/raven2_mec.bin.gen.o
  AS      firmware/amdgpu/raven2_pfp.bin.gen.o
  AS      firmware/amdgpu/raven2_rlc.bin.gen.o
  AS      firmware/amdgpu/raven2_sdma.bin.gen.o
  CC      drivers/acpi/acpica/dsutils.o
  AS      firmware/amdgpu/raven2_ta.bin.gen.o
  CC      sound/core/info.o
  AS      firmware/amdgpu/raven2_vcn.bin.gen.o
  AS      firmware/amdgpu/raven_kicker_rlc.bin.gen.o
  AS      firmware/amdgpu/sdma_5_2_7.bin.gen.o
  AS      firmware/amdgpu/stoney_ce.bin.gen.o
  AS      firmware/amdgpu/stoney_me.bin.gen.o
  AS      firmware/amdgpu/stoney_mec.bin.gen.o
  AS      firmware/amdgpu/stoney_pfp.bin.gen.o
  AS      firmware/amdgpu/stoney_rlc.bin.gen.o
  AS      firmware/amdgpu/stoney_sdma.bin.gen.o
  AS      firmware/amdgpu/stoney_uvd.bin.gen.o
  CC      arch/x86/pci/init.o
  AS      firmware/amdgpu/stoney_vce.bin.gen.o
  CC      drivers/ata/libata-acpi.o
  AS      firmware/amdgpu/yellow_carp_vcn.bin.gen.o
  AS      firmware/i915/glk_dmc_ver1_04.bin.gen.o
  AS      firmware/i915/kbl_dmc_ver1_04.bin.gen.o
  CC      arch/x86/pci/pcbios.o
  AS      firmware/rtl_nic/rtl8153a-4.fw.gen.o
  CC      drivers/acpi/acpica/dswexec.o
  AS      firmware/rtl_nic/rtl8153b-2.fw.gen.o
  AS      firmware/ath10k/QCA6174/hw3.0/firmware-6.bin.gen.o
  AS      firmware/ath10k/QCA6174/hw3.0/board-2.bin.gen.o
  AS      firmware/rtw88/rtw8822c_fw.bin.gen.o
  AS      firmware/rtw88/rtw8822c_wow_fw.bin.gen.o
  AS      firmware/rtw89/rtw8852a_fw.bin.gen.o
  GZIP    kernel/config_data.gz
  AS      firmware/iwlwifi-so-a0-gf-a0-86.ucode.gen.o
  CC      kernel/stop_machine.o
  AS      firmware/iwlwifi-so-a0-gf-a0.pnvm.gen.o
  CC      drivers/acpi/acpica/dswload.o
  AS      firmware/iwlwifi-QuZ-a0-hr-b0-77.ucode.gen.o
  CC      drivers/ata/ahci.o
  AS      firmware/iwlwifi-7265D-29.ucode.gen.o
  AS      firmware/iwlwifi-cc-a0-77.ucode.gen.o
  AS      firmware/mediatek/WIFI_RAM_CODE_MT7961_1.bin.gen.o
  AS      firmware/mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin.gen.o
  AS      firmware/iwlwifi-9000-pu-b0-jf-b0-46.ucode.gen.o
  LD      firmware/built-in.o
  CC      drivers/acpi/acpica/dswload2.o
  CC      arch/x86/power/cpu.o
  CC      sound/core/info_oss.o
  CC      arch/x86/pci/mmconfig_32.o
  CC      drivers/acpi/acpica/dswscope.o
  CC      kernel/audit.o
  CC      drivers/acpi/acpica/dswstate.o
  CC      sound/core/isadma.o
  CC      drivers/ata/libahci.o
  CC      drivers/acpi/acpica/evevent.o
  CC      arch/x86/pci/direct.o
  CC      arch/x86/power/hibernate_32.o
  CC      arch/x86/pci/mmconfig-shared.o
  CC      sound/core/sound_oss.o
  CC      arch/x86/pci/fixup.o
  CC      drivers/acpi/acpica/evgpe.o
  CC      drivers/acpi/acpica/evgpeblk.o
  AS      arch/x86/power/hibernate_asm_32.o
  LD      arch/x86/power/built-in.o
ld: warning: arch/x86/power/hibernate_asm_32.o: missing
.note.GNU-stack section implies executable stack
ld: NOTE: This behaviour is deprecated and will be removed in a future
version of the linker
  CC      arch/x86/video/fbdev.o
  CC      sound/core/vmaster.o
  CC      drivers/acpi/acpica/evgpeinit.o
  CC      drivers/acpi/acpica/evgpeutil.o
  CC      arch/x86/pci/acpi.o
  CC      arch/x86/pci/legacy.o
  LD      arch/x86/video/built-in.o
  LD      arch/x86/ras/built-in.o
  CC      net/socket.o
  LD      drivers/auxdisplay/built-in.o
  CC      drivers/base/component.o
  CC      drivers/acpi/acpica/evglock.o
  CC      sound/core/ctljack.o
  CC      arch/x86/pci/irq.o
  CC      arch/x86/pci/common.o
  CC      kernel/auditfilter.o
  CC      drivers/acpi/acpica/evhandler.o
  CC      drivers/base/core.o
  CC      drivers/ata/ata_piix.o
  CC      sound/core/jack.o
  CC      drivers/acpi/acpica/evmisc.o
  CC      arch/x86/pci/early.o
  CC      sound/core/hwdep.o
  CC      drivers/acpi/acpica/evregion.o
  CC      drivers/acpi/acpica/evrgnini.o
  CC      arch/x86/pci/bus_numa.o
  CC      drivers/ata/pata_amd.o
  CC      drivers/acpi/acpica/evsci.o
  CC      drivers/acpi/acpica/evxface.o
  CC      sound/core/timer.o
  CC      arch/x86/pci/amd_bus.o
  CC      kernel/auditsc.o
  CC      drivers/acpi/acpica/evxfevnt.o
  CC      net/802/fddi.o
  CC      drivers/base/bus.o
  CC      drivers/acpi/acpica/evxfgpe.o
  CC      drivers/acpi/acpica/evxfregn.o
  CC      drivers/ata/pata_oldpiix.o
  LD      arch/x86/pci/built-in.o
  CC      lib/usercopy.o
  CC      drivers/acpi/acpica/exconfig.o
  CC      lib/lockref.o
  CC      drivers/acpi/acpica/exconvrt.o
  LD      net/802/built-in.o
  LD      net/bluetooth/built-in.o
  CC      net/core/sock.o
  CC      lib/bcd.o
  CC      lib/div64.o
  CC      drivers/ata/pata_sch.o
  CC      lib/sort.o
  CC      net/core/request_sock.o
  CC      drivers/acpi/acpica/excreate.o
  CC      lib/parser.o
  CC      drivers/base/dd.o
  CC      sound/core/hrtimer.o
  CC      lib/halfmd4.o
  CC      drivers/acpi/acpica/exdebug.o
  CC      drivers/ata/pata_mpiix.o
  CC      lib/debug_locks.o
  CC      net/core/skbuff.o
  CC      lib/random32.o
  CC      drivers/acpi/acpica/exdump.o
  CC      kernel/audit_watch.o
  CC      sound/core/pcm.o
  CC      drivers/base/syscore.o
  CC      drivers/acpi/acpica/exfield.o
  CC      drivers/ata/ata_generic.o
  CC      lib/bust_spinlocks.o
  CC      drivers/acpi/acpica/exfldio.o
  CC      lib/kasprintf.o
  CC      drivers/base/driver.o
  CC      kernel/audit_fsnotify.o
  LD      drivers/ata/libata.o
  CC      lib/bitmap.o
  LD      drivers/ata/built-in.o
  CC      kernel/audit_tree.o
  CC      sound/core/pcm_native.o
  CC      drivers/acpi/acpica/exmutex.o
  CC      drivers/base/class.o
  CC      kernel/kprobes.o
  CC      net/core/datagram.o
  CC      drivers/acpi/acpica/exnames.o
  CC      lib/scatterlist.o
  CC      drivers/base/platform.o
  CC      drivers/acpi/acpica/exoparg1.o
  CC      kernel/hung_task.o
  CC      drivers/acpi/acpica/exoparg2.o
  CC      lib/gcd.o
  CC      lib/lcm.o
  CC      lib/list_sort.o
  CC      net/core/stream.o
  CC      drivers/base/cpu.o
  CC      lib/uuid.o
  CC      drivers/acpi/acpica/exoparg3.o
  CC      kernel/watchdog.o
  CC      lib/flex_array.o
  CC      kernel/seccomp.o
  CC      drivers/acpi/acpica/exoparg6.o
  CC      lib/iov_iter.o
  CC      drivers/base/firmware.o
  CC      net/core/scm.o
  CC      drivers/acpi/acpica/exprep.o
  CC      drivers/base/init.o
  CC      kernel/relay.o
  CC      drivers/base/map.o
  CC      sound/core/pcm_lib.o
  CC      drivers/base/devres.o
  CC      drivers/acpi/acpica/exmisc.o
  CC      drivers/base/attribute_container.o
  CC      kernel/utsname_sysctl.o
  CC      drivers/acpi/acpica/exregion.o
  CC      net/core/gen_stats.o
  CC      kernel/delayacct.o
  CC      drivers/base/transport_class.o
  CC      drivers/base/topology.o
  CC      kernel/taskstats.o
  CC      drivers/acpi/acpica/exresnte.o
  CC      lib/clz_ctz.o
  CC      drivers/base/container.o
  CC      kernel/tsacct.o
  CC      lib/bsearch.o
  CC      drivers/acpi/acpica/exresolv.o
  CC      drivers/acpi/acpica/exresop.o
  CC      net/core/gen_estimator.o
  CC      drivers/base/property.o
  CC      lib/find_bit.o
  CC      kernel/tracepoint.o
  CC      drivers/acpi/acpica/exstore.o
  CC      drivers/acpi/acpica/exstoren.o
  CC      lib/llist.o
  CC      lib/memweight.o
  CC      kernel/irq_work.o
  CC      lib/kfifo.o
  CC      sound/core/pcm_misc.o
  CC      sound/core/pcm_memory.o
  CC      drivers/acpi/acpica/exstorob.o
  CC      drivers/base/cacheinfo.o
  CC      net/core/net_namespace.o
  CC      kernel/crash_dump.o
  CC      sound/core/memalloc.o
  CC      drivers/acpi/acpica/exsystem.o
  CC      sound/core/pcm_timer.o
  CC      sound/core/sgbuf.o
  CC      lib/percpu-refcount.o
  CC      kernel/jump_label.o
  CC      drivers/acpi/acpica/exutils.o
  CC      sound/core/oss/mixer_oss.o
  CC      drivers/base/devtmpfs.o
  CC      sound/core/seq/seq.o
  LD      sound/core/snd.o
  LD      sound/core/snd-hwdep.o
  LD      sound/core/snd-timer.o
  LD      sound/core/snd-hrtimer.o
  LD      sound/core/snd-pcm.o
  CC      sound/core/seq/seq_lock.o
  CC      lib/percpu_ida.o
  CC      drivers/acpi/acpica/hwacpi.o
  CC      kernel/membarrier.o
  CC      kernel/memremap.o
  CC      sound/core/seq/seq_clientmgr.o
  CC      drivers/acpi/acpica/hwesleep.o
  CC      net/core/secure_seq.o
  CC      drivers/base/power/sysfs.o
  CC      lib/rhashtable.o
  CC      sound/core/seq/seq_memory.o
  CHK     kernel/config_data.h
  UPD     kernel/config_data.h
  CC      kernel/configs.o
  CC      net/core/flow_dissector.o
  CC      drivers/acpi/acpica/hwgpe.o
  CC      sound/core/oss/pcm_oss.o
  LD      kernel/built-in.o
  CC      drivers/base/power/generic_ops.o
  CC      drivers/acpi/acpica/hwpci.o
  CC      net/core/sysctl_net_core.o
  CC      drivers/base/power/common.o
  CC      drivers/acpi/acpica/hwregs.o
  CC      sound/core/oss/pcm_plugin.o
  CC      drivers/base/power/qos.o
  CC      sound/core/seq/seq_queue.o
  CC      lib/reciprocal_div.o
  CC      drivers/acpi/acpica/hwsleep.o
  CC      net/core/dev.o
  CC      lib/once.o
  CC      net/core/ethtool.o
  CC      lib/string_helpers.o
  CC      drivers/acpi/acpica/hwvalid.o
  CC      sound/core/oss/io.o
  CC      sound/core/seq/seq_fifo.o
  CC      drivers/base/power/runtime.o
  CC      lib/hexdump.o
  CC      drivers/acpi/acpica/hwxface.o
  CC      lib/kstrtox.o
  CC      sound/core/oss/copy.o
  CC      sound/core/seq/seq_prioq.o
  CC      sound/core/oss/linear.o
  CC      drivers/acpi/acpica/hwxfsleep.o
  CC      lib/iomap.o
  CC      drivers/acpi/acpica/nsaccess.o
  CC      drivers/acpi/acpica/nsalloc.o
  CC      sound/core/seq/seq_timer.o
  CC      sound/core/oss/mulaw.o
  CC      drivers/base/power/wakeirq.o
  CC      sound/core/oss/route.o
  CC      drivers/acpi/acpica/nsarguments.o
  CC      lib/pci_iomap.o
  CC      drivers/acpi/acpica/nsconvert.o
  CC      drivers/base/power/main.o
  CC      drivers/acpi/acpica/nsdump.o
  CC      sound/core/oss/rate.o
  CC      drivers/acpi/acpica/nseval.o
  CC      sound/core/seq/seq_system.o
  CC      sound/core/seq/seq_ports.o
  CC      lib/iomap_copy.o
  CC      sound/core/seq/seq_info.o
  CC      lib/devres.o
  CC      drivers/acpi/acpica/nsinit.o
  CC      drivers/acpi/acpica/nsload.o
  LD      sound/core/oss/snd-mixer-oss.o
  LD      sound/core/oss/snd-pcm-oss.o
  LD      sound/core/oss/built-in.o
  CC      drivers/acpi/acpica/nsnames.o
  CC      sound/core/seq/seq_device.o
  CC      drivers/acpi/acpica/nsobject.o
  CC      drivers/acpi/acpica/nsparse.o
  CC      lib/check_signature.o
  CC      lib/hweight.o
  CC      sound/core/seq/seq_midi_event.o
  CC      drivers/base/regmap/regmap.o
  CC      lib/interval_tree.o
  CC      lib/assoc_array.o
  CC      sound/core/seq/oss/seq_oss.o
  CC      drivers/acpi/acpica/nspredef.o
  CC      sound/core/seq/oss/seq_oss_init.o
  CC      drivers/acpi/acpica/nsprepkg.o
  CC      lib/bitrev.o
  CC      drivers/base/power/wakeup.o
  CC      drivers/block/loop.o
  CC      lib/rational.o
  CC      sound/core/seq/oss/seq_oss_timer.o
  CC      lib/crc16.o
  CC      drivers/acpi/acpica/nsrepair.o
  CC      drivers/acpi/acpica/nsrepair2.o
  HOSTCC  lib/gen_crc32table
  CC      lib/genalloc.o
  CC      sound/core/seq/oss/seq_oss_ioctl.o
  CC      drivers/acpi/acpica/nssearch.o
  CC      drivers/acpi/acpica/nsutils.o
  LD      sound/drivers/mpu401/built-in.o
  LD      sound/drivers/opl3/built-in.o
  LD      sound/drivers/opl4/built-in.o
  CC      drivers/base/power/trace.o
  LD      sound/drivers/pcsp/built-in.o
  LD      sound/drivers/vx/built-in.o
  LD      sound/drivers/built-in.o
  CC      drivers/acpi/acpica/nswalk.o
  CC      sound/core/seq/oss/seq_oss_event.o
  CC      lib/fonts/fonts.o
  CC      drivers/acpi/acpica/nsxfeval.o
  CC      drivers/base/power/clock_ops.o
  CC      lib/fonts/font_8x8.o
  CC      lib/fonts/font_8x16.o
  CC      lib/lz4/lz4_decompress.o
  LD      drivers/block/built-in.o
  CC      drivers/acpi/acpica/nsxfname.o
  CC      sound/core/seq/oss/seq_oss_rw.o
  CC      drivers/acpi/acpica/nsxfobj.o
  LD      lib/fonts/font.o
  LD      lib/fonts/built-in.o
  CC      sound/core/seq/seq_dummy.o
  LD      drivers/base/power/built-in.o
  CC      drivers/base/dma-mapping.o
  CC      drivers/base/regmap/regcache.o
  LD      lib/lz4/built-in.o
  CC      lib/lzo/lzo1x_compress.o
  CC      drivers/base/regmap/regcache-rbtree.o
  CC      drivers/acpi/acpica/psargs.o
  CC      sound/core/seq/oss/seq_oss_synth.o
  LD      sound/core/seq/snd-seq.o
  LD      sound/core/seq/snd-seq-device.o
  LD      sound/core/seq/snd-seq-midi-event.o
  LD      sound/core/seq/snd-seq-dummy.o
  CC      sound/core/seq/oss/seq_oss_midi.o
  CC      drivers/base/dma-coherent.o
  CC      lib/lzo/lzo1x_decompress_safe.o
  CC      net/core/dev_addr_lists.o
  CC      drivers/acpi/acpica/psloop.o
  CC      net/core/dst.o
  CC      sound/core/seq/oss/seq_oss_readq.o
  CC      drivers/base/regmap/regcache-lzo.o
  LD      lib/lzo/lzo_compress.o
  LD      lib/lzo/lzo_decompress.o
  LD      lib/lzo/built-in.o
  CC      drivers/base/firmware_class.o
  CC      lib/xz/xz_dec_syms.o
  CC      drivers/acpi/acpica/psobject.o
  CC      sound/core/seq/oss/seq_oss_writeq.o
  CC      lib/xz/xz_dec_stream.o
  CC      drivers/base/regmap/regcache-flat.o
  CC      drivers/base/regmap/regmap-debugfs.o
  CC      drivers/acpi/acpica/psopcode.o
  LD      sound/core/seq/oss/snd-seq-oss.o
  LD      sound/core/seq/oss/built-in.o
  LD      sound/core/seq/built-in.o
  LD      sound/core/built-in.o
  LD      sound/firewire/built-in.o
  CC      drivers/acpi/acpica/psopinfo.o
  CC      sound/hda/hda_bus_type.o
  CC      net/core/netevent.o
  CC      drivers/acpi/acpica/psparse.o
  CC      lib/xz/xz_dec_lzma2.o
  CC      sound/hda/hdac_bus.o
  CC      drivers/base/module.o
  CC      drivers/acpi/acpica/psscope.o
  CC      sound/hda/hdac_device.o
  LD      drivers/base/regmap/built-in.o
  CC      drivers/base/pinctrl.o
  CC      drivers/acpi/acpica/pstree.o
  CC      drivers/base/devcoredump.o
  CC      net/core/neighbour.o
  CC      drivers/acpi/acpica/psutils.o
  CC      sound/hda/hdac_sysfs.o
  CC      drivers/base/platform-msi.o
  CC      drivers/acpi/acpica/pswalk.o
  CC      drivers/acpi/acpica/psxface.o
  CC      lib/xz/xz_dec_bcj.o
  CC      drivers/acpi/acpica/rsaddr.o
  CC      drivers/acpi/acpica/rscalc.o
  LD      drivers/base/built-in.o
  CC      sound/hda/hdac_regmap.o
  CC      drivers/acpi/acpica/rscreate.o
  CC      drivers/acpi/acpica/rsdumpinfo.o
  CC      drivers/acpi/acpica/rsinfo.o
  CC      sound/hda/hdac_controller.o
  LD      lib/xz/xz_dec.o
  LD      lib/xz/built-in.o
  CC      lib/zlib_inflate/inffast.o
  CC      drivers/acpi/acpica/rsio.o
  CC      drivers/acpi/acpica/rsirq.o
  CC      drivers/acpi/acpica/rslist.o
  CC      drivers/acpi/acpica/rsmemory.o
  CC      lib/zlib_inflate/inflate.o
  CC      sound/hda/hdac_stream.o
  CC      drivers/acpi/acpica/rsmisc.o
  CC      drivers/acpi/acpica/rsserial.o
  CC      drivers/acpi/acpica/rsutils.o
  LD      sound/i2c/other/built-in.o
  LD      sound/i2c/built-in.o
  CC      drivers/acpi/acpica/rsxface.o
  CC      sound/hda/array.o
  CC      drivers/acpi/acpica/tbdata.o
  CC      drivers/acpi/acpica/tbfadt.o
  CC      sound/hda/trace.o
  CC      sound/hda/hdac_i915.o
  CC      net/core/rtnetlink.o
  CC      lib/zlib_inflate/infutil.o
  LD      sound/mips/built-in.o
  LD      sound/isa/ad1816a/built-in.o
  LD      sound/parisc/built-in.o
  LD      sound/isa/ad1848/built-in.o
  LD      sound/isa/cs423x/built-in.o
  LD      sound/pci/ac97/built-in.o
  LD      sound/isa/es1688/built-in.o
  LD      sound/pci/ali5451/built-in.o
  CC      lib/zlib_inflate/inftrees.o
  LD      sound/isa/galaxy/built-in.o
  LD      sound/pci/asihpi/built-in.o
  LD      sound/pci/au88x0/built-in.o
  LD      sound/isa/gus/built-in.o
  LD      sound/pci/aw2/built-in.o
  LD      sound/isa/msnd/built-in.o
  LD      sound/pci/ca0106/built-in.o
  LD      sound/isa/opti9xx/built-in.o
  LD      sound/pci/cs46xx/built-in.o
  LD      sound/isa/sb/built-in.o
  LD      sound/pci/cs5535audio/built-in.o
  LD      sound/isa/wavefront/built-in.o
  LD      sound/pci/ctxfi/built-in.o
  LD      sound/isa/wss/built-in.o
  LD      sound/isa/built-in.o
  LD      sound/pci/echoaudio/built-in.o
  LD      sound/pci/emu10k1/built-in.o
  LD      sound/pcmcia/pdaudiocf/built-in.o
  LD      sound/pcmcia/vx/built-in.o
  CC      sound/pci/hda/hda_bind.o
  LD      sound/pcmcia/built-in.o
  LD      sound/ppc/built-in.o
  LD      sound/sh/built-in.o
  LD      sound/soc/built-in.o
  LD      sound/soc/adi/built-in.o
  LD      sound/soc/atmel/built-in.o
  CC      drivers/acpi/acpica/tbfind.o
  LD      sound/soc/au1x/built-in.o
  LD      sound/soc/bcm/built-in.o
  LD      sound/soc/blackfin/built-in.o
  LD      sound/soc/cirrus/built-in.o
  LD      sound/soc/codecs/built-in.o
  LD      sound/soc/davinci/built-in.o
  LD      sound/soc/dwc/built-in.o
  LD      sound/soc/fsl/built-in.o
  LD      sound/soc/generic/built-in.o
  LD      sound/soc/intel/built-in.o
  CC      lib/zlib_inflate/inflate_syms.o
  LD      sound/soc/intel/boards/built-in.o
  LD      sound/soc/jz4740/built-in.o
  LD      sound/soc/kirkwood/built-in.o
  LD      sound/soc/mediatek/built-in.o
  LD      sound/soc/mxs/built-in.o
  LD      sound/soc/nuc900/built-in.o
  LD      sound/soc/omap/built-in.o
  LD      sound/soc/pxa/built-in.o
  LD      sound/soc/qcom/built-in.o
  LD      sound/soc/rockchip/built-in.o
  LD      drivers/bluetooth/built-in.o
  LD      sound/soc/samsung/built-in.o
  CC      drivers/acpi/acpica/tbinstal.o
  LD      sound/soc/sh/built-in.o
  LD      sound/soc/sirf/built-in.o
  LD      sound/soc/spear/built-in.o
  LD      sound/hda/snd-hda-core.o
  LD      sound/soc/sti/built-in.o
  LD      sound/hda/built-in.o
  LD      sound/soc/sunxi/built-in.o
  LD      sound/soc/tegra/built-in.o
  LD      sound/sparc/built-in.o
  LD      sound/spi/built-in.o
  LD      sound/soc/txx9/built-in.o
  LD      sound/soc/ux500/built-in.o
  LD      sound/synth/emux/built-in.o
  LD      sound/soc/xtensa/built-in.o
  LD      sound/synth/built-in.o
  LD      sound/soc/zte/built-in.o
  LD      sound/usb/6fire/built-in.o
  CC      sound/last.o
  LD      sound/usb/bcd2000/built-in.o
  LD      sound/usb/caiaq/built-in.o
  LD      sound/usb/hiface/built-in.o
  CC      drivers/acpi/acpica/tbprint.o
  LD      sound/usb/misc/built-in.o
  LD      lib/zlib_inflate/zlib_inflate.o
  LD      sound/usb/usx2y/built-in.o
  LD      lib/zlib_inflate/built-in.o
  LD      sound/usb/built-in.o
  CC      lib/percpu_counter.o
  CC      drivers/acpi/acpica/tbutils.o
  CC      sound/pci/hda/hda_codec.o
  CC      lib/audit.o
  LD      sound/soundcore.o
  CC      lib/syscall.o
  CC      drivers/acpi/acpica/tbxface.o
  CC      drivers/acpi/acpica/tbxfload.o
  CC      lib/nlattr.o
  CC      lib/cpu_rmap.o
  CC      lib/dynamic_queue_limits.o
  CC      drivers/acpi/acpica/tbxfroot.o
  CC      drivers/acpi/acpica/utaddress.o
  CC      drivers/acpi/acpica/utalloc.o
  CC      lib/glob.o
  CC      lib/strncpy_from_user.o
  CC      drivers/acpi/acpica/utbuffer.o
  CC      lib/strnlen_user.o
  CC      net/dns_resolver/dns_key.o
  CC      net/ethernet/eth.o
  CC      arch/x86/lib/msr-smp.o
  CC      net/dns_resolver/dns_query.o
  CC      drivers/acpi/acpica/utcopy.o
  CC      lib/net_utils.o
  CC      arch/x86/lib/cache-smp.o
  GEN     lib/oid_registry_data.c
  CC      drivers/acpi/acpica/utexcep.o
  LD      net/dns_resolver/dns_resolver.o
  LD      net/dns_resolver/built-in.o
  CC      lib/ucs2_string.o
  CC      arch/x86/lib/msr.o
  CC      net/core/utils.o
  AS      arch/x86/lib/msr-reg.o
  CC      arch/x86/lib/msr-reg-export.o
  LD      virt/lib/built-in.o
  CC      drivers/acpi/acpica/utdebug.o
  LD      virt/built-in.o
  CC      lib/ubsan.o
  CC      lib/argv_split.o
  LD      net/ethernet/built-in.o
  AS      arch/x86/lib/hweight.o
  CC      net/ipv4/route.o
  CC      net/ipv4/inetpeer.o
  CC      arch/x86/lib/atomic64_32.o
  AS      arch/x86/lib/atomic64_cx8_32.o
  CC      drivers/acpi/acpica/utdecode.o
  AS      arch/x86/lib/checksum_32.o
  CC      arch/x86/lib/cmdline.o
  CC      drivers/acpi/acpica/utdelete.o
  CC      lib/bug.o
  CC      arch/x86/lib/delay.o
  CC      lib/cmdline.o
  CC      net/core/link_watch.o
  CC      lib/cpumask.o
  CC      lib/ctype.o
  CC      drivers/acpi/acpica/uterror.o
  AS      arch/x86/lib/getuser.o
  CC      sound/pci/hda/hda_jack.o
  CC      drivers/acpi/acpica/uteval.o
  GEN     arch/x86/lib/inat-tables.c
  CC      arch/x86/lib/insn.o
  CC      lib/dec_and_lock.o
  CC      drivers/acpi/acpica/utglobal.o
  CC      lib/decompress.o
  CC      arch/x86/lib/memcpy_32.o
  CC      arch/x86/lib/misc.o
  CC      lib/decompress_bunzip2.o
  CC      lib/decompress_inflate.o
  CC      net/ipv4/protocol.o
  CC      drivers/acpi/acpica/uthex.o
  AS      arch/x86/lib/putuser.o
  AS      arch/x86/lib/retpoline.o
  CC      net/core/filter.o
  AS      arch/x86/lib/rwsem.o
  CC      arch/x86/lib/string_32.o
  CC      sound/pci/hda/hda_auto_parser.o
  CC      arch/x86/lib/strstr_32.o
  CC      lib/decompress_unlz4.o
  CC      drivers/acpi/acpica/utids.o
  CC      arch/x86/lib/usercopy.o
  CC      lib/decompress_unlzma.o
  CC      lib/decompress_unlzo.o
  CC      net/ipv4/ip_input.o
  CC      drivers/acpi/acpica/utinit.o
  CC      arch/x86/lib/usercopy_32.o
  CC      drivers/acpi/acpica/utlock.o
  CC      lib/decompress_unxz.o
  CC      net/ipv4/ip_fragment.o
  CC      drivers/acpi/acpica/utmath.o
  CC      sound/pci/hda/hda_sysfs.o
  CC      lib/dump_stack.o
  LD      arch/x86/lib/built-in.o
ld: warning: arch/x86/lib/hweight.o: missing .note.GNU-stack section
implies executable stack
ld: NOTE: This behaviour is deprecated and will be removed in a future
version of the linker
  CC      arch/x86/lib/inat.o
  AR      arch/x86/lib/lib.a
  CC      drivers/acpi/acpica/utmisc.o
  CC      drivers/acpi/acpica/utmutex.o
  CC      lib/earlycpio.o
  CC      net/ipv4/ip_forward.o
  CC      net/core/sock_diag.o
  CC      lib/extable.o
  CC      sound/pci/hda/hda_controller.o
  CC      lib/flex_proportions.o
  CC      drivers/acpi/acpica/utnonansi.o
  CC      lib/idr.o
  CC      drivers/acpi/acpica/utobject.o
  CC      lib/int_sqrt.o
  CC      net/ipv4/ip_options.o
  CC      net/ipv4/ip_output.o
  CC      drivers/acpi/acpica/utosi.o
  CC      drivers/acpi/acpica/utownerid.o
  CC      net/core/dev_ioctl.o
  CC      net/ipv4/ip_sockglue.o
  CC      drivers/acpi/acpica/utpredef.o
  CC      drivers/acpi/acpica/utresrc.o
  CC      lib/ioremap.o
  CC      drivers/acpi/acpica/utstate.o
  CC      drivers/acpi/acpica/utstring.o
  CC      lib/irq_regs.o
  CC      sound/pci/hda/hda_proc.o
  CC      lib/is_single_threaded.o
  CC      sound/pci/hda/hda_hwdep.o
  CC      net/core/tso.o
  CC      drivers/acpi/acpica/utxface.o
  CC      sound/pci/hda/hda_intel.o
  CC      lib/klist.o
  CC      drivers/acpi/acpica/utxfinit.o
  LD      sound/pci/ice1712/built-in.o
  CC      net/ipv4/inet_hashtables.o
  CC      drivers/acpi/acpica/utxferror.o
  CC      lib/kobject.o
  CC      net/core/flow.o
  LD      sound/pci/hda/snd-hda-codec.o
  CC      net/core/net-sysfs.o
  CC      drivers/acpi/video_detect.o
  CC      drivers/acpi/acpica/utxfmutex.o
  CC      net/ipv4/inet_timewait_sock.o
  LD      drivers/acpi/acpica/acpi.o
  LD      drivers/acpi/acpica/built-in.o
  CC      drivers/acpi/processor_driver.o
  CC      drivers/acpi/processor_idle.o
  CC      lib/kobject_uevent.o
  LD      sound/pci/hda/snd-hda-intel.o
  LD      sound/pci/hda/built-in.o
  LD      sound/pci/korg1212/built-in.o
  CC      net/core/net-procfs.o
  LD      sound/pci/lola/built-in.o
  LD      sound/pci/lx6464es/built-in.o
  LD      sound/pci/mixart/built-in.o
  LD      sound/pci/nm256/built-in.o
  LD      sound/pci/oxygen/built-in.o
  LD      sound/pci/pcxhr/built-in.o
  CC      net/ipv4/inet_connection_sock.o
  LD      sound/pci/riptide/built-in.o
  LD      sound/pci/rme9652/built-in.o
  LD      sound/pci/trident/built-in.o
  LD      sound/pci/vx222/built-in.o
  LD      sound/pci/ymfpci/built-in.o
  LD      sound/pci/built-in.o
  LD      sound/built-in.o
  CC      net/ipv4/tcp.o
  CC      drivers/acpi/processor_throttling.o
  CC      net/ipv4/tcp_input.o
  CC      lib/md5.o
  CC      drivers/acpi/processor_thermal.o
  CC      net/core/netpoll.o
  CC      lib/nmi_backtrace.o
  CC      net/core/fib_rules.o
  CC      drivers/acpi/processor_perflib.o
  CC      drivers/acpi/container.o
  CC      lib/plist.o
  CC      lib/proportions.o
net/core/netpoll.c: In function =E2=80=98netpoll_setup=E2=80=99:
net/core/netpoll.c:671:13: warning: the comparison will always
evaluate as =E2=80=98true=E2=80=99 for the address of =E2=80=98dev_name=E2=
=80=99 will never be NULL
[-Waddress]
  671 |         if (np->dev_name)
      |             ^~
In file included from net/core/netpoll.c:23:
include/linux/netpoll.h:25:14: note: =E2=80=98dev_name=E2=80=99 declared he=
re
   25 |         char dev_name[IFNAMSIZ];
      |              ^~~~~~~~
  CC      net/ipv4/tcp_output.o
  CC      drivers/acpi/thermal.o
  CC      drivers/acpi/acpi_memhotplug.o
  CC      lib/radix-tree.o
  CC      drivers/acpi/ioapic.o
  CC      net/core/net-traces.o
  CC      net/core/ptp_classifier.o
  CC      drivers/acpi/battery.o
  LD      drivers/acpi/acpi.o
  LD      drivers/acpi/video.o
  LD      drivers/acpi/processor.o
  CC      net/core/dst_cache.o
  CC      lib/ratelimit.o
  CC      lib/rbtree.o
  CC      lib/seq_buf.o
  CC      net/ipv4/tcp_timer.o
  LD      drivers/acpi/built-in.o
  CC      lib/sha1.o
  LD      drivers/bus/built-in.o
  CC      drivers/cdrom/cdrom.o
  CC      lib/show_mem.o
  CC      lib/siphash.o
  CC      lib/string.o
  CC      lib/timerqueue.o
  LD      net/core/built-in.o
  CC      lib/vsprintf.o
  GEN     lib/crc32table.h
  CC      net/ipv6/af_inet6.o
  CC      lib/oid_registry.o
  CC      lib/crc32.o
  CC      net/ipv4/tcp_ipv4.o
  CC      net/ipv4/tcp_minisocks.o
  CC      net/ipv4/tcp_cong.o
  LD      lib/built-in.o
  CC      net/ipv4/tcp_metrics.o
  CC      net/ipv4/tcp_fastopen.o
  CC      net/ipv6/anycast.o
  LD      drivers/cdrom/built-in.o
  CC      net/ipv6/ip6_output.o
  CC      drivers/char/mem.o
  CC      net/ipv6/ip6_input.o
  AR      lib/lib.a
  CC      net/ipv6/addrconf.o
  CC      drivers/char/random.o
  CC      net/ipv6/addrlabel.o
  CC      drivers/char/misc.o
  CC      net/ipv4/tcp_recovery.o
  CC      net/ipv4/tcp_offload.o
  CC      drivers/char/hpet.o
  CC      net/ipv6/route.o
  CC      net/ipv4/datagram.o
  CC      net/ipv6/ip6_fib.o
  CC      drivers/char/nvram.o
  CC      net/ipv4/raw.o
  CC      net/ipv4/udp.o
  CC      drivers/char/agp/backend.o
  CC      drivers/char/hw_random/core.o
  CC      net/ipv6/ipv6_sockglue.o
  CC      drivers/char/hw_random/intel-rng.o
  CC      drivers/char/agp/frontend.o
  CC      net/ipv4/udplite.o
  CC      net/ipv6/ndisc.o
  CC      drivers/char/hw_random/amd-rng.o
  CC      drivers/char/agp/generic.o
  CC      drivers/char/hw_random/geode-rng.o
  CC      net/ipv4/udp_offload.o
  CC      net/ipv6/udp.o
  CC      net/ipv6/udplite.o
  CC      drivers/char/hw_random/via-rng.o
  CC      drivers/char/hw_random/tpm-rng.o
  LD      drivers/char/hw_random/rng-core.o
  CC      net/ipv6/raw.o
  LD      drivers/char/hw_random/built-in.o
  LD      drivers/char/pcmcia/built-in.o
  CC      net/ipv6/icmp.o
  CC      drivers/char/tpm/tpm-interface.o
  CC      drivers/char/agp/isoch.o
  CC      net/ipv4/arp.o
  CC      net/ipv4/icmp.o
  CC      drivers/char/tpm/tpm-dev.o
  CC      drivers/char/agp/amd64-agp.o
  CC      net/ipv6/mcast.o
  CC      drivers/char/tpm/tpm-sysfs.o
  CC      net/ipv6/reassembly.o
  CC      net/ipv6/tcp_ipv6.o
  CC      drivers/char/tpm/tpm-chip.o
  CC      drivers/char/agp/intel-agp.o
  CC      drivers/char/tpm/tpm2-cmd.o
  CC      net/ipv4/devinet.o
  CC      net/ipv4/af_inet.o
  CC      drivers/char/tpm/tpm_ppi.o
  CC      drivers/char/tpm/tpm_eventlog.o
  CC      drivers/char/agp/intel-gtt.o
  CC      drivers/char/tpm/tpm_acpi.o
  CC      net/ipv6/ping.o
  CC      drivers/char/tpm/tpm_tis.o
  LD      drivers/char/tpm/tpm.o
  CC      net/ipv6/exthdrs.o
  LD      drivers/char/agp/agpgart.o
  LD      drivers/char/agp/built-in.o
  CC      net/ipv6/datagram.o
  CC      net/ipv6/ip6_flowlabel.o
  CC      net/ipv4/igmp.o
  CC      net/ipv6/inet6_connection_sock.o
  CC      net/ipv6/sysctl_net_ipv6.o
  LD      drivers/char/tpm/built-in.o
  LD      drivers/char/built-in.o
  CC      drivers/clk/clk-devres.o
  CC      net/ipv4/fib_frontend.o
  CC      drivers/clk/clkdev.o
  CC      net/ipv6/xfrm6_policy.o
  CC      net/ipv6/xfrm6_state.o
  CC      net/ipv6/xfrm6_input.o
  CC      drivers/clk/clk.o
  CC      drivers/clk/clk-divider.o
  CC      net/ipv6/xfrm6_output.o
  CC      net/ipv6/xfrm6_protocol.o
  CC      net/ipv6/netfilter.o
  CC      net/ipv6/proc.o
  CC      drivers/clk/clk-fixed-factor.o
  CC      net/ipv4/fib_semantics.o
  CC      drivers/clk/clk-fixed-rate.o
  CC      drivers/clk/clk-gate.o
  CC      drivers/clk/clk-multiplier.o
  CC      net/ipv6/syncookies.o
  CC      net/ipv6/ah6.o
  CC      net/ipv6/esp6.o
  CC      net/ipv6/xfrm6_mode_transport.o
  CC      drivers/clk/clk-mux.o
  CC      net/ipv4/fib_trie.o
  CC      drivers/clk/clk-composite.o
  CC      net/ipv6/xfrm6_mode_tunnel.o
  CC      net/ipv6/xfrm6_mode_beet.o
  CC      net/mac80211/main.o
  CC      drivers/clk/clk-fractional-divider.o
  CC      drivers/clk/clk-gpio.o
  LD      drivers/clk/bcm/built-in.o
  CC      net/ipv6/netfilter/ip6_tables.o
  CC      drivers/clk/x86/clk-lpt.o
  CC      net/ipv4/inet_fragment.o
  CC      net/ipv4/ping.o
  LD      drivers/clk/x86/clk-x86-lpss.o
  LD      drivers/clk/x86/built-in.o
  LD      drivers/clk/built-in.o
  CC      net/ipv6/sit.o
  CC      drivers/clocksource/acpi_pm.o
  CC      drivers/clocksource/i8253.o
  CC      drivers/connector/cn_queue.o
  LD      drivers/clocksource/built-in.o
  CC      drivers/cpufreq/cpufreq.o
  CC      net/ipv4/ip_tunnel_core.o
  CC      net/ipv6/netfilter/ip6table_filter.o
  CC      drivers/connector/connector.o
  CC      net/ipv4/gre_offload.o
  CC      net/ipv4/ip_tunnel.o
  CC      net/ipv6/netfilter/ip6table_mangle.o
  CC      net/mac80211/status.o
  CC      net/ipv4/sysctl_net_ipv4.o
  CC      drivers/connector/cn_proc.o
  CC      net/ipv6/addrconf_core.o
  CC      drivers/cpufreq/freq_table.o
  CC      net/ipv4/proc.o
  CC      net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.o
  CC      drivers/cpufreq/cpufreq_performance.o
  LD      drivers/connector/cn.o
  LD      drivers/connector/built-in.o
  CC      drivers/cpuidle/cpuidle.o
  CC      net/ipv6/exthdrs_core.o
  CC      drivers/cpuidle/driver.o
  CC      drivers/cpufreq/cpufreq_userspace.o
  CC      drivers/cpuidle/governor.o
  CC      drivers/cpufreq/cpufreq_ondemand.o
  CC      net/ipv4/fib_rules.o
  CC      net/ipv4/ipmr.o
  CC      drivers/cpuidle/sysfs.o
  CC      net/ipv6/netfilter/nf_conntrack_proto_icmpv6.o
  CC      net/ipv6/ip6_checksum.o
  CC      drivers/cpuidle/governors/ladder.o
  CC      drivers/cpuidle/governors/menu.o
  CC      net/mac80211/driver-ops.o
  CC      drivers/cpufreq/cpufreq_governor.o
  CC      net/mac80211/sta_info.o
  CC      net/ipv4/syncookies.o
  CC      net/ipv6/ip6_icmp.o
  CC      net/ipv6/netfilter/nf_defrag_ipv6_hooks.o
  LD      drivers/cpuidle/governors/built-in.o
  LD      drivers/cpuidle/built-in.o
  LD      drivers/crypto/built-in.o
  CC      drivers/dma/dmaengine.o
  CC      drivers/cpufreq/acpi-cpufreq.o
  CC      net/ipv6/output_core.o
  CC      net/ipv6/netfilter/nf_conntrack_reasm.o
  CC      net/ipv4/inet_lro.o
  LD      drivers/cpufreq/built-in.o
  CC      drivers/dma-buf/dma-buf.o
  CC      drivers/dma/acpi-dma.o
  CC      net/ipv4/tunnel4.o
  CC      net/ipv6/protocol.o
  CC      net/ipv6/netfilter/nf_reject_ipv6.o
  CC      net/ipv4/ipconfig.o
  CC      net/mac80211/wep.o
  LD      drivers/dma/xilinx/built-in.o
  LD      drivers/dma/built-in.o
  CC      drivers/edac/edac_stub.o
  CC      drivers/dma-buf/fence.o
  CC      drivers/edac/mce_amd.o
  CC      net/ipv6/ip6_offload.o
  CC      net/ipv4/netfilter.o
  CC      net/ipv6/netfilter/ip6t_ipv6header.o
  CC      net/ipv6/netfilter/ip6t_REJECT.o
  LD      drivers/edac/edac_mce_amd.o
  LD      drivers/edac/built-in.o
  CC      drivers/firewire/init_ohci1394_dma.o
  CC      net/ipv6/tcpv6_offload.o
  CC      net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.o
  CC      net/ipv4/tcp_cubic.o
  LD      net/ipv6/netfilter/nf_conntrack_ipv6.o
  CC      drivers/dma-buf/reservation.o
  LD      net/ipv6/netfilter/nf_defrag_ipv6.o
  CC      drivers/dma-buf/seqno-fence.o
  LD      drivers/firewire/built-in.o
  CC      net/mac80211/wpa.o
  CC      drivers/firmware/dmi_scan.o
  LD      net/ipv6/netfilter/built-in.o
  CC      net/ipv6/udp_offload.o
  CC      net/ipv6/exthdrs_offload.o
  CC      net/ipv6/inet6_hashtables.o
  LD      drivers/dma-buf/built-in.o
  CC      drivers/gpio/devres.o
  CC      net/ipv4/netfilter/nf_conntrack_proto_icmp.o
  CC      drivers/firmware/dmi-id.o
  CC      drivers/gpio/gpiolib.o
  CC      net/ipv6/mcast_snoop.o
  LD      net/ipv6/ipv6.o
  CC      drivers/gpio/gpiolib-legacy.o
  CC      drivers/gpio/gpiolib-acpi.o
  CC      drivers/firmware/memmap.o
  CC      net/mac80211/scan.o
  CC      net/mac80211/offchannel.o
  CC      net/ipv4/netfilter/nf_defrag_ipv4.o
  CC      net/ipv4/netfilter/nf_reject_ipv4.o
  LD      drivers/firmware/broadcom/built-in.o
  CC      drivers/firmware/efi/efi.o
  LD      net/ipv6/built-in.o
  CC      net/netfilter/core.o
  CC      net/netfilter/nf_log.o
  CC      drivers/firmware/efi/vars.o
  CC      net/ipv4/netfilter/ip_tables.o
  CC      net/ipv4/netfilter/iptable_filter.o
  LD      drivers/gpio/built-in.o
  CC      drivers/gpu/drm/drm_crtc_helper.o
  CC      net/netfilter/nf_queue.o
  CC      net/netfilter/nf_sockopt.o
  CC      drivers/firmware/efi/reboot.o
  CC      net/ipv4/netfilter/iptable_mangle.o
  CC      net/mac80211/ht.o
  CC      drivers/firmware/efi/capsule.o
  CC      net/netfilter/nfnetlink.o
  CC      net/ipv4/netfilter/ipt_REJECT.o
  CC      drivers/gpu/drm/drm_dp_helper.o
  CC      net/netfilter/nfnetlink_log.o
  CC      drivers/firmware/efi/efivars.o
  CC      net/mac80211/agg-tx.o
  CC      drivers/gpu/vga/vgaarb.o
  LD      net/ipv4/netfilter/nf_conntrack_ipv4.o
  LD      net/ipv4/netfilter/built-in.o
  CC      net/ipv4/cipso_ipv4.o
  CC      drivers/gpu/drm/drm_probe_helper.o
  CC      drivers/firmware/efi/esrt.o
  CC      net/netfilter/nf_conntrack_core.o
  LD      drivers/gpu/vga/built-in.o
  CC      net/netfilter/nf_conntrack_standalone.o
  CC      drivers/firmware/efi/runtime-map.o
  CC      net/mac80211/agg-rx.o
  CC      net/netfilter/nf_conntrack_expect.o
  CC      drivers/gpu/drm/drm_plane_helper.o
  CC      drivers/firmware/efi/runtime-wrappers.o
  CC      net/netlabel/netlabel_user.o
  CC      drivers/firmware/efi/capsule-loader.o
  CC      drivers/gpu/drm/drm_dp_mst_topology.o
  CC      net/netlabel/netlabel_kapi.o
  CC      net/netfilter/nf_conntrack_helper.o
  CC      net/ipv4/xfrm4_policy.o
  CC      net/netlabel/netlabel_domainhash.o
  LD      drivers/firmware/efi/built-in.o
  LD      drivers/firmware/google/built-in.o
  LD      drivers/firmware/built-in.o
  CC      drivers/hid/hid-core.o
  CC      net/netfilter/nf_conntrack_proto.o
  CC      net/mac80211/vht.o
  CC      net/ipv4/xfrm4_state.o
  CC      net/mac80211/ibss.o
  CC      net/mac80211/iface.o
  CC      net/netfilter/nf_conntrack_l3proto_generic.o
  CC      net/netlabel/netlabel_addrlist.o
  CC      net/ipv4/xfrm4_input.o
  CC      drivers/hid/hid-input.o
  CC      net/mac80211/rate.o
  CC      net/netfilter/nf_conntrack_proto_generic.o
  CC      drivers/gpu/drm/drm_atomic_helper.o
  CC      net/netlabel/netlabel_mgmt.o
  CC      net/ipv4/xfrm4_output.o
  CC      net/netfilter/nf_conntrack_proto_tcp.o
  CC      net/ipv4/xfrm4_protocol.o
  CC      net/netlabel/netlabel_unlabeled.o
  CC      drivers/hid/hid-debug.o
  CC      net/mac80211/michael.o
  LD      drivers/hsi/clients/built-in.o
  LD      drivers/hsi/controllers/built-in.o
  LD      drivers/hsi/built-in.o
  CC      drivers/hwmon/hwmon.o
  CC      drivers/gpu/drm/drm_fb_helper.o
  CC      net/netfilter/nf_conntrack_proto_udp.o
  CC      net/netfilter/nf_conntrack_extend.o
  LD      drivers/hwmon/built-in.o
  LD      drivers/hwtracing/intel_th/built-in.o
  CC      drivers/i2c/i2c-boardinfo.o
  LD      net/ipv4/built-in.o
  CC      net/mac80211/tkip.o
  CC      drivers/i2c/i2c-core.o
  CC      drivers/hid/hidraw.o
  CC      net/netlink/af_netlink.o
  CC      net/netlabel/netlabel_cipso_v4.o
  CC      drivers/i2c/i2c-mux.o
  CC      net/netfilter/nf_conntrack_acct.o
  CC      drivers/hid/hid-generic.o
  CC      drivers/hid/hid-a4tech.o
  CC      drivers/gpu/drm/drm_auth.o
  CC      net/netfilter/nf_conntrack_seqadj.o
  CC      drivers/gpu/drm/drm_bufs.o
  CC      drivers/hid/hid-apple.o
  CC      drivers/gpu/drm/drm_cache.o
  LD      net/netlabel/built-in.o
  CC      net/packet/af_packet.o
  CC      net/mac80211/aes_ccm.o
  CC      drivers/hid/hid-belkin.o
  CC      net/netfilter/nf_conntrack_netlink.o
  CC      net/netfilter/nf_conntrack_ftp.o
  CC      drivers/hid/hid-cherry.o
  CC      net/mac80211/aes_gcm.o
  CC      drivers/i2c/algos/i2c-algo-bit.o
  CC      drivers/hid/hid-chicony.o
  CC      net/netlink/genetlink.o
  CC      drivers/gpu/drm/drm_context.o
  CC      net/mac80211/aes_cmac.o
  LD      drivers/i2c/algos/built-in.o
  CC      drivers/i2c/busses/i2c-i801.o
  CC      drivers/hid/hid-cypress.o
  CC      drivers/i2c/busses/i2c-designware-core.o
  CC      drivers/gpu/drm/drm_dma.o
  CC      drivers/hid/hid-ezkey.o
  CC      net/mac80211/aes_gmac.o
  CC      drivers/hid/hid-gyration.o
  CC      drivers/i2c/busses/i2c-designware-platdrv.o
  LD      net/netlink/built-in.o
  CC      drivers/gpu/drm/drm_fops.o
  CC      net/rfkill/core.o
  CC      drivers/i2c/busses/i2c-designware-baytrail.o
  CC      net/netfilter/nf_conntrack_irc.o
  CC      drivers/hid/hid-kensington.o
  CC      net/mac80211/cfg.o
  CC      drivers/hid/hid-lg.o
  CC      drivers/i2c/busses/i2c-designware-pcidrv.o
  CC      drivers/hid/hid-lgff.o
  LD      net/packet/built-in.o
  CC      net/sched/sch_generic.o
  CC      drivers/gpu/drm/drm_gem.o
  CC      net/sched/sch_mq.o
  LD      drivers/i2c/busses/i2c-designware-platform.o
  CC      net/rfkill/input.o
  LD      drivers/i2c/busses/i2c-designware-pci.o
  LD      drivers/i2c/busses/built-in.o
  CC      net/netfilter/nf_conntrack_sip.o
  LD      drivers/i2c/muxes/built-in.o
  LD      drivers/i2c/built-in.o
  LD      drivers/idle/built-in.o
  LD      drivers/iio/accel/built-in.o
  LD      drivers/iio/adc/built-in.o
  LD      drivers/iio/amplifiers/built-in.o
  LD      drivers/iio/buffer/built-in.o
  LD      drivers/iio/chemical/built-in.o
  LD      drivers/iio/common/hid-sensors/built-in.o
  LD      drivers/iio/common/ms_sensors/built-in.o
  LD      drivers/iio/common/ssp_sensors/built-in.o
  LD      drivers/iio/common/st_sensors/built-in.o
  LD      drivers/iio/common/built-in.o
  LD      drivers/iio/dac/built-in.o
  LD      drivers/iio/frequency/built-in.o
  LD      drivers/iio/gyro/built-in.o
  LD      drivers/iio/humidity/built-in.o
  LD      drivers/iio/imu/inv_mpu6050/built-in.o
  LD      drivers/iio/imu/built-in.o
  LD      drivers/iio/light/built-in.o
  LD      drivers/iio/magnetometer/built-in.o
  LD      drivers/iio/orientation/built-in.o
  LD      drivers/iio/potentiometer/built-in.o
  LD      drivers/iio/pressure/built-in.o
  LD      drivers/iio/proximity/built-in.o
  LD      drivers/iio/temperature/built-in.o
  LD      drivers/iio/trigger/built-in.o
  LD      drivers/iio/built-in.o
  CC      drivers/input/input.o
  LD      net/rfkill/rfkill.o
  LD      net/rfkill/built-in.o
  CC      net/sunrpc/clnt.o
  CC      drivers/hid/hid-lg4ff.o
  CC      net/sunrpc/xprt.o
  CC      net/sched/sch_api.o
  CC      drivers/gpu/drm/drm_ioctl.o
  CC      drivers/hid/hid-microsoft.o
  CC      drivers/gpu/drm/drm_irq.o
  CC      net/netfilter/x_tables.o
  CC      drivers/input/input-compat.o
  CC      drivers/hid/hid-monterey.o
  CC      drivers/input/input-mt.o
  CC      net/sunrpc/socklib.o
  CC      drivers/hid/hid-ntrig.o
  CC      net/sunrpc/xprtsock.o
  CC      net/sched/sch_blackhole.o
  CC      drivers/input/ff-core.o
  CC      drivers/gpu/drm/drm_lock.o
  CC      net/sunrpc/sched.o
  CC      drivers/hid/hid-pl.o
  CC      net/netfilter/xt_tcpudp.o
  CC      net/sched/cls_api.o
  CC      drivers/input/ff-memless.o
  CC      net/mac80211/ethtool.o
  CC      drivers/hid/hid-petalynx.o
  CC      drivers/gpu/drm/drm_memory.o
  CC      drivers/input/input-polldev.o
  CC      drivers/hid/hid-samsung.o
  CC      net/netfilter/xt_CONNSECMARK.o
  CC      drivers/gpu/drm/drm_drv.o
  CC      net/sched/act_api.o
  CC      drivers/input/sparse-keymap.o
  CC      drivers/hid/hid-sony.o
  CC      net/netfilter/xt_NFLOG.o
  CC      drivers/hid/hid-sunplus.o
  CC      drivers/input/input-leds.o
  CC      drivers/hid/hid-topseed.o
  CC      drivers/gpu/drm/drm_vm.o
  CC      drivers/input/mousedev.o
  CC      net/mac80211/rx.o
  CC      net/netfilter/xt_SECMARK.o
  LD      drivers/hid/i2c-hid/built-in.o
  CC      drivers/hid/usbhid/hid-core.o
  LD      drivers/hid/hid.o
  LD      drivers/hid/hid-logitech.o
  CC      drivers/hid/usbhid/hid-quirks.o
  CC      net/sched/sch_fifo.o
  CC      net/sunrpc/auth.o
  CC      net/netfilter/xt_TCPMSS.o
  CC      drivers/hid/usbhid/hiddev.o
  CC      drivers/gpu/drm/drm_scatter.o
  CC      drivers/input/evdev.o
  CC      net/sched/ematch.o
  CC      drivers/gpu/drm/drm_pci.o
  CC      net/netfilter/xt_conntrack.o
  CC      drivers/hid/usbhid/hid-pidff.o
  CC      net/sunrpc/auth_null.o
  CC      net/sunrpc/auth_unix.o
  LD      drivers/input/joystick/built-in.o
  CC      drivers/input/keyboard/atkbd.o
  LD      net/sched/built-in.o
  CC      net/unix/af_unix.o
  CC      drivers/gpu/drm/drm_platform.o
  CC      net/sunrpc/auth_generic.o
  CC      net/netfilter/xt_policy.o
  CC      net/sunrpc/svc.o
  CC      drivers/gpu/drm/drm_sysfs.o
  LD      drivers/hid/usbhid/usbhid.o
  LD      drivers/hid/usbhid/built-in.o
  LD      drivers/hid/built-in.o
  CC      drivers/input/serio/serio.o
  CC      net/sunrpc/svcsock.o
  LD      drivers/input/keyboard/built-in.o
  LD      drivers/input/misc/built-in.o
  CC      net/netfilter/xt_state.o
  CC      drivers/input/mouse/psmouse-base.o
  CC      drivers/gpu/drm/drm_hashtab.o
  CC      drivers/input/serio/i8042.o
  LD      net/netfilter/netfilter.o
  LD      net/netfilter/nf_conntrack.o
  LD      net/netfilter/built-in.o
  CC      drivers/input/mouse/synaptics.o
  CC      net/mac80211/spectmgmt.o
  CC      net/sunrpc/svcauth.o
  CC      drivers/gpu/drm/drm_mm.o
  CC      drivers/input/mouse/focaltech.o
  CC      net/unix/garbage.o
  CC      net/sunrpc/svcauth_unix.o
  CC      net/sunrpc/addr.o
  CC      net/mac80211/tx.o
  CC      drivers/input/mouse/alps.o
  CC      drivers/input/mouse/logips2pp.o
  CC      drivers/input/serio/serport.o
  CC      drivers/gpu/drm/drm_crtc.o
  CC      net/unix/sysctl_net_unix.o
  CC      net/sunrpc/rpcb_clnt.o
  CC      drivers/input/mouse/lifebook.o
  CC      drivers/input/serio/libps2.o
  CC      net/sunrpc/timer.o
  CC      drivers/input/mouse/trackpoint.o
  CC      net/unix/scm.o
  LD      drivers/input/serio/built-in.o
  LD      drivers/iommu/built-in.o
  LD      drivers/irqchip/built-in.o
  CC      drivers/leds/led-core.o
  CC      net/sunrpc/xdr.o
  CC      net/sunrpc/sunrpc_syms.o
  CC      drivers/input/mouse/cypress_ps2.o
  CC      drivers/leds/led-class.o
  CC      drivers/leds/led-triggers.o
  LD      net/unix/unix.o
  LD      net/unix/built-in.o
  CC      net/wireless/core.o
  LD      drivers/leds/trigger/built-in.o
  CC      net/wireless/sysfs.o
  LD      drivers/leds/built-in.o
  LD      drivers/lguest/built-in.o
  CC      drivers/macintosh/mac_hid.o
  LD      drivers/input/mouse/psmouse.o
  CC      net/sunrpc/cache.o
  LD      drivers/input/mouse/built-in.o
  LD      drivers/input/tablet/built-in.o
  CC      drivers/input/touchscreen/of_touchscreen.o
  LD      drivers/macintosh/built-in.o
  CC      drivers/md/md.o
  CC      drivers/input/touchscreen/elants_i2c.o
  CC      net/sunrpc/rpc_pipe.o
  LD      drivers/input/touchscreen/built-in.o
  LD      drivers/input/input-core.o
  LD      drivers/input/built-in.o
  LD      drivers/media/common/b2c2/built-in.o
  LD      drivers/media/common/saa7146/built-in.o
  LD      drivers/media/common/siano/built-in.o
  LD      drivers/media/common/built-in.o
  LD      drivers/media/firewire/built-in.o
  LD      drivers/media/i2c/soc_camera/built-in.o
  LD      drivers/media/i2c/built-in.o
  LD      drivers/media/mmc/siano/built-in.o
  LD      drivers/media/mmc/built-in.o
  CC      drivers/gpu/drm/drm_modes.o
  LD      drivers/media/pci/b2c2/built-in.o
  LD      drivers/media/pci/ddbridge/built-in.o
  LD      drivers/media/pci/dm1105/built-in.o
  LD      drivers/media/pci/mantis/built-in.o
  LD      drivers/media/pci/netup_unidvb/built-in.o
  LD      drivers/media/pci/ngene/built-in.o
  CC      net/wireless/radiotap.o
  LD      drivers/media/pci/pluto2/built-in.o
  LD      drivers/media/pci/pt1/built-in.o
  LD      drivers/media/pci/pt3/built-in.o
  LD      drivers/media/pci/saa7146/built-in.o
  CC      net/mac80211/key.o
  LD      drivers/media/pci/smipcie/built-in.o
  LD      drivers/media/pci/ttpci/built-in.o
  LD      drivers/media/pci/built-in.o
  CC      net/wireless/util.o
  LD      drivers/media/platform/omap/built-in.o
  LD      drivers/media/platform/built-in.o
  LD      drivers/media/radio/built-in.o
  LD      drivers/media/rc/keymaps/built-in.o
  LD      drivers/media/rc/built-in.o
  LD      drivers/media/tuners/built-in.o
  LD      drivers/media/usb/b2c2/built-in.o
  LD      drivers/media/usb/dvb-usb/built-in.o
  LD      drivers/media/usb/dvb-usb-v2/built-in.o
  LD      drivers/media/usb/gspca/built-in.o
  LD      drivers/media/usb/s2255/built-in.o
  LD      drivers/media/usb/siano/built-in.o
  LD      drivers/media/usb/stkwebcam/built-in.o
  LD      drivers/media/usb/ttusb-budget/built-in.o
  LD      drivers/media/usb/ttusb-dec/built-in.o
  LD      drivers/media/usb/uvc/built-in.o
  LD      drivers/media/usb/zr364xx/built-in.o
  LD      drivers/media/usb/built-in.o
  CC      net/sunrpc/svc_xprt.o
  CC      drivers/media/v4l2-core/v4l2-dev.o
  CC      net/wireless/reg.o
  CC      net/wireless/scan.o
  CC      drivers/gpu/drm/drm_edid.o
  CC      drivers/media/v4l2-core/v4l2-ioctl.o
  CC      net/sunrpc/stats.o
  CC      net/mac80211/util.o
  CC      net/sunrpc/sysctl.o
  CC      net/wireless/nl80211.o
  CC      net/sunrpc/auth_gss/auth_gss.o
  CC      drivers/gpu/drm/drm_info.o
  CC      drivers/media/v4l2-core/v4l2-device.o
  CC      net/sunrpc/auth_gss/gss_generic_token.o
  CC      net/sunrpc/auth_gss/gss_mech_switch.o
  CC      net/sunrpc/auth_gss/svcauth_gss.o
  CC      drivers/media/v4l2-core/v4l2-fh.o
  CC      drivers/gpu/drm/drm_debugfs.o
  CC      drivers/media/v4l2-core/v4l2-event.o
  CC      net/sunrpc/auth_gss/gss_rpc_upcall.o
  CC      drivers/gpu/drm/drm_encoder_slave.o
  CC      drivers/media/v4l2-core/v4l2-ctrls.o
  CC      net/sunrpc/auth_gss/gss_rpc_xdr.o
  CC      drivers/gpu/drm/drm_trace_points.o
  CC      drivers/md/bitmap.o
  CC      drivers/gpu/drm/drm_global.o
  CC      drivers/gpu/drm/drm_prime.o
  CC      drivers/gpu/drm/drm_rect.o
  CC      drivers/gpu/drm/drm_vma_manager.o
  LD      net/sunrpc/auth_gss/auth_rpcgss.o
  LD      net/sunrpc/auth_gss/built-in.o
  LD      net/sunrpc/sunrpc.o
  LD      net/sunrpc/built-in.o
  CC      net/xfrm/xfrm_policy.o
  CC      drivers/gpu/drm/drm_flip_work.o
  CC      drivers/gpu/drm/drm_modeset_lock.o
  CC      net/mac80211/wme.o
  CC      drivers/gpu/drm/drm_atomic.o
  CC      drivers/gpu/drm/drm_bridge.o
  CC      drivers/md/dm.o
  CC      drivers/gpu/drm/ati_pcigart.o
  CC      net/mac80211/chan.o
  CC      drivers/media/v4l2-core/v4l2-subdev.o
  CC      drivers/gpu/drm/drm_panel.o
  CC      drivers/gpu/drm/drm_agpsupport.o
  CC      drivers/gpu/drm/drm_mipi_dsi.o
  CC      drivers/media/v4l2-core/v4l2-clk.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_drv.o
  CC      drivers/media/v4l2-core/v4l2-async.o
  LD      drivers/gpu/drm/bridge/built-in.o
  LD      drivers/gpu/drm/i2c/built-in.o
  CC      drivers/gpu/drm/i915/i915_drv.o
  LD      drivers/gpu/drm/panel/built-in.o
  LD      drivers/gpu/drm/tilcdc/built-in.o
  CC      drivers/gpu/drm/ttm/ttm_agp_backend.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_device.o
  CC      drivers/gpu/drm/ttm/ttm_memory.o
  CC      drivers/media/v4l2-core/vb2-trace.o
  CC      net/xfrm/xfrm_state.o
  CC      drivers/media/v4l2-core/v4l2-trace.o
  CC      drivers/gpu/drm/ttm/ttm_tt.o
  CC      drivers/md/dm-table.o
  CC      drivers/gpu/drm/i915/i915_irq.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_kms.o
  CC      net/mac80211/trace.o
  CC      drivers/media/v4l2-core/v4l2-common.o
  CC      drivers/gpu/drm/ttm/ttm_bo.o
  CC      drivers/media/v4l2-core/v4l2-dv-timings.o
  CC      drivers/md/dm-target.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.o
  LD      drivers/media/v4l2-core/videodev.o
  LD      drivers/media/v4l2-core/built-in.o
  LD      drivers/media/built-in.o
  CC      drivers/mfd/mfd-core.o
  CC      drivers/md/dm-linear.o
  CC      net/xfrm/xfrm_hash.o
  CC      net/xfrm/xfrm_input.o
  CC      drivers/gpu/drm/ttm/ttm_bo_util.o
  CC      drivers/mfd/intel-lpss.o
  CC      drivers/md/dm-stripe.o
  CC      drivers/gpu/drm/amd/amdgpu/atombios_crtc.o
  CC      drivers/mfd/intel-lpss-pci.o
  CC      drivers/gpu/drm/ttm/ttm_bo_vm.o
  LD      drivers/mfd/built-in.o
  LD      drivers/misc/cb710/built-in.o
  LD      drivers/misc/eeprom/built-in.o
  LD      drivers/misc/lis3lv02d/built-in.o
  CC      net/xfrm/xfrm_output.o
  LD      drivers/misc/mic/bus/built-in.o
  LD      drivers/misc/mic/built-in.o
  LD      drivers/misc/ti-st/built-in.o
  LD      drivers/misc/built-in.o
  CC      drivers/md/dm-ioctl.o
  CC      drivers/mmc/card/block.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.o
  CC      drivers/gpu/drm/ttm/ttm_module.o
  CC      drivers/gpu/drm/i915/i915_params.o
  CC      drivers/gpu/drm/ttm/ttm_object.o
  CC      net/xfrm/xfrm_sysctl.o
  CC      drivers/md/dm-io.o
  CC      drivers/gpu/drm/i915/i915_suspend.o
  CC      drivers/gpu/drm/ttm/ttm_lock.o
  CC      net/xfrm/xfrm_replay.o
  CC      drivers/gpu/drm/amd/amdgpu/atom.o
  CC      drivers/mmc/card/queue.o
  CC      drivers/md/dm-kcopyd.o
  CC      drivers/gpu/drm/ttm/ttm_execbuf_util.o
  CC      drivers/gpu/drm/i915/i915_sysfs.o
  CC      net/xfrm/xfrm_algo.o
  CC      net/wireless/mlme.o
  LD      drivers/mmc/card/mmc_block.o
  LD      drivers/mmc/card/built-in.o
  CC      drivers/mmc/core/core.o
  CC      drivers/gpu/drm/ttm/ttm_page_alloc.o
  CC      drivers/md/dm-sysfs.o
  CC      drivers/md/dm-stats.o
  CC      net/xfrm/xfrm_user.o
  CC      drivers/gpu/drm/ttm/ttm_bo_manager.o
  CC      drivers/gpu/drm/i915/intel_csr.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_fence.o
  CC      drivers/gpu/drm/ttm/ttm_page_alloc_dma.o
  LD      drivers/gpu/drm/ttm/ttm.o
  LD      drivers/gpu/drm/ttm/built-in.o
  CC      drivers/mmc/core/bus.o
  CC      drivers/mmc/core/host.o
  CC      net/mac80211/mlme.o
  CC      drivers/mmc/core/mmc.o
  CC      drivers/gpu/drm/i915/intel_pm.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.o
  CC      drivers/md/dm-builtin.o
  CC      drivers/mmc/core/mmc_ops.o
  CC      drivers/md/dm-raid1.o
  CC      net/wireless/ibss.o
  CC      drivers/mmc/core/sd.o
  LD      net/xfrm/built-in.o
  CC      net/sysctl_net.o
drivers/gpu/drm/i915/intel_pm.c: In function =E2=80=98snb_wm_latency_quirk=
=E2=80=99:
drivers/gpu/drm/i915/intel_pm.c:2256:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of =
size 10
[-Wstringop-overread]
 2256 |         intel_print_wm_latency(dev, "Primary",
dev_priv->wm.pri_latency);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
drivers/gpu/drm/i915/intel_pm.c:2256:9: note: referencing argument 3
of type =E2=80=98const uint16_t[8]=E2=80=99 {aka =E2=80=98const short unsig=
ned int[8]=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2194:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
 2194 | static void intel_print_wm_latency(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/intel_pm.c:2257:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of =
size 10
[-Wstringop-overread]
 2257 |         intel_print_wm_latency(dev, "Sprite", dev_priv->wm.spr_late=
ncy);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
drivers/gpu/drm/i915/intel_pm.c:2257:9: note: referencing argument 3
of type =E2=80=98const uint16_t[8]=E2=80=99 {aka =E2=80=98const short unsig=
ned int[8]=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2194:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
 2194 | static void intel_print_wm_latency(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/intel_pm.c:2258:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of =
size 10
[-Wstringop-overread]
 2258 |         intel_print_wm_latency(dev, "Cursor", dev_priv->wm.cur_late=
ncy);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
drivers/gpu/drm/i915/intel_pm.c:2258:9: note: referencing argument 3
of type =E2=80=98const uint16_t[8]=E2=80=99 {aka =E2=80=98const short unsig=
ned int[8]=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2194:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
 2194 | static void intel_print_wm_latency(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_object.o
drivers/gpu/drm/i915/intel_pm.c: In function =E2=80=98ilk_setup_wm_latency=
=E2=80=99:
drivers/gpu/drm/i915/intel_pm.c:2275:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of =
size 10
[-Wstringop-overread]
 2275 |         intel_print_wm_latency(dev, "Primary",
dev_priv->wm.pri_latency);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
drivers/gpu/drm/i915/intel_pm.c:2275:9: note: referencing argument 3
of type =E2=80=98const uint16_t[8]=E2=80=99 {aka =E2=80=98const short unsig=
ned int[8]=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2194:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
 2194 | static void intel_print_wm_latency(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/intel_pm.c:2276:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of =
size 10
[-Wstringop-overread]
 2276 |         intel_print_wm_latency(dev, "Sprite", dev_priv->wm.spr_late=
ncy);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
drivers/gpu/drm/i915/intel_pm.c:2276:9: note: referencing argument 3
of type =E2=80=98const uint16_t[8]=E2=80=99 {aka =E2=80=98const short unsig=
ned int[8]=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2194:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
 2194 | static void intel_print_wm_latency(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/intel_pm.c:2277:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of =
size 10
[-Wstringop-overread]
 2277 |         intel_print_wm_latency(dev, "Cursor", dev_priv->wm.cur_late=
ncy);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
drivers/gpu/drm/i915/intel_pm.c:2277:9: note: referencing argument 3
of type =E2=80=98const uint16_t[8]=E2=80=99 {aka =E2=80=98const short unsig=
ned int[8]=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2194:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
 2194 | static void intel_print_wm_latency(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
  CC      drivers/mmc/core/sd_ops.o
  CC      drivers/mmc/core/sdio.o
  CC      drivers/mmc/core/sdio_ops.o
  CC      drivers/mmc/core/sdio_bus.o
  CC      drivers/md/dm-log.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_gart.o
  CC      drivers/mmc/core/sdio_cis.o
  CC      drivers/mmc/core/sdio_io.o
  CC      net/wireless/sme.o
  CC      drivers/mmc/core/sdio_irq.o
  CC      drivers/md/dm-region-hash.o
  CC      drivers/mmc/core/quirks.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.o
  CC      drivers/gpu/drm/i915/intel_runtime_pm.o
  CC      drivers/mmc/core/slot-gpio.o
  CC      drivers/mmc/core/debugfs.o
  CC      drivers/gpu/drm/i915/i915_debugfs.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_display.o
  LD      drivers/mmc/core/mmc_core.o
  CC      drivers/md/dm-zero.o
  LD      drivers/mmc/core/built-in.o
  CC      drivers/mmc/host/sdhci.o
  LD      drivers/md/md-mod.o
  LD      drivers/md/dm-mod.o
  LD      drivers/md/dm-mirror.o
  LD      drivers/md/built-in.o
  CC      drivers/net/mii.o
drivers/gpu/drm/i915/intel_pm.c:2275:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of =
size 10
[-Wstringop-overread]
 2275 |         intel_print_wm_latency(dev, "Primary",
dev_priv->wm.pri_latency);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
drivers/gpu/drm/i915/intel_pm.c:2275:9: note: referencing argument 3
of type =E2=80=98const uint16_t[8]=E2=80=99 {aka =E2=80=98const short unsig=
ned int[8]=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2194:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
 2194 | static void intel_print_wm_latency(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/intel_pm.c:2276:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of =
size 10
[-Wstringop-overread]
 2276 |         intel_print_wm_latency(dev, "Sprite", dev_priv->wm.spr_late=
ncy);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
drivers/gpu/drm/i915/intel_pm.c:2276:9: note: referencing argument 3
of type =E2=80=98const uint16_t[8]=E2=80=99 {aka =E2=80=98const short unsig=
ned int[8]=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2194:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
 2194 | static void intel_print_wm_latency(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/intel_pm.c:2277:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of =
size 10
[-Wstringop-overread]
 2277 |         intel_print_wm_latency(dev, "Cursor", dev_priv->wm.cur_late=
ncy);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
drivers/gpu/drm/i915/intel_pm.c:2277:9: note: referencing argument 3
of type =E2=80=98const uint16_t[8]=E2=80=99 {aka =E2=80=98const short unsig=
ned int[8]=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2194:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
 2194 | static void intel_print_wm_latency(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
In function =E2=80=98snb_wm_latency_quirk=E2=80=99,
    inlined from =E2=80=98ilk_setup_wm_latency=E2=80=99 at
drivers/gpu/drm/i915/intel_pm.c:2280:3:
drivers/gpu/drm/i915/intel_pm.c:2256:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of =
size 10
[-Wstringop-overread]
 2256 |         intel_print_wm_latency(dev, "Primary",
dev_priv->wm.pri_latency);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
drivers/gpu/drm/i915/intel_pm.c:2256:9: note: referencing argument 3
of type =E2=80=98const uint16_t[8]=E2=80=99 {aka =E2=80=98const short unsig=
ned int[8]=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c: In function =E2=80=98ilk_setup_wm_latency=
=E2=80=99:
drivers/gpu/drm/i915/intel_pm.c:2194:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
 2194 | static void intel_print_wm_latency(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
In function =E2=80=98snb_wm_latency_quirk=E2=80=99,
    inlined from =E2=80=98ilk_setup_wm_latency=E2=80=99 at
drivers/gpu/drm/i915/intel_pm.c:2280:3:
drivers/gpu/drm/i915/intel_pm.c:2257:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of =
size 10
[-Wstringop-overread]
 2257 |         intel_print_wm_latency(dev, "Sprite", dev_priv->wm.spr_late=
ncy);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
drivers/gpu/drm/i915/intel_pm.c:2257:9: note: referencing argument 3
of type =E2=80=98const uint16_t[8]=E2=80=99 {aka =E2=80=98const short unsig=
ned int[8]=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c: In function =E2=80=98ilk_setup_wm_latency=
=E2=80=99:
drivers/gpu/drm/i915/intel_pm.c:2194:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
 2194 | static void intel_print_wm_latency(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
In function =E2=80=98snb_wm_latency_quirk=E2=80=99,
    inlined from =E2=80=98ilk_setup_wm_latency=E2=80=99 at
drivers/gpu/drm/i915/intel_pm.c:2280:3:
drivers/gpu/drm/i915/intel_pm.c:2258:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of =
size 10
[-Wstringop-overread]
 2258 |         intel_print_wm_latency(dev, "Cursor", dev_priv->wm.cur_late=
ncy);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
drivers/gpu/drm/i915/intel_pm.c:2258:9: note: referencing argument 3
of type =E2=80=98const uint16_t[8]=E2=80=99 {aka =E2=80=98const short unsig=
ned int[8]=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c: In function =E2=80=98ilk_setup_wm_latency=
=E2=80=99:
drivers/gpu/drm/i915/intel_pm.c:2194:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
 2194 | static void intel_print_wm_latency(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
  CC      drivers/gpu/drm/i915/i915_cmd_parser.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.o
drivers/gpu/drm/i915/intel_pm.c:2275:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of =
size 10
[-Wstringop-overread]
 2275 |         intel_print_wm_latency(dev, "Primary",
dev_priv->wm.pri_latency);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
drivers/gpu/drm/i915/intel_pm.c:2275:9: note: referencing argument 3
of type =E2=80=98const uint16_t[8]=E2=80=99 {aka =E2=80=98const short unsig=
ned int[8]=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2194:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
 2194 | static void intel_print_wm_latency(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/intel_pm.c:2276:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of =
size 10
[-Wstringop-overread]
 2276 |         intel_print_wm_latency(dev, "Sprite", dev_priv->wm.spr_late=
ncy);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
drivers/gpu/drm/i915/intel_pm.c:2276:9: note: referencing argument 3
of type =E2=80=98const uint16_t[8]=E2=80=99 {aka =E2=80=98const short unsig=
ned int[8]=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2194:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
 2194 | static void intel_print_wm_latency(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/intel_pm.c:2277:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of =
size 10
[-Wstringop-overread]
 2277 |         intel_print_wm_latency(dev, "Cursor", dev_priv->wm.cur_late=
ncy);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
drivers/gpu/drm/i915/intel_pm.c:2277:9: note: referencing argument 3
of type =E2=80=98const uint16_t[8]=E2=80=99 {aka =E2=80=98const short unsig=
ned int[8]=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2194:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
 2194 | static void intel_print_wm_latency(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
In function =E2=80=98snb_wm_latency_quirk=E2=80=99,
    inlined from =E2=80=98ilk_setup_wm_latency=E2=80=99 at
drivers/gpu/drm/i915/intel_pm.c:2280:3:
drivers/gpu/drm/i915/intel_pm.c:2256:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of =
size 10
[-Wstringop-overread]
 2256 |         intel_print_wm_latency(dev, "Primary",
dev_priv->wm.pri_latency);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
drivers/gpu/drm/i915/intel_pm.c:2256:9: note: referencing argument 3
of type =E2=80=98const uint16_t[8]=E2=80=99 {aka =E2=80=98const short unsig=
ned int[8]=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c: In function =E2=80=98ilk_setup_wm_latency=
=E2=80=99:
drivers/gpu/drm/i915/intel_pm.c:2194:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
 2194 | static void intel_print_wm_latency(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
In function =E2=80=98snb_wm_latency_quirk=E2=80=99,
    inlined from =E2=80=98ilk_setup_wm_latency=E2=80=99 at
drivers/gpu/drm/i915/intel_pm.c:2280:3:
drivers/gpu/drm/i915/intel_pm.c:2257:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of =
size 10
[-Wstringop-overread]
 2257 |         intel_print_wm_latency(dev, "Sprite", dev_priv->wm.spr_late=
ncy);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
drivers/gpu/drm/i915/intel_pm.c:2257:9: note: referencing argument 3
of type =E2=80=98const uint16_t[8]=E2=80=99 {aka =E2=80=98const short unsig=
ned int[8]=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c: In function =E2=80=98ilk_setup_wm_latency=
=E2=80=99:
drivers/gpu/drm/i915/intel_pm.c:2194:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
 2194 | static void intel_print_wm_latency(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
In function =E2=80=98snb_wm_latency_quirk=E2=80=99,
    inlined from =E2=80=98ilk_setup_wm_latency=E2=80=99 at
drivers/gpu/drm/i915/intel_pm.c:2280:3:
drivers/gpu/drm/i915/intel_pm.c:2258:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of =
size 10
[-Wstringop-overread]
 2258 |         intel_print_wm_latency(dev, "Cursor", dev_priv->wm.cur_late=
ncy);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
drivers/gpu/drm/i915/intel_pm.c:2258:9: note: referencing argument 3
of type =E2=80=98const uint16_t[8]=E2=80=99 {aka =E2=80=98const short unsig=
ned int[8]=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c: In function =E2=80=98ilk_setup_wm_latency=
=E2=80=99:
drivers/gpu/drm/i915/intel_pm.c:2194:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
 2194 | static void intel_print_wm_latency(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
  CC      net/mac80211/tdls.o
  CC      net/wireless/chan.o
  CC      drivers/net/Space.o
  CC      drivers/net/loopback.o
  CC      drivers/net/netconsole.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_fb.o
  CC      drivers/mmc/host/sdhci-pci-core.o
  CC      drivers/gpu/drm/i915/i915_gem_batch_pool.o
  LD      drivers/net/ethernet/3com/built-in.o
  CC      drivers/net/ethernet/8390/ne2k-pci.o
  LD      drivers/net/fddi/built-in.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_gem.o
  CC      drivers/net/ethernet/8390/8390.o
  CC      net/wireless/ethtool.o
  CC      drivers/mmc/host/sdhci-pci-o2micro.o
  CC      drivers/gpu/drm/i915/i915_gem_context.o
  CC      drivers/gpu/drm/i915/i915_gem_debug.o
  LD      drivers/net/ethernet/8390/built-in.o
  LD      drivers/net/ethernet/adaptec/built-in.o
  LD      drivers/net/ethernet/agere/built-in.o
  LD      drivers/net/ethernet/alteon/built-in.o
  LD      drivers/net/ethernet/amd/built-in.o
  LD      drivers/net/ethernet/arc/built-in.o
  LD      drivers/net/ethernet/atheros/built-in.o
  CC      drivers/net/ethernet/broadcom/bnx2.o
  CC      net/mac80211/ocb.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ring.o
  CC      drivers/mmc/host/sdhci-pci-data.o
  CC      drivers/mmc/host/sdhci-acpi.o
  CC      drivers/net/ethernet/broadcom/tg3.o
  CC      drivers/gpu/drm/i915/i915_gem_dmabuf.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_cs.o
  LD      drivers/mmc/host/sdhci-pci.o
  LD      drivers/mmc/host/built-in.o
  LD      drivers/mmc/built-in.o
  LD      drivers/nfc/built-in.o
  CC      net/wireless/mesh.o
  LD      drivers/nvme/host/built-in.o
  LD      drivers/nvme/built-in.o
  CC      drivers/pci/access.o
  CC      net/wireless/ap.o
  CC      net/mac80211/led.o
  CC      drivers/gpu/drm/i915/i915_gem_evict.o
  CC      drivers/pci/bus.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_bios.o
  CC      net/mac80211/pm.o
  CC      drivers/pci/probe.o
  CC      drivers/gpu/drm/i915/i915_gem_execbuffer.o
  CC      net/wireless/trace.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.o
  CC      net/wireless/ocb.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_test.o
  CC      net/mac80211/rc80211_minstrel.o
  CC      drivers/pci/host-bridge.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_pm.o
  CC      drivers/pci/remove.o
  CC      drivers/gpu/drm/i915/i915_gem_fence.o
  CC      drivers/gpu/drm/i915/i915_gem_gtt.o
  CC      drivers/pci/pci.o
  CC      drivers/pci/pci-driver.o
  CC      drivers/gpu/drm/amd/amdgpu/atombios_dp.o
  CC      net/mac80211/rc80211_minstrel_ht.o
  CC      drivers/gpu/drm/i915/i915_gem.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.o
  CC      drivers/pci/search.o
drivers/gpu/drm/i915/i915_gem.c: In function =E2=80=98i915_gem_pread_ioctl=
=E2=80=99:
drivers/gpu/drm/i915/i915_gem.c:704:24: warning: the comparison will
always evaluate as =E2=80=98false=E2=80=99 for the address of =E2=80=98base=
=E2=80=99 will never be
NULL [-Waddress]
  704 |         if (&obj->base =3D=3D NULL) {
      |                        ^~
In file included from drivers/gpu/drm/i915/i915_gem.c:31:
drivers/gpu/drm/i915/i915_drv.h:2047:31: note: =E2=80=98base=E2=80=99 decla=
red here
 2047 |         struct drm_gem_object base;
      |                               ^~~~
drivers/gpu/drm/i915/i915_gem.c: In function =E2=80=98i915_gem_pwrite_ioctl=
=E2=80=99:
drivers/gpu/drm/i915/i915_gem.c:1057:24: warning: the comparison will
always evaluate as =E2=80=98false=E2=80=99 for the address of =E2=80=98base=
=E2=80=99 will never be
NULL [-Waddress]
 1057 |         if (&obj->base =3D=3D NULL) {
      |                        ^~
drivers/gpu/drm/i915/i915_drv.h:2047:31: note: =E2=80=98base=E2=80=99 decla=
red here
 2047 |         struct drm_gem_object base;
      |                               ^~~~
drivers/gpu/drm/i915/i915_gem.c: In function =E2=80=98i915_gem_set_domain_i=
octl=E2=80=99:
drivers/gpu/drm/i915/i915_gem.c:1642:24: warning: the comparison will
always evaluate as =E2=80=98false=E2=80=99 for the address of =E2=80=98base=
=E2=80=99 will never be
NULL [-Waddress]
 1642 |         if (&obj->base =3D=3D NULL) {
      |                        ^~
drivers/gpu/drm/i915/i915_drv.h:2047:31: note: =E2=80=98base=E2=80=99 decla=
red here
 2047 |         struct drm_gem_object base;
      |                               ^~~~
drivers/gpu/drm/i915/i915_gem.c: In function =E2=80=98i915_gem_sw_finish_io=
ctl=E2=80=99:
drivers/gpu/drm/i915/i915_gem.c:1690:24: warning: the comparison will
always evaluate as =E2=80=98false=E2=80=99 for the address of =E2=80=98base=
=E2=80=99 will never be
NULL [-Waddress]
 1690 |         if (&obj->base =3D=3D NULL) {
      |                        ^~
drivers/gpu/drm/i915/i915_drv.h:2047:31: note: =E2=80=98base=E2=80=99 decla=
red here
 2047 |         struct drm_gem_object base;
      |                               ^~~~
drivers/gpu/drm/i915/i915_gem.c: In function =E2=80=98i915_gem_mmap_gtt=E2=
=80=99:
drivers/gpu/drm/i915/i915_gem.c:2086:24: warning: the comparison will
always evaluate as =E2=80=98false=E2=80=99 for the address of =E2=80=98base=
=E2=80=99 will never be
NULL [-Waddress]
 2086 |         if (&obj->base =3D=3D NULL) {
      |                        ^~
drivers/gpu/drm/i915/i915_drv.h:2047:31: note: =E2=80=98base=E2=80=99 decla=
red here
 2047 |         struct drm_gem_object base;
      |                               ^~~~
drivers/gpu/drm/i915/i915_gem.c: In function =E2=80=98i915_gem_wait_ioctl=
=E2=80=99:
drivers/gpu/drm/i915/i915_gem.c:3159:24: warning: the comparison will
always evaluate as =E2=80=98false=E2=80=99 for the address of =E2=80=98base=
=E2=80=99 will never be
NULL [-Waddress]
 3159 |         if (&obj->base =3D=3D NULL) {
      |                        ^~
drivers/gpu/drm/i915/i915_drv.h:2047:31: note: =E2=80=98base=E2=80=99 decla=
red here
 2047 |         struct drm_gem_object base;
      |                               ^~~~
drivers/gpu/drm/i915/i915_gem.c: In function =E2=80=98i915_gem_get_caching_=
ioctl=E2=80=99:
drivers/gpu/drm/i915/i915_gem.c:3934:24: warning: the comparison will
always evaluate as =E2=80=98false=E2=80=99 for the address of =E2=80=98base=
=E2=80=99 will never be
NULL [-Waddress]
 3934 |         if (&obj->base =3D=3D NULL)
      |                        ^~
drivers/gpu/drm/i915/i915_drv.h:2047:31: note: =E2=80=98base=E2=80=99 decla=
red here
 2047 |         struct drm_gem_object base;
      |                               ^~~~
drivers/gpu/drm/i915/i915_gem.c: In function =E2=80=98i915_gem_set_caching_=
ioctl=E2=80=99:
drivers/gpu/drm/i915/i915_gem.c:3995:24: warning: the comparison will
always evaluate as =E2=80=98false=E2=80=99 for the address of =E2=80=98base=
=E2=80=99 will never be
NULL [-Waddress]
 3995 |         if (&obj->base =3D=3D NULL) {
      |                        ^~
drivers/gpu/drm/i915/i915_drv.h:2047:31: note: =E2=80=98base=E2=80=99 decla=
red here
 2047 |         struct drm_gem_object base;
      |                               ^~~~
drivers/gpu/drm/i915/i915_gem.c: In function =E2=80=98i915_gem_busy_ioctl=
=E2=80=99:
drivers/gpu/drm/i915/i915_gem.c:4370:24: warning: the comparison will
always evaluate as =E2=80=98false=E2=80=99 for the address of =E2=80=98base=
=E2=80=99 will never be
NULL [-Waddress]
 4370 |         if (&obj->base =3D=3D NULL) {
      |                        ^~
drivers/gpu/drm/i915/i915_drv.h:2047:31: note: =E2=80=98base=E2=80=99 decla=
red here
 2047 |         struct drm_gem_object base;
      |                               ^~~~
drivers/gpu/drm/i915/i915_gem.c: In function =E2=80=98i915_gem_madvise_ioct=
l=E2=80=99:
drivers/gpu/drm/i915/i915_gem.c:4425:24: warning: the comparison will
always evaluate as =E2=80=98false=E2=80=99 for the address of =E2=80=98base=
=E2=80=99 will never be
NULL [-Waddress]
 4425 |         if (&obj->base =3D=3D NULL) {
      |                        ^~
drivers/gpu/drm/i915/i915_drv.h:2047:31: note: =E2=80=98base=E2=80=99 decla=
red here
 2047 |         struct drm_gem_object base;
      |                               ^~~~
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.o
  CC      drivers/pci/pci-sysfs.o
  CC      drivers/pci/rom.o
  LD      net/mac80211/mac80211.o
  CC      drivers/pci/setup-res.o
  LD      net/mac80211/built-in.o
  CC      drivers/pci/irq.o
  CC      drivers/pci/vpd.o
  CC      drivers/gpu/drm/amd/amdgpu/atombios_encoders.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_semaphore.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_sa.o
  CC      drivers/pci/setup-bus.o
  LD      drivers/net/hamradio/built-in.o
  CC      drivers/net/phy/phy.o
  CC      drivers/gpu/drm/amd/amdgpu/atombios_i2c.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_prime.o
  CC      drivers/net/phy/phy_device.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_vm.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ib.o
  CC      drivers/pci/vc.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_pll.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.o
  CC      drivers/gpu/drm/i915/i915_gem_render_state.o
  CC      drivers/pci/proc.o
  CC      drivers/net/phy/mdio_bus.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.o
  CC      drivers/pci/slot.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.o
  CC      drivers/gpu/drm/i915/i915_gem_shrinker.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_sync.o
  LD      drivers/net/phy/libphy.o
  LD      drivers/net/phy/built-in.o
  CC      drivers/net/usb/r8152.o
  CC      drivers/gpu/drm/amd/amdgpu/vi.o
  LD      drivers/net/ethernet/broadcom/built-in.o
  CC      drivers/pci/quirks.o
  LD      drivers/net/ethernet/brocade/built-in.o
  LD      drivers/net/ethernet/cadence/built-in.o
  LD      drivers/net/ethernet/cavium/liquidio/built-in.o
  LD      drivers/net/ethernet/cavium/thunder/built-in.o
  LD      drivers/net/ethernet/cavium/built-in.o
  LD      drivers/net/ethernet/chelsio/built-in.o
  LD      drivers/net/ethernet/cisco/built-in.o
  LD      drivers/net/ethernet/dec/tulip/built-in.o
  LD      drivers/net/ethernet/dec/built-in.o
  LD      drivers/net/ethernet/dlink/built-in.o
  LD      drivers/net/ethernet/emulex/built-in.o
  LD      drivers/net/ethernet/ezchip/built-in.o
  LD      drivers/net/ethernet/fujitsu/built-in.o
  LD      drivers/net/ethernet/hp/built-in.o
  LD      drivers/net/ethernet/i825xx/built-in.o
  CC      drivers/net/ethernet/intel/e100.o
  LD      drivers/pci/host/built-in.o
  CC      drivers/pci/hotplug/pci_hotplug_core.o
  LD      net/wireless/cfg80211.o
  LD      net/wireless/built-in.o
  LD      net/built-in.o
  CC      drivers/net/ethernet/intel/e1000/e1000_main.o
  CC      drivers/gpu/drm/i915/i915_gem_stolen.o
  CC      drivers/net/ethernet/intel/e1000/e1000_hw.o
  CC      drivers/pci/hotplug/acpi_pcihp.o
  CC      drivers/gpu/drm/amd/amdgpu/gmc_v7_0.o
  LD      drivers/pci/hotplug/pci_hotplug.o
  LD      drivers/pci/hotplug/built-in.o
  CC      drivers/pci/pcie/aspm.o
  CC      drivers/pci/hotplug-pci.o
  CC      drivers/gpu/drm/i915/i915_gem_tiling.o
  CC      drivers/gpu/drm/amd/amdgpu/gmc_v8_0.o
  CC      drivers/pci/msi.o
  CC      drivers/net/ethernet/intel/e1000e/82571.o
  CC      drivers/pci/pcie/portdrv_core.o
drivers/gpu/drm/i915/i915_gem_tiling.c: In function =E2=80=98i915_gem_set_t=
iling=E2=80=99:
drivers/gpu/drm/i915/i915_gem_tiling.c:170:24: warning: the comparison
will always evaluate as =E2=80=98false=E2=80=99 for the address of =E2=80=
=98base=E2=80=99 will never
be NULL [-Waddress]
  170 |         if (&obj->base =3D=3D NULL)
      |                        ^~
In file included from drivers/gpu/drm/i915/i915_gem_tiling.c:32:
drivers/gpu/drm/i915/i915_drv.h:2047:31: note: =E2=80=98base=E2=80=99 decla=
red here
 2047 |         struct drm_gem_object base;
      |                               ^~~~
drivers/gpu/drm/i915/i915_gem_tiling.c: In function =E2=80=98i915_gem_get_t=
iling=E2=80=99:
drivers/gpu/drm/i915/i915_gem_tiling.c:297:24: warning: the comparison
will always evaluate as =E2=80=98false=E2=80=99 for the address of =E2=80=
=98base=E2=80=99 will never
be NULL [-Waddress]
  297 |         if (&obj->base =3D=3D NULL)
      |                        ^~
drivers/gpu/drm/i915/i915_drv.h:2047:31: note: =E2=80=98base=E2=80=99 decla=
red here
 2047 |         struct drm_gem_object base;
      |                               ^~~~
  CC      drivers/net/usb/asix_devices.o
  CC      drivers/pci/pcie/portdrv_pci.o
  CC      drivers/gpu/drm/i915/i915_gem_userptr.o
  CC      drivers/net/ethernet/intel/e1000e/ich8lan.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_irq.o
  CC      drivers/pci/htirq.o
  CC      drivers/net/ethernet/intel/e1000e/80003es2lan.o
  CC      drivers/pci/pcie/portdrv_bus.o
  CC      drivers/pci/pci-acpi.o
  CC      drivers/net/usb/asix_common.o
  CC      drivers/pci/pcie/portdrv_acpi.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ih.o
  CC      drivers/gpu/drm/i915/i915_gpu_error.o
  CC      drivers/net/ethernet/intel/e1000/e1000_ethtool.o
  CC      drivers/net/ethernet/intel/e1000e/mac.o
  CC      drivers/pci/pcie/aer/aerdrv_errprint.o
  CC      drivers/pci/pci-label.o
  CC      drivers/gpu/drm/amd/amdgpu/iceland_ih.o
  CC      drivers/net/usb/ax88172a.o
  CC      drivers/pci/pcie/aer/aerdrv_core.o
  CC      drivers/pci/pcie/aer/aerdrv.o
  CC      drivers/net/ethernet/intel/e1000e/manage.o
  CC      drivers/net/ethernet/intel/e1000e/nvm.o
  CC      drivers/gpu/drm/amd/amdgpu/tonga_ih.o
  CC      drivers/net/usb/ax88179_178a.o
  CC      drivers/gpu/drm/amd/amdgpu/cz_ih.o
  CC      drivers/pci/pcie/aer/aerdrv_acpi.o
  CC      drivers/net/ethernet/intel/e1000/e1000_param.o
  CC      drivers/net/ethernet/intel/e1000e/phy.o
  CC      drivers/gpu/drm/i915/i915_trace_points.o
  CC      drivers/net/ethernet/intel/e1000e/param.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.o
  LD      drivers/pci/pcie/aer/aerdriver.o
  LD      drivers/pci/pcie/aer/built-in.o
  CC      drivers/pci/pcie/pme.o
  CC      drivers/gpu/drm/amd/amdgpu/cz_smc.o
  CC      drivers/net/usb/cdc_ether.o
  LD      drivers/net/ethernet/intel/e1000/e1000.o
  LD      drivers/pci/pcie/pcieportdrv.o
  LD      drivers/net/ethernet/intel/e1000/built-in.o
  LD      drivers/pci/pcie/built-in.o
  CC      drivers/net/usb/net1080.o
  LD      drivers/pci/built-in.o
  CC      drivers/net/ethernet/intel/e1000e/ethtool.o
  CC      drivers/pcmcia/cs.o
  CC      drivers/gpu/drm/amd/amdgpu/cz_dpm.o
  CC      drivers/gpu/drm/amd/amdgpu/tonga_smc.o
  CC      drivers/net/usb/cdc_subset.o
  CC      drivers/net/ethernet/intel/e1000e/netdev.o
  CC      drivers/net/usb/zaurus.o
  CC      drivers/pcmcia/socket_sysfs.o
  CC      drivers/net/usb/usbnet.o
  CC      drivers/net/usb/cdc_ncm.o
  CC      drivers/pcmcia/cardbus.o
  CC      drivers/gpu/drm/amd/amdgpu/tonga_dpm.o
  CC      drivers/net/ethernet/intel/e1000e/ptp.o
  CC      drivers/pcmcia/ds.o
  CC      drivers/gpu/drm/i915/intel_lrc.o
  CC      drivers/gpu/drm/amd/amdgpu/fiji_smc.o
  CC      drivers/gpu/drm/amd/amdgpu/fiji_dpm.o
  CC      drivers/gpu/drm/amd/amdgpu/iceland_smc.o
  CC      drivers/gpu/drm/amd/amdgpu/iceland_dpm.o
  CC      drivers/gpu/drm/amd/amdgpu/dce_v10_0.o
  CC      drivers/gpu/drm/amd/amdgpu/dce_v11_0.o
  LD      drivers/net/usb/asix.o
  LD      drivers/net/usb/built-in.o
  LD      drivers/net/wireless/iwlwifi/built-in.o
  LD      drivers/net/wireless/iwlwifi/dvm/built-in.o
  LD      drivers/net/wireless/iwlwifi/mvm/built-in.o
  CC      drivers/pcmcia/pcmcia_resource.o
  LD      drivers/net/wireless/realtek/built-in.o
  LD      drivers/net/wireless/built-in.o
  CC      drivers/pcmcia/cistpl.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.o
  CC      drivers/gpu/drm/amd/amdgpu/gfx_v8_0.o
  CC      drivers/gpu/drm/amd/amdgpu/sdma_v2_4.o
  CC      drivers/pcmcia/pcmcia_cis.o
  CC      drivers/gpu/drm/i915/intel_mocs.o
  CC      drivers/pcmcia/rsrc_mgr.o
  CC      drivers/pcmcia/rsrc_nonstatic.o
  CC      drivers/pcmcia/yenta_socket.o
  CC      drivers/gpu/drm/amd/amdgpu/sdma_v3_0.o
  CC      drivers/gpu/drm/i915/intel_ringbuffer.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.o
  CC      drivers/gpu/drm/amd/amdgpu/uvd_v5_0.o
  LD      drivers/net/ethernet/intel/e1000e/e1000e.o
  LD      drivers/net/ethernet/intel/e1000e/built-in.o
  CC      drivers/net/ethernet/intel/igb/igb_main.o
  CC      drivers/net/ethernet/intel/igb/igb_ethtool.o
  CC      drivers/gpu/drm/amd/amdgpu/uvd_v6_0.o
  LD      drivers/pcmcia/pcmcia_core.o
  LD      drivers/pcmcia/pcmcia.o
  LD      drivers/pcmcia/pcmcia_rsrc.o
  LD      drivers/pcmcia/built-in.o
  LD      drivers/perf/built-in.o
  CC      drivers/pinctrl/core.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_vce.o
  CC      drivers/gpu/drm/amd/amdgpu/vce_v3_0.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.o
  CC      drivers/gpu/drm/amd/amdgpu/../scheduler/gpu_scheduler.o
  CC      drivers/pinctrl/pinctrl-utils.o
  CC      drivers/gpu/drm/amd/amdgpu/../scheduler/sched_fence.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_sched.o
  CC      drivers/pinctrl/pinmux.o
  CC      drivers/net/ethernet/intel/igb/e1000_82575.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.o
  CC      drivers/gpu/drm/i915/intel_uncore.o
  CC      drivers/net/ethernet/marvell/sky2.o
  CC      drivers/pinctrl/pinconf.o
  CC      drivers/pinctrl/pinconf-generic.o
  CC      drivers/pinctrl/pinctrl-amd.o
  LD      drivers/net/ethernet/mellanox/built-in.o
  LD      drivers/net/ethernet/mellanox/mlx4/built-in.o
  LD      drivers/net/ethernet/mellanox/mlx5/core/built-in.o
  LD      drivers/net/ethernet/micrel/built-in.o
  LD      drivers/net/ethernet/microchip/built-in.o
  LD      drivers/net/ethernet/myricom/built-in.o
  LD      drivers/net/ethernet/natsemi/built-in.o
  LD      drivers/net/ethernet/neterion/built-in.o
  CC      drivers/net/ethernet/nvidia/forcedeth.o
  LD      drivers/gpu/drm/amd/amdgpu/amdgpu.o
  LD      drivers/pinctrl/freescale/built-in.o
  CC      drivers/pinctrl/intel/pinctrl-baytrail.o
  LD      drivers/gpu/drm/amd/amdgpu/built-in.o
  LD      drivers/gpu/drm/drm_kms_helper.o
  LD      drivers/gpu/drm/drm.o
  LD      drivers/pinctrl/nomadik/built-in.o
  LD      drivers/net/ethernet/oki-semi/built-in.o
  LD      drivers/net/ethernet/packetengines/built-in.o
  LD      drivers/net/ethernet/qlogic/built-in.o
  LD      drivers/net/ethernet/qualcomm/built-in.o
  LD      drivers/net/ethernet/rdc/built-in.o
  CC      drivers/net/ethernet/realtek/8139too.o
  LD      drivers/net/ethernet/renesas/built-in.o
  LD      drivers/net/ethernet/rocker/built-in.o
  LD      drivers/net/ethernet/samsung/built-in.o
  CC      drivers/net/ethernet/intel/igb/e1000_mac.o
  LD      drivers/net/ethernet/seeq/built-in.o
  LD      drivers/net/ethernet/silan/built-in.o
  LD      drivers/net/ethernet/sis/built-in.o
  LD      drivers/net/ethernet/smsc/built-in.o
  LD      drivers/net/ethernet/stmicro/built-in.o
  LD      drivers/net/ethernet/sun/built-in.o
  LD      drivers/net/ethernet/synopsys/built-in.o
  LD      drivers/net/ethernet/tehuti/built-in.o
  LD      drivers/net/ethernet/ti/built-in.o
  LD      drivers/net/ethernet/via/built-in.o
  LD      drivers/net/ethernet/wiznet/built-in.o
  LD      drivers/net/ethernet/xircom/built-in.o
  CC      drivers/net/ethernet/intel/igb/e1000_nvm.o
  LD      drivers/pinctrl/intel/built-in.o
  LD      drivers/pinctrl/built-in.o
  CC      drivers/platform/chrome/chromeos_laptop.o
  CC      drivers/net/ethernet/intel/igb/e1000_phy.o
  LD      drivers/platform/chrome/built-in.o
  CC      drivers/platform/x86/eeepc-laptop.o
  CC      drivers/net/ethernet/intel/igb/e1000_mbx.o
  CC      drivers/net/ethernet/intel/igb/e1000_i210.o
  CC      drivers/net/ethernet/realtek/r8169.o
  CC      drivers/net/ethernet/intel/igb/igb_ptp.o
  CC      drivers/net/ethernet/intel/igb/igb_hwmon.o
  LD      drivers/platform/x86/built-in.o
  LD      drivers/platform/built-in.o
  CC      drivers/gpu/drm/i915/intel_guc_loader.o
  CC      drivers/pnp/core.o
  CC      drivers/pnp/card.o
  CC      drivers/pnp/driver.o
  CC      drivers/pnp/resource.o
  LD      drivers/net/ethernet/marvell/built-in.o
  CC      drivers/pnp/manager.o
  LD      drivers/net/ethernet/intel/igb/igb.o
  CC      drivers/pnp/support.o
  LD      drivers/net/ethernet/intel/igb/built-in.o
  LD      drivers/net/ethernet/intel/built-in.o
  CC      drivers/pnp/interface.o
  CC      drivers/pnp/quirks.o
  CC      drivers/gpu/drm/i915/i915_guc_submission.o
  CC      drivers/pnp/system.o
  CC      drivers/pnp/pnpacpi/core.o
  CC      drivers/pnp/pnpacpi/rsparser.o
  LD      drivers/net/ethernet/nvidia/built-in.o
  CC      drivers/gpu/drm/i915/intel_renderstate_gen6.o
  CC      drivers/gpu/drm/i915/intel_renderstate_gen7.o
  CC      drivers/gpu/drm/i915/intel_renderstate_gen8.o
  CC      drivers/gpu/drm/i915/intel_renderstate_gen9.o
  CC      drivers/gpu/drm/i915/intel_audio.o
  LD      drivers/pnp/pnpacpi/pnp.o
  LD      drivers/pnp/pnpacpi/built-in.o
  LD      drivers/pnp/pnp.o
  LD      drivers/pnp/built-in.o
  CC      drivers/gpu/drm/i915/intel_atomic.o
  CC      drivers/gpu/drm/i915/intel_atomic_plane.o
  CC      drivers/power/power_supply_core.o
  CC      drivers/gpu/drm/i915/intel_bios.o
  CC      drivers/gpu/drm/i915/intel_display.o
  CC      drivers/gpu/drm/i915/intel_fbc.o
  CC      drivers/power/power_supply_sysfs.o
  CC      drivers/gpu/drm/i915/intel_fifo_underrun.o
  CC      drivers/gpu/drm/i915/intel_frontbuffer.o
  CC      drivers/gpu/drm/i915/intel_hotplug.o
  CC      drivers/power/power_supply_leds.o
  LD      drivers/power/power_supply.o
  LD      drivers/power/built-in.o
  CC      drivers/pps/pps.o
  LD      drivers/net/ethernet/realtek/built-in.o
  LD      drivers/net/ethernet/built-in.o
  CC      drivers/gpu/drm/i915/intel_modes.o
  LD      drivers/net/built-in.o
  CC      drivers/gpu/drm/i915/intel_overlay.o
drivers/gpu/drm/i915/intel_display.c: In function
=E2=80=98intel_user_framebuffer_create=E2=80=99:
drivers/gpu/drm/i915/intel_display.c:14510:24: warning: the comparison
will always evaluate as =E2=80=98false=E2=80=99 for the address of =E2=80=
=98base=E2=80=99 will never
be NULL [-Waddress]
14510 |         if (&obj->base =3D=3D NULL)
      |                        ^~
In file included from drivers/gpu/drm/i915/intel_drv.h:32,
                 from drivers/gpu/drm/i915/intel_display.c:36:
drivers/gpu/drm/i915/i915_drv.h:2047:31: note: =E2=80=98base=E2=80=99 decla=
red here
 2047 |         struct drm_gem_object base;
      |                               ^~~~
  CC      drivers/ptp/ptp_clock.o
  CC      drivers/gpu/drm/i915/intel_psr.o
  CC      drivers/gpu/drm/i915/intel_sideband.o
  CC      drivers/pps/kapi.o
  CC      drivers/pps/sysfs.o
  CC      drivers/ptp/ptp_chardev.o
  LD      drivers/pwm/built-in.o
  CC      drivers/gpu/drm/i915/intel_sprite.o
  LD      drivers/pps/clients/built-in.o
  LD      drivers/pps/generators/built-in.o
  LD      drivers/pps/pps_core.o
drivers/gpu/drm/i915/intel_overlay.c: In function =E2=80=98intel_overlay_pu=
t_image=E2=80=99:
drivers/gpu/drm/i915/intel_overlay.c:1129:27: warning: the comparison
will always evaluate as =E2=80=98false=E2=80=99 for the address of =E2=80=
=98base=E2=80=99 will never
be NULL [-Waddress]
 1129 |         if (&new_bo->base =3D=3D NULL) {
      |                           ^~
In file included from drivers/gpu/drm/i915/intel_overlay.c:30:
drivers/gpu/drm/i915/i915_drv.h:2047:31: note: =E2=80=98base=E2=80=99 decla=
red here
 2047 |         struct drm_gem_object base;
      |                               ^~~~
  LD      drivers/pps/built-in.o
  CC      drivers/ras/ras.o
  CC      drivers/gpu/drm/i915/intel_acpi.o
  CC      drivers/ptp/ptp_sysfs.o
  CC      drivers/gpu/drm/i915/intel_opregion.o
  CC      drivers/gpu/drm/i915/intel_fbdev.o
  CC      drivers/ras/debugfs.o
  LD      drivers/ras/built-in.o
  CC      drivers/gpu/drm/i915/dvo_ch7017.o
  CC      drivers/rtc/rtc-lib.o
  CC      drivers/gpu/drm/i915/dvo_ch7xxx.o
  LD      drivers/ptp/ptp.o
  LD      drivers/ptp/built-in.o
  LD      drivers/scsi/pcmcia/built-in.o
  CC      drivers/scsi/scsi.o
  CC      drivers/rtc/systohc.o
  CC      drivers/scsi/hosts.o
  CC      drivers/rtc/class.o
  CC      drivers/gpu/drm/i915/dvo_ivch.o
  CC      drivers/rtc/interface.o
  CC      drivers/rtc/rtc-dev.o
  CC      drivers/gpu/drm/i915/dvo_ns2501.o
  CC      drivers/rtc/rtc-proc.o
  CC      drivers/scsi/scsi_ioctl.o
  CC      drivers/scsi/scsicam.o
  CC      drivers/rtc/rtc-sysfs.o
  CC      drivers/rtc/rtc-cmos.o
  CC      drivers/scsi/scsi_error.o
  CC      drivers/gpu/drm/i915/dvo_sil164.o
  CC      drivers/gpu/drm/i915/dvo_tfp410.o
  CC      drivers/scsi/scsi_lib.o
  CC      drivers/scsi/scsi_common.o
  CC      drivers/gpu/drm/i915/intel_crt.o
  CC      drivers/scsi/constants.o
  LD      drivers/rtc/rtc-core.o
  LD      drivers/rtc/built-in.o
  LD      drivers/soc/built-in.o
  CC      drivers/spi/spi.o
  CC      drivers/gpu/drm/i915/intel_ddi.o
  CC      drivers/scsi/scsi_lib_dma.o
  CC      drivers/gpu/drm/i915/intel_dp_mst.o
  CC      drivers/gpu/drm/i915/intel_dp.o
  CC      drivers/scsi/scsi_scan.o
  CC      drivers/scsi/scsi_sysfs.o
  CC      drivers/scsi/scsi_devinfo.o
  CC      drivers/gpu/drm/i915/intel_dsi.o
  CC      drivers/scsi/scsi_sysctl.o
  CC      drivers/scsi/scsi_proc.o
  CC      drivers/scsi/scsi_trace.o
  CC      drivers/spi/spi-pxa2xx.o
  CC      drivers/spi/spi-pxa2xx-dma.o
  CC      drivers/scsi/scsi_logging.o
  CC      drivers/scsi/scsi_pm.o
  CC      drivers/gpu/drm/i915/intel_dsi_panel_vbt.o
  CC      drivers/spi/spi-pxa2xx-pci.o
  CC      drivers/scsi/scsi_transport_spi.o
  CC      drivers/gpu/drm/i915/intel_dsi_pll.o
  CC      drivers/scsi/sd.o
  LD      drivers/spi/spi-pxa2xx-platform.o
  CC      drivers/scsi/sr.o
  LD      drivers/spi/built-in.o
  CC      drivers/thermal/thermal_core.o
  CC      drivers/gpu/drm/i915/intel_dvo.o
  CC      drivers/scsi/sr_ioctl.o
  CC      drivers/gpu/drm/i915/intel_hdmi.o
  CC      drivers/scsi/sr_vendor.o
  CC      drivers/gpu/drm/i915/intel_i2c.o
  CC      drivers/scsi/sg.o
  LD      drivers/scsi/scsi_mod.o
  CC      drivers/gpu/drm/i915/intel_lvds.o
  CC      drivers/gpu/drm/i915/intel_panel.o
  CC      drivers/gpu/drm/i915/intel_sdvo.o
  CC      drivers/thermal/thermal_hwmon.o
  CC      drivers/gpu/drm/i915/intel_tv.o
  CC      drivers/gpu/drm/i915/i915_vgpu.o
  CC      drivers/thermal/step_wise.o
  CC      drivers/thermal/user_space.o
  LD      drivers/thermal/int340x_thermal/built-in.o
  CC      drivers/gpu/drm/i915/i915_dma.o
  LD      drivers/thermal/samsung/built-in.o
  LD      drivers/scsi/sr_mod.o
  LD      drivers/scsi/sd_mod.o
  CC      drivers/tty/tty_io.o
  LD      drivers/thermal/thermal_sys.o
  LD      drivers/thermal/built-in.o
  CC      drivers/usb/class/usblp.o
  LD      drivers/scsi/built-in.o
  CC      drivers/video/hdmi.o
  CC      drivers/video/backlight/backlight.o
  CC      drivers/video/backlight/generic_bl.o
  CC      drivers/video/console/dummycon.o
  CC      drivers/video/console/vgacon.o
  LD      drivers/video/backlight/built-in.o
  CC      drivers/video/logo/logo.o
  CC      drivers/video/fbdev/core/fb_notify.o
  LD      drivers/usb/class/built-in.o
  CC      drivers/usb/common/common.o
  CC      drivers/video/fbdev/core/fb_cmdline.o
  CC      drivers/video/fbdev/core/fbmem.o
  LOGO    drivers/video/logo/logo_linux_clut224.c
  LOGO    drivers/video/logo/logo_linux_mono.c
  LOGO    drivers/video/logo/logo_superh_mono.c
  LOGO    drivers/video/logo/clut_vga16.c
  LOGO    drivers/video/logo/logo_blackfin_vga16.c
  LOGO    drivers/video/logo/logo_linux_vga16.c
  LOGO    drivers/video/logo/logo_superh_vga16.c
  LOGO    drivers/video/logo/logo_blackfin_clut224.c
  LOGO    drivers/video/logo/logo_dec_clut224.c
  LOGO    drivers/video/logo/logo_m32r_clut224.c
  LOGO    drivers/video/logo/logo_mac_clut224.c
  LOGO    drivers/video/logo/logo_parisc_clut224.c
  LOGO    drivers/video/logo/logo_sgi_clut224.c
  LOGO    drivers/video/logo/logo_spe_clut224.c
  LOGO    drivers/video/logo/logo_sun_clut224.c
  LD      drivers/gpu/drm/i915/i915.o
  LOGO    drivers/video/logo/logo_superh_clut224.c
  CC      drivers/video/fbdev/core/fbmon.o
  CC      drivers/video/logo/logo_linux_clut224.o
  LD      drivers/video/logo/built-in.o
  CC      drivers/video/fbdev/core/fbcmap.o
  LD      drivers/gpu/drm/i915/built-in.o
  LD      drivers/usb/common/usb-common.o
  LD      drivers/usb/common/built-in.o
  CC      drivers/usb/core/usb.o
  LD      drivers/gpu/drm/built-in.o
  CC      drivers/video/fbdev/core/fbsysfs.o
  LD      drivers/gpu/built-in.o
  CC      drivers/watchdog/watchdog_core.o
  CC      drivers/video/console/fbcon.o
  CC      drivers/video/console/bitblit.o
  CC      drivers/tty/n_tty.o
  CC      drivers/video/fbdev/core/modedb.o
  CC      drivers/watchdog/watchdog_dev.o
  CC      drivers/usb/core/hub.o
  CC      drivers/tty/tty_ioctl.o
  CC      drivers/video/fbdev/core/fbcvt.o
  CC      drivers/video/console/softcursor.o
  CC      drivers/video/fbdev/core/cfbfillrect.o
  LD      drivers/watchdog/watchdog.o
  LD      drivers/watchdog/built-in.o
  CC      drivers/video/fbdev/core/cfbcopyarea.o
  CC      drivers/video/fbdev/core/cfbimgblt.o
  CC      drivers/video/console/tileblit.o
  CC      drivers/tty/tty_ldisc.o
  CC      drivers/video/fbdev/core/sysfillrect.o
  CC      drivers/video/fbdev/core/syscopyarea.o
  CC      drivers/video/fbdev/core/sysimgblt.o
  CC      drivers/video/fbdev/core/fb_sys_fops.o
  CC      drivers/tty/tty_buffer.o
  LD      drivers/video/fbdev/core/fb.o
  CC      drivers/tty/tty_port.o
  CC      drivers/tty/tty_mutex.o
  CC      drivers/tty/tty_ldsem.o
  CC      drivers/tty/pty.o
  LD      drivers/video/fbdev/core/built-in.o
  LD      drivers/video/fbdev/omap2/displays-new/built-in.o
  LD      drivers/video/fbdev/omap2/dss/built-in.o
  LD      drivers/video/fbdev/omap2/built-in.o
  CC      drivers/video/fbdev/efifb.o
  CC      drivers/tty/tty_audit.o
  CC      drivers/tty/sysrq.o
  LD      drivers/tty/ipwireless/built-in.o
  CC      drivers/tty/serial/serial_core.o
  CC      drivers/tty/vt/vt_ioctl.o
  LD      drivers/video/console/built-in.o
  LD      drivers/video/fbdev/built-in.o
  CC      drivers/tty/vt/vc_screen.o
  LD      drivers/video/built-in.o
  CC      drivers/usb/early/ehci-dbgp.o
  CC      drivers/usb/gadget/usbstring.o
  CC      drivers/usb/gadget/config.o
  CC      drivers/usb/gadget/epautoconf.o
  CC      drivers/usb/gadget/composite.o
  CC      drivers/usb/core/hcd.o
  CC      drivers/tty/vt/selection.o
  LD      drivers/usb/early/built-in.o
  CC      drivers/usb/host/pci-quirks.o
  CC      drivers/usb/gadget/functions.o
  CC      drivers/usb/host/ehci-hcd.o
  CC      drivers/usb/gadget/configfs.o
  CC      drivers/usb/gadget/u_f.o
  CC      drivers/tty/vt/keyboard.o
  CC      drivers/usb/host/ehci-pci.o
  CC      drivers/tty/serial/earlycon.o
  CC      drivers/usb/gadget/function/u_ether.o
  CC      drivers/tty/serial/8250/8250_core.o
  CC      drivers/usb/gadget/function/f_ecm.o
  CC      drivers/usb/gadget/legacy/ether.o
  CC      drivers/usb/core/urb.o
  CC      drivers/usb/gadget/udc/udc-core.o
  CC      drivers/usb/gadget/function/f_subset.o
  LD      drivers/usb/gadget/legacy/g_ether.o
  LD      drivers/usb/gadget/legacy/built-in.o
  LD      drivers/usb/gadget/libcomposite.o
  CC      drivers/usb/gadget/function/f_rndis.o
  CC      drivers/usb/gadget/function/rndis.o
  CC      drivers/tty/vt/consolemap.o
  CC      drivers/tty/serial/8250/8250_pnp.o
  CC      drivers/usb/core/message.o
  LD      drivers/usb/gadget/udc/built-in.o
  CC      drivers/usb/core/driver.o
  LD      drivers/usb/gadget/function/usb_f_ecm.o
  LD      drivers/usb/gadget/function/usb_f_ecm_subset.o
  CC      drivers/usb/core/config.o
  CC      drivers/tty/serial/8250/8250_port.o
  CC      drivers/tty/serial/8250/8250_dma.o
  CONMK   drivers/tty/vt/consolemap_deftbl.c
  CC      drivers/tty/vt/vt.o
  LD      drivers/usb/gadget/function/usb_f_rndis.o
  LD      drivers/usb/gadget/function/built-in.o
  LD      drivers/usb/gadget/built-in.o
  LD      drivers/usb/misc/built-in.o
  CC      drivers/usb/mon/mon_main.o
  CC      drivers/usb/core/file.o
  CC      drivers/tty/serial/8250/8250_pci.o
  CC      drivers/usb/mon/mon_stat.o
  CC      drivers/usb/core/buffer.o
  CC      drivers/usb/core/sysfs.o
  CC      drivers/usb/host/ohci-hcd.o
  CC      drivers/usb/core/endpoint.o
  CC      drivers/usb/mon/mon_text.o
  CC      drivers/usb/mon/mon_bin.o
  CC      drivers/tty/serial/8250/8250_exar.o
  CC      drivers/usb/core/devio.o
  CC      drivers/usb/core/notify.o
  CC      drivers/usb/core/generic.o
  CC      drivers/usb/core/quirks.o
  CC      drivers/tty/serial/8250/8250_early.o
  CC      drivers/tty/serial/8250/8250_dw.o
  LD      drivers/usb/mon/usbmon.o
  LD      drivers/usb/mon/built-in.o
  LD      drivers/usb/phy/built-in.o
  CC      drivers/usb/core/devices.o
  CC      drivers/usb/host/ohci-pci.o
  CC      drivers/usb/core/port.o
  LD      drivers/tty/serial/8250/8250.o
  LD      drivers/tty/serial/8250/8250_base.o
  CC      drivers/usb/core/hcd-pci.o
  CC      drivers/usb/host/uhci-hcd.o
  LD      drivers/tty/serial/8250/built-in.o
  LD      drivers/tty/serial/built-in.o
  SHIPPED drivers/tty/vt/defkeymap.c
  CC      drivers/usb/core/usb-acpi.o
  CC      drivers/tty/vt/consolemap_deftbl.o
  CC      drivers/tty/vt/defkeymap.o
  CC      drivers/usb/storage/scsiglue.o
  CC      drivers/usb/storage/protocol.o
  CC      drivers/usb/storage/transport.o
  LD      drivers/tty/vt/built-in.o
  LD      drivers/tty/built-in.o
  CC      drivers/usb/host/xhci.o
  CC      drivers/usb/host/xhci-mem.o
  CC      drivers/usb/host/xhci-ring.o
  LD      drivers/usb/core/usbcore.o
  LD      drivers/usb/core/built-in.o
  CC      drivers/usb/host/xhci-hub.o
  CC      drivers/usb/storage/usb.o
  CC      drivers/usb/storage/initializers.o
  CC      drivers/usb/storage/sierra_ms.o
  CC      drivers/usb/storage/option_ms.o
  CC      drivers/usb/storage/usual-tables.o
  CC      drivers/usb/host/xhci-dbg.o
  CC      drivers/usb/host/xhci-trace.o
  CC      drivers/usb/host/xhci-pci.o
  LD      drivers/usb/storage/usb-storage.o
  LD      drivers/usb/storage/built-in.o
  LD      drivers/usb/host/xhci-hcd.o
  LD      drivers/usb/host/built-in.o
  LD      drivers/usb/built-in.o
  LD      drivers/built-in.o
  LINK    vmlinux
  LD      vmlinux.o
ld: warning: arch/x86/built-in.o: requires executable stack (because
the .note.GNU-stack section is executable)
  MODPOST vmlinux.o
WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable section.
Did you forget to use "ax"/"aw" in a .S file?
Note that for example <linux/init.h> contains
section definitions for use in .S files.

WARNING: vmlinux.o (.discard.retpoline_safe): unexpected
non-allocatable section.
Did you forget to use "ax"/"aw" in a .S file?
Note that for example <linux/init.h> contains
section definitions for use in .S files.

  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
ld: warning: arch/x86/built-in.o: requires executable stack (because
the .note.GNU-stack section is executable)
ld: arch/x86/kernel/head32.o: in function `sanitize_boot_params.constprop.0=
':
head32.c:(.text.unlikely+0x1d): undefined reference to
`__ubsan_handle_type_mismatch_v1'
ld: head32.c:(.text.unlikely+0xa0): undefined reference to
`__ubsan_handle_type_mismatch_v1'
ld: head32.c:(.text.unlikely+0xe5): undefined reference to
`__ubsan_handle_type_mismatch_v1'
ld: head32.c:(.text.unlikely+0x124): undefined reference to
`__ubsan_handle_type_mismatch_v1'
ld: init/built-in.o: in function `do_one_initcall':
(.text+0x1b4): undefined reference to `__ubsan_handle_type_mismatch_v1'
ld: init/built-in.o:(.text+0x1c5): more undefined references to
`__ubsan_handle_type_mismatch_v1' follow

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## defconfig on (i386):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67adc99db51b43eaedd95f91


#kernelci issue maestro:0b409eddedc3bdcf5c60bb604bad1e27aa4fbe86

Reported-by: kernelci.org bot <bot@kernelci.org>


--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

