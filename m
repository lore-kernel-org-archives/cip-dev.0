Return-Path: <kazunori.kobayashi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19ECCA100B
	for <webhook@archiver.kernel.org>; Wed,  3 Sep 2025 06:31:38 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.5954.1756881089828383636
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Sep 2025 23:31:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=d+SM4xE/;
 spf=pass (domain: miraclelinux.com, ip: 209.85.214.174, mailfrom: kazunori.kobayashi@miraclelinux.com)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2445806e03cso73070185ad.1
        for <cip-dev@lists.cip-project.org>; Tue, 02 Sep 2025 23:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1756881089; x=1757485889; darn=lists.cip-project.org;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGj8qvi5qVrkBqaX9UIWFef7cWfGsK2H3+f3XglJq7Y=;
        b=d+SM4xE/oskbGi1UjMVq5IpdNncKfhY+miXsgwfKLtj7nZ7tQmzhPrQ1NzTQLuGGrs
         I4SCtslIac0CNvtqwbeLVsymYYI7sj8WXZr18Kv98EKA5meUsYIca5D6oqza520Q+RJt
         oU9EaOwylbceUw3mjtC361yRJTo1LOXv+8Dab3DB5zP9uUhLhzon/kQG/v1dUJxd9KbM
         A6HS5HXR/b23DUJYHxbChycWF4zWukFo51Jkn+pCm5xAvRjlSNw7z25Fzb1CCU5X0O9V
         vbF4Mt/j62rWAWvaVxMx+lL9DxmImJFGdiPmnON/n6N/HvWrtJnT//mLFXgWLRZkvdX9
         WLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756881089; x=1757485889;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PGj8qvi5qVrkBqaX9UIWFef7cWfGsK2H3+f3XglJq7Y=;
        b=Us2Vh2YHAa9M91jhYFVer01tHapIARqn6BTSIIkn88365gcMSROwBmmN2YO2wEkU/L
         jzccUXhNEL19k2Vs8D0UJsHe5H8GArI4u8q7Rz1YriNXmQaqnu4/lwwO7PS/16GmRh3z
         kAA4N0ueOHXKkpVbOr7pXO/uhOl6An1Bt00BBTjsh+to7auIBIPEvQnOoPX2jPTLD7Q8
         TFHXKjHdNfhKGSXWCVuCJkkrZj705XsCBMnjZLt5jeowBJUzorjdCv6GWUAeEmkhzNGI
         SfjfnRzOUMHzzPOztXEtd2HwTGbwhz6Un2VCUDstENP7lj+Wfgpxlurg0s0I+BGJZ5IJ
         UieQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPuxSM+Dsf0tG6BXEpDNJBP4xCJehPti1ytRZASmqYryHfFntEV2dAgNq4+lDJznOXf9LOCl1P@lists.cip-project.org
X-Gm-Message-State: AOJu0YzbVkoXKoH9LvpEtMw6nQ8iOrckmwHyX2uI96kav2SxB/buyLFq
	g4jDqzItSEpyKASSJ5fFEWiqYqUZood8sjxLaW99JChO7BX5Jr7tdxQP2eq2AS6/tEs=
X-Gm-Gg: ASbGncscmknLE1sz972q90dyKU4tQgAQE6n2TxxPkUZfyZMMKyxcnDPB98ZPdtJKSm9
	daYqIDjwBK/NdS38z6uG1e3vzUlkVQ4DKBVwXvjg3DEnbraGACF5oRdw3q7+3jcUSGafyhPnwFi
	8mQPHj4UpRMHiENm+6A84sMg5zSzvufW8OefqgapRe0ZIIktElY7nki4D86RsCI7EdHmRWI5siw
	ecL8TwFjXDc1z4I2Mb0pgLFILGFZDAvOYGKlDwMpSizF0CMUeeRVMM8LbOXs7DrCZdijd7CHy65
	rrs0WVBNe72wcXoordzOt5r+o4726LVwrVXUWTRTeGVXzQOD956Z3ET1JTZmWyoZLOY7nhMHVte
	iGDWVO3DYPmH6u4UfvvmX27UrRFrWxcV0kSkB4cnBOA0hMUZtdhMYnP7lbOy/o4/pPWf8nn3uXr
	ugg0aCMGHEPSiS
