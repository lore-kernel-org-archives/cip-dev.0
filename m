Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96268EB3659
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 02:44:34 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9834.1772505871489298413
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Mar 2026 18:44:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=QyCot0Vx;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=acWh6na/;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.53, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1772505846; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ovNZw9V8IlVru67vvsiK/13fj6MzkExE4ywcEgaNGezI9rmnPQKs3FSJajs+AwnhM1
    VNuyRZAkAQ7E9YJMAqBGrDV87bx7SW5PuK5WfIWWh2hSgfB4O4HWhxcY+jhmCZ0sOXxt
    a/tgLA+G4NDh4+J0W8i3nBoNgKe18iOuajfGDlihjaMDrCVrfRPJGnTT1ccagyLa8dvr
    GP9ejyopAtnFwFo+8mwfQOTF0ACN75UuO7tJ1dVKXLlf5T45SNwiSb4MCVA+PPmmSWSm
    6LC9DSgzE0iej720wxzHaaMk9n1kPToPKWf4flv5f7mVELF+qeo0omxX8daT+LSUlJIj
    Mfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1772505846;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=URuvQFE5nsBzPKurgGW14Tni3RCioMOFmlj3M/SGmts=;
    b=WUAVoheP7dcIMmuUy1DfoqdTCK/37dq2QBIzkrEiigofw7iEFRyKjf0gZP41gDjtGP
    AXZvS0p7JNq43I0ThEtysOmdJaNGcPGp53oG3YMLtys7WVYkAFGwbqLLZF0ElWLHqLCX
    IRE8qXKWKml6HmfkXzaR1/dR6toJ2dngJKAiJH5Z1lLvBeTDRoHhDzsEJMGUsWnOBCZ5
    VJAQ2dZnforlvc/Wx0+WK3h7jZJrYiF9eb+IZzwmDuGT7WGCY8d0S5TPS5mcfzwwX9Qw
    sFfoMy10fKomed/IcDalCKmF2Hti3njIbGgb7H1q9XWdzHmEp+ETduUPKj5oC6WYoxt1
    GAhg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1772505846;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=URuvQFE5nsBzPKurgGW14Tni3RCioMOFmlj3M/SGmts=;
    b=QyCot0VxC8AIMx6NKzou+zu90O60j/SliElk/ciJ8CxLHnWzreFQyu3WOdwXkTuSg2
    wdkn9kmfRjB1Mk184zvpj+rsTNFjigA9sD3vpok0nGnhslDJ+jPWkiAlrog0D/sLnGhU
    xpoGt2036Jzk/Qp3NXW/Bhp10b2yMYMJVyuhvLKd3UIkTuVB+VlfBu7M81bHuRW8soyO
    AnSxXXz/vweHYWr3sFXrDpa4cIBabfvQpEiNPlNZksUKsS17IdKyxVGfxXIcGCpkeOGG
    kgLE4xj7Vt+xF1YUCmtf59mKgzh25cahMEJPEhgsyFRoc0OydzUapigyji0LXGpGkKvM
    Mxog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1772505846;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=URuvQFE5nsBzPKurgGW14Tni3RCioMOFmlj3M/SGmts=;
    b=acWh6na/g7fTMjJ2E5LVzS/uiWcWIHSGH7tE+tfw1tV2KbvYaXM9DdbA/lZCn0Oqxi
    MaDiNIblscqREbokZwBg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGvseMiA=="
