Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3103C83F17
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 22:10:41 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
 by mx.groups.io with SMTP id smtpd.web10.2777.1753308632382819510
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Jul 2025 15:10:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=xS6AajIK;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.171, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso272125276.2
        for <cip-dev@lists.cip-project.org>; Wed, 23 Jul 2025 15:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1753308631; x=1753913431; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/yG0tT/pKX+ykXeN2vNbdGOZtdeTIHg6Nra8TzDLi7I=;
        b=xS6AajIKvPaYBxElk0GrFQx/J1WRTPuj4oTGj1Bd+w/VbAIfeCSlEuZflLBDu8oioX
         DTS9qmoAlb11CZbUeYfi7foHWunI33dWRZJ63fTQOWhpsFhCYLv3bfnSbx3Ed8ZuEYtF
         I621eQ299FMWbPhdGBF0VbOZWpuUuBcumv8qhVkIzO+VhQRZERpKmqM+nLH0ogbrFRa+
         aciXApSxzYMFlPVhGeHq7fDemQa3Nk/GiJSgiF+cJKa+rIwV1G8CjYzcE+dktcFf2rlB
         BJmG65SiMbGCOj+JIxxA0MKrI3LYA1LxowAG7TU0hVMiZphikYg9WKCoeRoCf+LNG6Y2
         hTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753308631; x=1753913431;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/yG0tT/pKX+ykXeN2vNbdGOZtdeTIHg6Nra8TzDLi7I=;
        b=MFCedOSiWeGhJ9m9ODeUHzhcxfDcEDKmAFbOxNG7mgIPA+GzyF4pWut7Lb1E34mWk3
         0baVwCvAyNJ47hxFgKzl+76wTFjB2NKqvbFlLLwZOAlh7XrT/26yIfQDu2qcMo+tCcqd
         NHGR4Y+p9ppxUifkSPPxMR8E9BlrzgEIWu6GEuQNASsb2gGwNKisaZRa8/blJKI65O8l
         Hwljs4iw4miFyEqI27EMV6ozKhRkPfCEEsITDa2kbi/t2X5SXd/KclehUBG+oTF9JYjZ
         ewsBv0n9kqejFB061pEh+ZAVv8hsPTNErzLsVQxuwQceOVcUGzkfl+Ef7fOKJEirqfLJ
         n9uA==
X-Gm-Message-State: AOJu0YzwliZXfhPRVgi5Jkx7djWEoaNL6EV7zhbdtUyeqghKEzxmY6l9
	F1+fVDyF67VWlQk2hFdA7WayBOsaao2GB1EPkiT4mR0qe1Hvnqkm0ZjcaI9JeKGHFozb1PslJt9
	SFHayY6E1ABR6c2OBVaSOLefpWoc4raie0VZjzXNfDuaGBNANXtuK4ug=
X-Gm-Gg: ASbGncuMSF9eFjWATq/r8y94dBLBZmEUfA2ZlUokuw4ZLd1Mnpb5u12JEMHF7deQrKC
	pLYRQMIV+8Y8ivQEmdb2nQBGEKiXu1qXO1Ru6fpnI445wYis3RixAAWnY877v1vi5/uY/1m1vXi
	JZGztc9E1TQjvOrcOLAG7VcmGxbOGTiVubVttEfA8po3WeqMf3wdSa+9cysJW2fcZ2REezc45nK
	IdNoALs
X-Google-Smtp-Source: AGHT+IGOF7OlXCrQO0+1egD9lP/eYJmJvHxoMgJMbxNbciS6xxWRuAGRVvaDnbaeTrGxsAV4466jzGhVsoPNvZVKjOc=
X-Received: by 2002:a5b:442:0:b0:e8b:53ba:2a2 with SMTP id 3f1490d57ef6-e8dc5aba0b4mr4585735276.39.1753308630987;
 Wed, 23 Jul 2025 15:10:30 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 24 Jul 2025 07:09:55 +0900