X-Google-Smtp-Source: AGHT+IGEwkl5yTxCQc22XUt7jL/LlewjRaWniR8xAor6sgHkLBaa5SgToq6lopbnqcjHHo7hV1pWOg==
X-Received: by 2002:a17:903:2286:b0:242:e29e:d6a6 with SMTP id d9443c01a7336-24944acbcbcmr187214895ad.40.1756881088868;
        Tue, 02 Sep 2025 23:31:28 -0700 (PDT)
Received: from [192.168.11.7] (133-149-217-149.east.dxpn.ucom.ne.jp. [133.149.217.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da1879sm151384025ad.87.2025.09.02.23.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 23:31:28 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------hR0ZH7PGO2kJnCPSW0cUw3FB"
Message-ID: <42de8250-d98b-40e5-9e8a-d6bbb1ca8b6b@miraclelinux.com>
Date: Wed, 3 Sep 2025 15:31:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.325-cip123
To: uli@fpond.eu,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "pavel@denx.de" <pavel@denx.de>,
 "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
 "masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
 "chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
 "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <1602384696.84101.1755530487321@webmail.strato.de>
Content-Language: en-US
From: Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
In-Reply-To: <1602384696.84101.1755530487321@webmail.strato.de>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Sep 2025 06:31:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19995

This is a multi-part message in MIME format.
--------------hR0ZH7PGO2kJnCPSW0cUw3FB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 8/19/25 00:21, Ulrich Hecht via lists.cip-project.org wrote:
> Hi,
>
> the CIP kernel team has released Linux kernel v4.19.325-cip123. The linux-4.19.y-cip tree's base version has been updated to v4.19-st7. The trees are up-to-date with kernel 5.4.296.
>
> You can get this release via the git tree or as a tarball fromhttps://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/
>
>    v4.19.325-cip123:
>      repository:
>        https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>      branch:
>        linux-4.19.y-cip
>      commit hash:
>        1e9cb006c55b0164de79c50947377a71deca9975
>      Fixed CVEs:
>        CVE-2024-26644: btrfs: don't abort filesystem when attempting to snapshot deleted subvolume
>        CVE-2024-49935: ACPI: PAD: fix crash in exit_round_robin()
>        CVE-2025-38102: VMCI: fix race between vmci_host_setup_notify and vmci_ctx_unset_notify
>        CVE-2025-38211: RDMA/iwcm: Fix use-after-free of work objects after cm_id destruction
>        CVE-2025-38226: media: vivid: Change the siize of the composing
>        CVE-2025-38230: jfs: validate AG parameters in dbMount() to prevent crashes
>        CVE-2025-38245: atm: Release atm_dev_mutex after removing procfs in atm_dev_deregister().
>        CVE-2025-38249: ALSA: usb-audio: Fix out-of-bounds read in snd_usb_get_audioformat_uac3()
>        CVE-2025-38350: net/sched: Always pass notifications when child class becomes empty
>        CVE-2025-38377: rose: fix dangling neighbour pointers in rose_rt_device_down()
>        CVE-2025-38386: ACPICA: Refuse to evaluate a method if arguments are missing
>        CVE-2025-38391: usb: typec: altmodes/displayport: do not index invalid pin_assignments
>        CVE-2025-38401: mtk-sd: Prevent memory corruption from DMA map failure
>        CVE-2025-38403: vsock/vmci: Clear the vmci transport packet properly when initializing it
>        CVE-2025-38406: wifi: ath6kl: remove WARN on bad firmware input
>        CVE-2025-38445: md/raid1: Fix stack memory use after return in raid1_reshape
>        CVE-2025-38448: usb: gadget: u_serial: Fix race condition in TTY wakeup
>        CVE-2025-38457: net/sched: Abort __tc_modify_qdisc if parent class does not exist
>        CVE-2025-38458: atm: clip: Fix NULL pointer dereference in vcc_sendmsg()
>        CVE-2025-38459: atm: clip: Fix infinite recursive call of clip_push().
>        CVE-2025-38460: atm: clip: Fix potential null-ptr-deref in to_atmarpd().
>        CVE-2025-38464: tipc: Fix use-after-free in tipc_conn_close().
>        CVE-2025-38465: netlink: Fix wraparounds of sk->sk_rmem_alloc.
>        CVE-2025-38404: usb: typec: displayport: Fix potential deadlock
>        CVE-2025-38513: wifi: zd1211rw: Fix potential NULL pointer dereference in zd_mac_tx_to_dev()
>        CVE-2025-38514: rxrpc: Fix oops due to non-existence of prealloc backlog struct
>        CVE-2025-38515: drm/sched: Increment job count before swapping tail spsc queue
>        CVE-2025-38540: HID: quirks: Add quirk for 2 Chicony Electronics HP 5MP Cameras
>        CVE-2025-38542: net: appletalk: Fix device refcount leak in atrtr_create()
>        CVE-2025-38546: atm: clip: Fix memory leak of struct clip_vcc.
>
> Best regards,
> Ulrich Hecht
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19754):https://lists.cip-project.org/g/cip-dev/message/19754
> Mute This Topic:https://lists.cip-project.org/mt/114765008/7669380
> Group Owner:cip-dev+owner@lists.cip-project.org
> Unsubscribe:https://lists.cip-project.org/g/cip-dev/unsub [kazunori.kobayashi@cybertrust.co.jp]
> -=-=-=-=-=-=-=-=-=-=-=-
>
I ran into the following compilation error with omap2plus_defconfig 
applied in this kernel version.

| 
/buildbot/build_daily_emlinux_am335xevmsk_latest_dev/build/build_am335x-evmsk_emlinux_core-image-weston/tmp-glibc/work-shared/am335x-evmsk/kernel-source/drivers/media/platform/omap3isp/ispccdc.c: 
In function 'ccdc_lsc_config': | 
/buildbot/build_daily_emlinux_am335xevmsk_latest_dev/build/build_am335x-evmsk_emlinux_core-image-weston/tmp-glibc/work-shared/am335x-evmsk/kernel-source/drivers/media/platform/omap3isp/ispccdc.c:452:3: 
error: implicit declaration of function 'dma_sync_sgtable_for_cpu'; did 
you mean 'dma_sync_single_for_cpu'? 
[-Werror=implicit-function-declaration] | 
dma_sync_sgtable_for_cpu(isp->dev, &req->table.sgt, | 
^~~~~~~~~~~~~~~~~~~~~~~~ | dma_sync_single_for_cpu | CC [M] 
drivers/media/rc/keymaps/rc-avermedia-a16d.o | 
/buildbot/build_daily_emlinux_am335xevmsk_latest_dev/build/build_am335x-evmsk_emlinux_core-image-weston/tmp-glibc/work-shared/am335x-evmsk/kernel-source/drivers/media/platform/omap3isp/ispccdc.c:461:3: 
error: implicit declaration of function 'dma_sync_sgtable_for_device'; 
did you mean 'dma_sync_single_for_device'? 
[-Werror=implicit-function-declaration] | 
dma_sync_sgtable_for_device(isp->dev, &req->table.sgt, | 
^~~~~~~~~~~~~~~~~~~~~~~~~~~ | dma_sync_single_for_device

It seems caused by the following change.

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commit/3483db997d491ba78957eb04743f6bb2ecc242aa

This change seems merged from the 5.4 based kernel, but some other 
dependencies would also be needed to pass the compilation.

Regards,
Kazunori

-- 
Kazunori Kobayashi
Cybertrust Japan Co., Ltd.
https://www.cybertrust.co.jp/

--------------hR0ZH7PGO2kJnCPSW0cUw3FB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Hi,</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">On 8/19/25 00:21, Ulrich Hecht via
      lists.cip-project.org wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1602384696.84101.1755530487321@webmail.strato.de">
      <pre wrap="" class="moz-quote-pre">Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip123. The linux-4.19.y-cip tree's base version has been updated to v4.19-st7. The trees are up-to-date with kernel 5.4.296.

You can get this release via the git tree or as a tarball from <a class="moz-txt-link-freetext" href="https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/">https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/</a>

  v4.19.325-cip123:
    repository:
      <a class="moz-txt-link-freetext" href="https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git">https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git</a>
    branch:
      linux-4.19.y-cip
    commit hash:
      1e9cb006c55b0164de79c50947377a71deca9975
    Fixed CVEs:
      CVE-2024-26644: btrfs: don't abort filesystem when attempting to snapshot deleted subvolume
      CVE-2024-49935: ACPI: PAD: fix crash in exit_round_robin()
      CVE-2025-38102: VMCI: fix race between vmci_host_setup_notify and vmci_ctx_unset_notify
      CVE-2025-38211: RDMA/iwcm: Fix use-after-free of work objects after cm_id destruction
      CVE-2025-38226: media: vivid: Change the siize of the composing
      CVE-2025-38230: jfs: validate AG parameters in dbMount() to prevent crashes
      CVE-2025-38245: atm: Release atm_dev_mutex after removing procfs in atm_dev_deregister().
      CVE-2025-38249: ALSA: usb-audio: Fix out-of-bounds read in snd_usb_get_audioformat_uac3()
      CVE-2025-38350: net/sched: Always pass notifications when child class becomes empty
      CVE-2025-38377: rose: fix dangling neighbour pointers in rose_rt_device_down()
      CVE-2025-38386: ACPICA: Refuse to evaluate a method if arguments are missing
      CVE-2025-38391: usb: typec: altmodes/displayport: do not index invalid pin_assignments
      CVE-2025-38401: mtk-sd: Prevent memory corruption from DMA map failure
      CVE-2025-38403: vsock/vmci: Clear the vmci transport packet properly when initializing it
      CVE-2025-38406: wifi: ath6kl: remove WARN on bad firmware input
      CVE-2025-38445: md/raid1: Fix stack memory use after return in raid1_reshape
      CVE-2025-38448: usb: gadget: u_serial: Fix race condition in TTY wakeup
      CVE-2025-38457: net/sched: Abort __tc_modify_qdisc if parent class does not exist
      CVE-2025-38458: atm: clip: Fix NULL pointer dereference in vcc_sendmsg()
      CVE-2025-38459: atm: clip: Fix infinite recursive call of clip_push().
      CVE-2025-38460: atm: clip: Fix potential null-ptr-deref in to_atmarpd().
      CVE-2025-38464: tipc: Fix use-after-free in tipc_conn_close().
      CVE-2025-38465: netlink: Fix wraparounds of sk-&gt;sk_rmem_alloc.
      CVE-2025-38404: usb: typec: displayport: Fix potential deadlock
      CVE-2025-38513: wifi: zd1211rw: Fix potential NULL pointer dereference in zd_mac_tx_to_dev()
      CVE-2025-38514: rxrpc: Fix oops due to non-existence of prealloc backlog struct
      CVE-2025-38515: drm/sched: Increment job count before swapping tail spsc queue
      CVE-2025-38540: HID: quirks: Add quirk for 2 Chicony Electronics HP 5MP Cameras
      CVE-2025-38542: net: appletalk: Fix device refcount leak in atrtr_create()
      CVE-2025-38546: atm: clip: Fix memory leak of struct clip_vcc.

Best regards,
Ulrich Hecht
</pre>
      <br>
      <fieldset class="moz-mime-attachment-header"></fieldset>
      <pre wrap="" class="moz-quote-pre">
-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#19754): <a class="moz-txt-link-freetext" href="https://lists.cip-project.org/g/cip-dev/message/19754">https://lists.cip-project.org/g/cip-dev/message/19754</a>
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.cip-project.org/mt/114765008/7669380">https://lists.cip-project.org/mt/114765008/7669380</a>
Group Owner: <a class="moz-txt-link-abbreviated" href="mailto:cip-dev+owner@lists.cip-project.org">cip-dev+owner@lists.cip-project.org</a>
Unsubscribe: <a class="moz-txt-link-freetext" href="https://lists.cip-project.org/g/cip-dev/unsub">https://lists.cip-project.org/g/cip-dev/unsub</a> [<a class="moz-txt-link-abbreviated" href="mailto:kazunori.kobayashi@cybertrust.co.jp">kazunori.kobayashi@cybertrust.co.jp</a>]
-=-=-=-=-=-=-=-=-=-=-=-

</pre>
    </blockquote>
    <p>I ran into the following compilation error
      with omap2plus_defconfig applied in this kernel version.</p>
    <p><span
style="color: rgb(209, 210, 211); font-family: Monaco, Menlo, Consolas, &quot;Courier New&quot;, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: none; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgba(232, 232, 232, 0.04); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">| /buildbot/build_daily_emlinux_am335xevmsk_latest_dev/build/build_am335x-evmsk_emlinux_core-image-weston/tmp-glibc/work-shared/am335x-evmsk/kernel-source/drivers/media/platform/omap3isp/ispccdc.c: In function 'ccdc_lsc_config':
| /buildbot/build_daily_emlinux_am335xevmsk_latest_dev/build/build_am335x-evmsk_emlinux_core-image-weston/tmp-glibc/work-shared/am335x-evmsk/kernel-source/drivers/media/platform/omap3isp/<a class="moz-txt-link-freetext" href="ispccdc.c:452:3">ispccdc.c:452:3</a>: error: implicit declaration of function 'dma_sync_sgtable_for_cpu'; did you mean 'dma_sync_single_for_cpu'? [-Werror=implicit-function-declaration]
|    dma_sync_sgtable_for_cpu(isp-&gt;dev, &amp;req-&gt;table.sgt,
|    ^~~~~~~~~~~~~~~~~~~~~~~~
|    dma_sync_single_for_cpu
|   CC [M]  drivers/media/rc/keymaps/rc-avermedia-a16d.o
| /buildbot/build_daily_emlinux_am335xevmsk_latest_dev/build/build_am335x-evmsk_emlinux_core-image-weston/tmp-glibc/work-shared/am335x-evmsk/kernel-source/drivers/media/platform/omap3isp/<a class="moz-txt-link-freetext" href="ispccdc.c:461:3">ispccdc.c:461:3</a>: error: implicit declaration of function 'dma_sync_sgtable_for_device'; did you mean 'dma_sync_single_for_device'? [-Werror=implicit-function-declaration]
|    dma_sync_sgtable_for_device(isp-&gt;dev, &amp;req-&gt;table.sgt,
|    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
|    dma_sync_single_for_device</span></p>
    <p>It seems caused by the following change.</p>
    <p><a class="moz-txt-link-freetext" href="https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commit/3483db997d491ba78957eb04743f6bb2ecc242aa">https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commit/3483db997d491ba78957eb04743f6bb2ecc242aa</a></p>
    <p>This change seems merged from the 5.4 based kernel, but some
      other dependencies would also be needed to pass the compilation.</p>
    Regards,<br>
    Kazunori
    <pre class="moz-signature" cols="72">-- 
Kazunori Kobayashi
Cybertrust Japan Co., Ltd.
<a class="moz-txt-link-freetext" href="https://www.cybertrust.co.jp/">https://www.cybertrust.co.jp/</a></pre>
  </body>
</html>

--------------hR0ZH7PGO2kJnCPSW0cUw3FB--

