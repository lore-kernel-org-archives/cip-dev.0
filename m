Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4784BC46467
	for <webhook@archiver.kernel.org>; Tue, 10 Jan 2023 08:15:04 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
 by mx.groups.io with SMTP id smtpd.web10.98711.1673338493653115698
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Jan 2023 00:14:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=Vk6jqSxt;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.221, mailfrom: uli@fpond.eu)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1673338487;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=FiqSrZNVdKTULK8tbhXAUQDeb6r3bOMWCvd5e643A1U=;
    b=Vk6jqSxtVnQzkyHPAntahutpF/72D5Vjvz30FwmZ7FsQ1UjY9/xVoACew0cfCkbqGl
    FyZ8M8RpdWvurDI4Le7hHrKR70HAYwXDKJnn2fbvYcquRhykXZeJ9VW5gmF73ZqnL1Ez
    UAcX6iHZ8FpMbNOiTUgfInZ/GikG5pKa6BnHC4vaJeuS3OAbab4rCM5G3SvF5K3AmUq8
    qgcVymdD6gEpbJV941nV6thpx5z/+x1boxshTYrz6x0nXB+svayw1xZ0HnWc5wE/0E8L
    eZmaDHydV5DQ2d/pGdzsnJJik8V9ssD1CtvxiSlW9bU1AivZHe2rKX0EGJ5WIzQuiP3Z
    PkNg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCt/7VzVw=="
X-RZG-CLASS-ID: mo00
Received: from ox-live-app201.back.ox.d0m.de
    by smtp-ox.front (RZmta 48.2.1 AUTH)
    with ESMTPSA id y28384z0A8Eljse
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 10 Jan 2023 09:14:47 +0100 (CET)
Date: Tue, 10 Jan 2023 09:14:47 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Message-ID: <588609118.480377.1673338487702@webmail.strato.com>
In-Reply-To: <Y7w4dfYgh7d10IdS@duo.ucw.cz>
References: <Y7w4dfYgh7d10IdS@duo.ucw.cz>
Subject: Re: [cip-dev] 4.4 steps towards release
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev33
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Jan 2023 08:15:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10334


> On 01/09/2023 4:53 PM CET Pavel Machek <pavel@denx.de> wrote:
> For 4.4 -st release, I'd suggest these steps:
> 
> - sign off the patches

Done.

> - push that to linux-4.4.y-st-rc @ kernel.org

Done.
What is the numbering scheme for linux-4.4.y-st, anyway? The current HEAD doesn't have a version number.

> - update v4.4.org