X-Gm-Features: Ac12FXwrSNQYP2hAnVk3eSXT7Bf33DBrhmiiW67PjCH9O9yDYoxJTA1-9Yhrn4E
Message-ID: <CAODzB9pQO5pjBnk052EgGuizESk+3okckMsw1BBC3JLhb_2nMQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Jul 2025 22:10:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19576

Hi!

It's this week's CVE report.

This week reported 4 new CVEs and 24 updated CVEs.

* New CVEs
CVE-2025-38349: eventpoll: don't decrement ep refcount while still
holding the ep mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38349

Introduced commit is not determined.Fixed in v6.16-rc6.
Reference counter code was introduced by 58c9b01 ("epoll: use refcount to
reduce ep_mutex contention") in 6.4-rc1.

Fixed status
mainline: [8c2e52ebbe885c7eeaabd3b7ddcdc1246fc400d2]
stable/6.12: [6dee745bd0aec9d399df674256e7b1ecdb615444]
stable/6.6: [521e9ff0b67c66a17d6f9593dfccafaa984aae4c]

CVE-2025-38350: net/sched: Always pass notifications when child class
becomes empty

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38350

Introduced by commit 3f98113 ("sch_hfsc: Fix qlen accounting bug when
using peek in hfsc_enqueue()") in v6.15.
Fixed in v6.16-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12
stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [103406b38c600fec1fe375a77b27d87e314aea09]
stable/5.10: [e9921b57dca05ac5f4fa1fa8e993d4f0ee52e2b7]
stable/5.15: [e269f29e9395527bc00c213c6b15da04ebb35070]
stable/5.4: [3b290923ad2b23596208c1e29520badef4356a43]
stable/6.1: [7874c9c132e906a52a187d045995b115973c93fb]
stable/6.12: [a553afd91f55ff39b1e8a1c4989a29394c9e0472]
stable/6.6: [f680a4643c6f71e758d8fe0431a958e9a6a4f59d]

CVE-2025-38351: KVM: x86/hyper-v: Skip non-canonical addresses during
PV TLB flush

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38351

Introduced by commit 2609708 ("KVM: x86: hyper-v: Handle
HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently") in v6.2-rc1.
Fixed in v6.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa787ac07b3ceb56dd88a62d1866038498e96230]

CVE-2025-38352: posix-cpu-timers: fix race between
handle_posix_cpu_timers() and posix_cpu_timer_del()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38352

Introduced by commit 0bdd2ed ("sched: run_posix_cpu_timers: Don't
check ->exit_state, use lock_task_sighand()") in v2.6.36-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e43787b92b7f343724665c2666ee072e5d67c356]
mainline: [f90fff1e152dedf52b932240ebbd670d83330eca]
stable/5.10: [c076635b3a42771ace7d276de8dc3bc76ee2ba1b]
stable/5.15: [2f3daa04a9328220de46f0d5c919a6c0073a9f0b]
stable/5.4: [78a4b8e3795b31dae58762bc091bb0f4f74a2200]
stable/6.1: [764a7a5dfda23f69919441f2eac2a83e7db6e5bb]
stable/6.12: [c29d5318708e67ac13c1b6fc1007d179fb65b4d7]
stable/6.6: [2c72fe18cc5f9f1750f5bc148cf1c94c29e106ff]

* Updated CVEs
CVE-2022-48703: thermal/int340x_thermal: handle data_vault when the
value is ZERO_SIZE_PTR

stable/5.15 was fixed.

Fixed status
stable/5.15: [39d5137085a6c37ace4680ee4d24020a4a03e7dc]

CVE-2024-26644: btrfs: don't abort filesystem when attempting to
snapshot deleted subvolume

stable/5.4 was fixed.

Fixed status
stable/5.4: [c06941564027bdbc01d2df7f41e333c11cb0482d]

CVE-2024-26775: aoe: avoid potential deadlock at set_capacity

stable/5.15 was fixed.

Fixed status
stable/5.15: [2499fa286fb010ceb289950050199f33c26667b9]

CVE-2024-44939: jfs: fix null ptr deref in dtInsertEntry

stable/5.15 was fixed.

Fixed status
stable/5.15: [f98bf80b20f4a930589cda48a35f751a64fe0dc2]

CVE-2024-49935: ACPI: PAD: fix crash in exit_round_robin()

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [d214ffa6eb39c08d18a460124dd7ba318dc56f33]
stable/5.4: [82191a21a0dedc8c64e14f07f5d568d09bc4b331]

CVE-2025-37984: crypto: ecdsa - Harden against integer overflows in
DIV_ROUND_UP()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [f2133b849ff273abddb6da622daddd8f6f6fa448]
stable/6.6: [f02f0218be412cff1c844addf58e002071be298b]

CVE-2025-38067: rseq: Fix segfault on registration when rseq_cs is non-zero

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [48900d839a3454050fd5822e34be8d54c4ec9b86]
stable/5.15: [3e4028ef31b69286c9d4878cee0330235f53f218]
stable/6.1: [b2b05d0dc2f4f0646922068af435aed5763d16ba]
stable/6.12: [f004f58d18a2d3dc761cf973ad27b4a5997bd876]
stable/6.6: [eaf112069a904b6207b4106ff083e0208232a2eb]

CVE-2025-38074: vhost-scsi: protect vq->log_used with vq->mutex

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [80cf68489681c165ded460930e391b1eb37b5f6f]
stable/5.15: [8312a1ccff1566f375191a89b9ba71b6eb48a8cd]
stable/6.1: [59614c5acf6688f7af3c245d359082c0e9e53117]

CVE-2025-38102: VMCI: fix race between vmci_host_setup_notify and
vmci_ctx_unset_notify

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [468aec888f838ce5174b96e0cb4396790d6f60ca]
stable/5.4: [74095bbbb19ca74a0368d857603a2438c88ca86c]

CVE-2025-38104: drm/amdgpu: Replace Mutex with Spinlock for RLCG
register access to avoid Priority Inversion in SRIOV

stable/6.12 was fixed.

Fixed status
stable/6.12: [07ed75bfa7ede8bfcfa303fd6efc85db1c8684c7]

CVE-2025-38193: net_sched: sch_sfq: reject invalid perturb period

stable/5.10 was fixed.

Fixed status
stable/5.10: [2254d038dab9c194fe6a4b1ce31034f42e91a6e5]

CVE-2025-38211: RDMA/iwcm: Fix use-after-free of work objects after
cm_id destruction

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [bf7eff5e3a36c54bbe8aff7fd6dd7c07490b81c5]
stable/5.4: [013dcdf6f03bcedbaf1669e3db71c34a197715b2]

CVE-2025-38226: media: vivid: Change the siize of the composing

stable/5.4 was fixed.

Fixed status
stable/5.4: [57597d8db5bbda618ba2145b7e8a7e6f01b6a27e]

CVE-2025-38229: media: cxusb: no longer judge rbuf when the write fails

stable/5.4 was fixed.

Fixed status
stable/5.4: [77829a5f5a74026b888b0529628475b29750cef4]

CVE-2025-38230: jfs: validate AG parameters in dbMount() to prevent crashes

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [a4259e72363e1ea204a97292001a9fc36c7e52fd]
stable/5.4: [95ae5ee6069d9a5945772625f289422ef659221a]

CVE-2025-38245: atm: Release atm_dev_mutex after removing procfs in
atm_dev_deregister().

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [4bb1bb438134d9ee6b97cc07289dd7c569092eec]
stable/5.4: [2a8dcee649d12f69713f2589171a1caf6d4fa439]

CVE-2025-38249: ALSA: usb-audio: Fix out-of-bounds read in
snd_usb_get_audioformat_uac3()

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [2dc1c3edf67abd30c757f8054a5da61927cdda21]
stable/5.4: [24ff7d465c4284529bbfa207757bffb6f44b6403]

CVE-2025-38251: atm: clip: prevent NULL deref in clip_push()

stable/5.10 was fixed.

Fixed status
stable/5.10: [41f6420ee845006354c004839fed07da71e34aee]

CVE-2025-38262: tty: serial: uartlite: register uart driver in init

stable/5.4 was fixed.

Fixed status
stable/5.4: [5015eed450005bab6e5cb6810f7a62eab0434fc4]

CVE-2025-38263: bcache: fix NULL pointer in cache_set_flush()

stable/5.10 was fixed.

Fixed status
stable/5.10: [d54681938b777488e5dfb781b566d16adad991de]


CVE-2024-28956: x86: Indirect Target Selection

stable/5.10 was fixed.

Fixed status
stable/5.10: [cda93610bbbfa5b8d1b0e7fe746c8be81d484f23,
5402d7784a0c128dac6edd09ae387dd2e26c7249,
3c9fea6f464966b7c49399416f32f06d36fb8112,
09c33d19dd4c00069ec85137907e0ffdf3ccf60c,
c06b48bf6649fc7f5df93e319f064c4d661b54b5,
ae00968afde358ea046eb1a7c7342d8db3b875bd,
ad40aa1f3f10cd433f6442e438dbe11449e71aef,
d9e2ba542fc2c55eb4128e57d77c07c9539980e1,
f5709d9086f6dd97f5582620fd8609f9d02eb15b,
07d828c0845651a7822be9535e91c095474bd140,
116a42f01f7da1c7b032bf7ceded132c671f8e6f,
129947ac5441b5c3e1c350ac49492d83ce957d87,
852084566b338d42338ee203e329b31dd8495862,
ac1b649e46f90fa9183edde5ac9a10154eeb53d6,
31967b44812db6a5902ef77a8a51fb0593ff0bb5,
0aac24882272233eced7dca4862fca6fa90ef415]

CVE-2025-27558: IEEE P802.11-REVme D1.1 through D7.0 allows
FragAttacks against mesh
networks. In mesh networks using Wi-Fi Protected Access (WPA, WPA2, or
WPA3) or Wired Equivalent Privacy (WEP), an adversary can exploit this
vulnerability to inject arbitrary frames towards devices that support
receiving non-SSP A-MSDU frames. NOTE: this issue exists because of an
incorrect fix for CVE-2020-24588. P802.11-REVme, as of early 2025, is a
planned release of the 802.11 standard.

stable/6.1, stable/6.12, stable/6.15, stable/6.6 were fixed.

Fixed status
stable/6.1: [e2c8a3c0388aef6bfc4aabfba07bc7dff16eea80]
stable/6.12: [e01851f6e9a665a6011b14714b271d3e6b0b8d32]
stable/6.15: [6e3b09402cc6c3e3474fa548e8adf6897dda05de]
stable/6.6: [ec6392061de6681148b63ee6c8744da833498cdd]

CVE-2024-36350: TSA-SQ (TSA in the Store Queues)

stable/5.10 was fixed.

Fixed status
stable/5.10: [b9d08aebbe1859bbca5600fd1220b2ffa703df29,
78192f511f401af644e6ccb7c02bc1ce39092851,
6fea1a4e150f1fe3726310558f33a30e0c209153,
a8a08f1e519b4fd08adce08ebfa1763950be5d99]

CVE-2024-36357: TSA-L1 (TSA in the L1 data cache)

stable/5.10 was fixed.

Fixed status
stable/5.10: [b9d08aebbe1859bbca5600fd1220b2ffa703df29,
78192f511f401af644e6ccb7c02bc1ce39092851,
6fea1a4e150f1fe3726310558f33a30e0c209153,
a8a08f1e519b4fd08adce08ebfa1763950be5d99]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