Received: from open-xchange-core-mw-gw-16.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z92cbd2232i5taY
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 3 Mar 2026 03:44:05 +0100 (CET)
Date: Tue, 3 Mar 2026 03:44:05 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <881298778.150695.1772505845171@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip108
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 55394
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 02:44:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22040

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip108. The linux-4.4.y-cip tree's base version has been updated to v4.4-st73. The trees are up-to-date with kernel 4.19-st13.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip108:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      c194dfd3d2bb480d3f50ed8887f84a61066493c7
    Fixed CVEs:
      CVE-2022-3526: macvlan: Fix leaking skb in source mode with nodst option
      CVE-2023-54207: HID: uclogic: Correct devm device reference for hidinput input_dev name
      CVE-2023-54321: driver core: fix potential null-ptr-deref in device_add()
      CVE-2025-39702: ipv6: sr: Fix MAC comparison to be constant-time
      CVE-2025-71162: dmaengine: tegra-adma: Fix use-after-free
      CVE-2025-71185: dmaengine: ti: dma-crossbar: fix device leak on am335x route allocation
      CVE-2025-71186: dmaengine: stm32: dmamux: fix device leak on route allocation
      CVE-2025-71188: dmaengine: lpc18xx-dmamux: fix device leak on route allocation
      CVE-2025-71190: dmaengine: bcm-sba-raid: fix device leak on probe
      CVE-2025-71191: dmaengine: at_hdmac: fix device leak on of_dma_xlate()
      CVE-2025-71194: btrfs: fix deadlock in wait_current_trans() due to ignored transaction type
      CVE-2025-71196: phy: stm32-usphyc: Fix off by one in probe()
      CVE-2025-71199: iio: adc: at91-sama5d2_adc: Fix potential use-after-free in sama5d2_adc driver
      CVE-2025-71222: wifi: wlcore: ensure skb headroom before skb_push
      CVE-2025-71224: wifi: mac80211: ocb: skip rx_no_sta when interface is not joined
      CVE-2026-22999: net/sched: sch_qfq: do not free existing class in qfq_change_class()
      CVE-2026-23001: macvlan: fix possible UAF in macvlan_forward_source()
      CVE-2026-23011: ipv4: ip_gre: make ipgre_header() robust
      CVE-2026-23033: dmaengine: omap-dma: fix dma_pool resource leak in error paths
      CVE-2026-23038: pnfs/flexfiles: Fix memory leak in nfs4_ff_alloc_deviceid_node()
      CVE-2026-23058: can: ems_usb: ems_usb_read_bulk_callback(): fix URB memory leak
      CVE-2026-23060: crypto: authencesn - reject too-short AAD (assoclen<8) to match ESP/ESN spec
      CVE-2026-23061: can: kvaser_usb: kvaser_usb_read_bulk_callback(): fix URB memory leak
      CVE-2026-23064: net/sched: act_ife: avoid possible NULL deref
      CVE-2026-23071: regmap: Fix race condition in hwspinlock irqsave routine
      CVE-2026-23073: wifi: rsi: Fix memory corruption due to not set vif driver data size
      CVE-2026-23074: net/sched: Enforce that teql can only be used as root qdisc
      CVE-2026-23075: can: esd_usb: esd_usb_read_bulk_callback(): fix URB memory leak
      CVE-2026-23076: ALSA: ctxfi: Fix potential OOB access in audio mixer handling
      CVE-2026-23080: can: mcba_usb: mcba_usb_read_bulk_callback(): fix URB memory leak
      CVE-2026-23084: be2net: Fix NULL pointer dereference in be_cmd_get_mac_from_list
      CVE-2026-23087: scsi: xen: scsiback: Fix potential memory leak in scsiback_remove()
      CVE-2026-23089: ALSA: usb-audio: Fix use-after-free in snd_usb_mixer_free()
      CVE-2026-23090: slimbus: core: fix device reference leak on report present
      CVE-2026-23095: gue: Fix skb memleak with inner IP protocol 0.
      CVE-2026-23098: netrom: fix double-free in nr_route_frame()
      CVE-2026-23101: leds: led-class: Only Add LED to leds_list when it is fully ready
      CVE-2026-23103: ipvlan: Make the addrs_lock be per port
      CVE-2026-23108: can: usb_8dev: usb_8dev_read_bulk_callback(): fix URB memory leak
      CVE-2026-23120: l2tp: avoid one data-race in l2tp_tunnel_del_work()
      CVE-2026-23121: mISDN: annotate data-race around dev->work
      CVE-2026-23125: sctp: move SCTP_CMD_ASSOC_SHKEY right after SCTP_CMD_PEER_INIT
      CVE-2026-23133: wifi: ath10k: fix dma_free_coherent() pointer
      CVE-2026-23146: Bluetooth: hci_uart: fix null-ptr-deref in hci_uart_write_work
      CVE-2026-23164: rocker: fix memory leak in rocker_world_port_post_fini()
      CVE-2026-23167: nfc: nci: Fix race between rfkill and nci_unregister_device().
      CVE-2026-23176: platform/x86: toshiba_haps: Fix memory leaks in add/remove routines
      CVE-2026-23193: scsi: target: iscsi: Fix use-after-free in iscsit_dec_session_usage_count()
      CVE-2026-23209: macvlan: fix error recovery in macvlan_common_newlink()
      CVE-2026-23216: scsi: target: iscsi: Fix use-after-free in iscsit_dec_conn_usage_count()

Best regards,
Ulrich Hecht