Done.
(For those playing along, that's at https://gitlab.com/cip-project/cip-kernel/lts-commit-list/-/raw/master/v4.4.org )

> For patches that were applied automatically, I don't think we need to
> additional review. For the others, I guess you should send list to
> cip-dev, and someone will take a look.

These are the patches I had to touch up manually:

** m | 9cb1ee33e a36e50 .+ | drm/msm/hdmi: check return value after calling platform_get_resource_byname()
** m | c132f2ba7 ddbd89 o  | swiotlb: fix info leak with DMA_FROM_DEVICE
** m | fd97de9c7 901c72 o  | Reinstate some of "swiotlb: rework "fix info leak with DMA_FROM_DEVICE""
** m | 136b47994 190cc8 o  | tcp: change source port randomizarion at connect() time
** m | 05a12e5c4 c579bd o  | tcp: add some entropy in __inet_hash_connect()
** m | 576696ed0 b2d057 o  | secure_seq: use the 64 bits of the siphash for port offset calculation
** m | 2ed413f14 9e9b70 o  | tcp: use different parts of the port_offset for index and offset
** m | aa7722529 ca7af0 o  | tcp: add small random increments to the source port
** m | dd82067bd e92614 o  | tcp: dynamically allocate the perturb table used by source ports
** m | 3c78eea64 4c2c8f o  | tcp: increase source port perturb table to 2^16
** m | a81a6b204 e81613 o  | tcp: drop the hash_32() part from the index calculation
** m | ed71adaa8 17d3df o  | cifs: don't send down the destination address to sendmsg for a SOCK_STREAM
** m | 6eb181a64 60deb9 o  | wifi: mac80211: Fix UAF in ieee80211_scan_rx()
** m | e2b46cd57 81225b o+ | ipvlan: Fix out-of-bound bugs caused by unset skb->mac_header
** m | f8a1ac3db 544042 .+ | can: gs_usb: gs_can_open(): fix race dev->can.state condition
** m | 146357504 c292a3 o+ | nvme: Fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls for nvme devices
** m | 27c2c6d35 1b24a1 .+ | clk: iproc: Do not rely on node name for correct PLL setup
** m | bb63454b6 21a87d o  | nilfs2: fix NULL pointer dereference at nilfs_bmap_lookup_at_level()
** m | b63026b5e 723ac7 o  | nilfs2: replace WARN_ONs by nilfs_error for checkpoint acquisition failure
** m | c4a13e588 56e696 o  | ALSA: hda: Fix position reporting on Poulsbo
** m | a9043a24c d325dc o  | nilfs2: fix use-after-free bug of struct nilfs_root
** m | cf3166691 620d5e .+ | wifi: rtl8xxxu: tighten bounds checking in rtl8xxxu_read_efuse()
** m | c202cda08 668a8f o+ | drm/mipi-dsi: Detach devices when removing the host
** m | 9183a37d3 551e32 .+ | HSI: omap_ssi_port: Fix dma_map_sg error check
** m | 7b0efe753 1c78f1 .+ | media: xilinx: vipp: Fix refcount leak in xvip_graph_dma_init
** m | 2319e8f80 9c6e09 o+ | ata: fix ata_id_has_devslp()
** m | e01f64a34 630624 o+ | ata: fix ata_id_has_dipm()
** m | d96732831 898ec8 o+ | dmaengine: ioat: stop mod_timer from resurrecting deleted timer in __cleanup()
** m | 508a9b8a8 110024 o  | openvswitch: Fix double reporting of drops in dropwatch
** m | 56761647e 3fd7bf o  | can: bcm: check the result of can_send() in bcm_can_tx()
** m | 0adda6e12 c44f15 .+ | arc: iounmap() arg is volatile
** m | e1b5b0619 1f65ea .+ | media: vivid: dev->bitmap_cap wasn't freed in all cases
** m | 795afe0b9 8bdc2a o+ | net: sched: Fix use after free in red_enqueue()
** m | d81370396 d37de9 o+ | btrfs: fix ulist leaks in error paths of qgroup self tests
** m | dc30e05bb 3aff8a o+ | Bluetooth: L2CAP: Fix use-after-free caused by l2cap_reassemble_sdu
** m | b670996ca 038ee4 o  | serial: 8250: 8250_omap: Avoid RS485 RTS glitch on ->set_termios()
** m | 8d4ceb13d e103ba o  | net: usb: qmi_wwan: add Telit 0x103a composition
** m | 89840b12c f7e942 o  | btrfs: qgroup: fix sleep from invalid context bug in btrfs_qgroup_inherit()
** m | 2f2c59506 f0a0cc o  | nilfs2: fix NULL pointer dereference in nilfs_palloc_commit_free_entry()
** m | 02c468589 17b57b o  | arm: dts: rockchip: fix node name for hym8563 rtc
** m | 1a1d9be7b ad7f40 .+ | xen/netback: Ensure protocol headers don't fall in the non-linear area
** m | b41eab579 74e7e1 .+ | xen/netback: don't call kfree_skb() with interrupts disabled
** m | a0e661a7d c981cd o+ | mmc: sdhci: Fix voltage switch delay
** m | 4749c5cc1 45fecd .+ | gpio: amd8111: Fix PCI device reference count leak
** m | 62ae69ea7 743117 o+ | tipc: Fix potential OOB in tipc_link_proto_rcv()
** m | fbc70a04a 7dfa76 .+ | xen/netback: fix build warning
** m | cb0f2530f 16d055 o  | udf: Discard preallocation before extending file with a hole
** m | eee369a46 1f3868 o  | udf: Fix extending file within last block
** m | bd1c152be 94a7ad .+ | media: vivid: fix compose size exceed boundary
** m | c2fe0cac3 c2f292 o+ | wifi: brcmfmac: Fix error return code in brcmf_sdio_download_firmware()
** m | 3f418ad65 39c1eb o+ | Bluetooth: hci_core: don't call kfree_skb() under spin_lock_irqsave()
** m | 52dc66bf4 415565 o+ | scsi: fcoe: Fix transport not deattached when fcoe_if_init() fails
** m | 694bd441a 04ba54 .+ | crypto: img-hash - Fix variable dereferenced before check 'hdev->req'
** m | 2210b22c7 02cd30 .+ | cxl: fix possible null-ptr-deref in cxl_pci_init_afu|adapter()
** m | c3595370a 6a46bf o  | binfmt_misc: fix shift-out-of-bounds in check_special_flags
** m | 548d04953 cfd3ff .  | clk: st: Fix memory leak in st_of_quadfs_setup()
** m | 215d58e8c 1db1f3 o  | HID: wacom: Ensure bootloader PID is usable in hidraw mode
** m | 5f578bbe1 8508fa .  | ALSA: line6: correct midi status byte when receiving data from podxt
** m | 887f47cf9 341097 o  | md: fix a crash in mempool_free

Everything else was either
- ignored because it doesn't apply or causes regressions, and was deemed non-essential, or
- included because it applied cleanly and doesn't cause regressions.

See v4.4.org for details.

There are also a few fixes for previous backports that need to be reviewed:

e80d1e591dbba xen/gntalloc: fix backport of "xen/gntalloc: don't use gnttab_query_foreign_access()"
baf4fff4a69b7 Revert "hwmon: (sch56xx-common) Replace WDOG_ACTIVE with WDOG_HW_RUNNING"
a5387f2e581e5 xen/blkfront: fix backport of "xen/blkfront: don't use gnttab_query_foreign_access() for mapped status"

> For updating 4.4-cip tree, just checkout linux-4.4.y-cip and merge
> -st.

Will do.

CU
Uli

