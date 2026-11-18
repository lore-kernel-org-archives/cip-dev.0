Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2500.1795040588777079668
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 14:23:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20260707.gappssmtp.com header.s=20260707 header.b=HCpuOkKZ;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.52, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67da69e7c31so1487633d50.3
        for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 14:23:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795040588; cv=none;
        d=google.com; s=arc-20260327;
        b=WHYKqlQZfGsgXajS985G039X1tTxPBCQIJ5RYdOAV0mF2AqKvYBusYiDmQDYyBKPha
         7eGLxSC7sngtZGPR11y3RydlI2vvBUHRHtWOQ/+8Yd5feeWB6xFeizTq+x3MXIm5LhdO
         AAH1JLrkHZS59ZaGLwMtsvu9UuUXYw6t8O4CWddzu84EnNKKYPIHShnbrf2hAU71onyl
         r3VHanTCIX7ucbcaHqcmaLWYcXf1WXnfhXtlAVQEklFjPyfrFGd7y1C5VJfH+QnDIj9H
         V4eqy+1n0y6hIC5nmofQG3G2UVX54q7oDFkhJsWKLeBN6bRw6/qjRnyyEQKU9cvMMkXn
         QFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=dvdec+IyNbikduPFgA8hs/dkCaGdlzon9yl3mPJRz7A=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=S/FwvHvXhu750kldEEGc2o/QHzziggDOYnA7QN0TkEcw3a2esZZXouurk0xzrr8lbz
         YGoxJFxS9pKlGseFnB36YP+uXuoVOR27VoPnkTUWNT884aEvqO1z89fh6rWAyTga/Rbc
         xZPkJj9U2nq3YXmK6dHftKE38vPCyvllvdlo227gRc84Hb+6BKKKUV0nw5iiy9+iYUNL
         4IMrJB/JdohV2vvCHzr5FlWPNyWUsVO2sfTgvMZhJwE2pn1DzuEkGzhOf9GUZPNYBl8Z
         A3IiHwqO6q+Skrwh0aW/6dqc1Oh3kh1O9aNhM0DXvdtq8iZeRwyUwUI6Q3mGG9z7A5Q4
         NgAw==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20260707.gappssmtp.com; s=20260707; t=1795040588; x=1795645388; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dvdec+IyNbikduPFgA8hs/dkCaGdlzon9yl3mPJRz7A=;
        b=HCpuOkKZ6pNUSbNlgvLIxOdrjqqtRnGmrGgXXBD/PCp9A9LQ4RUV3qYVhwKrsykazB
         3FSezktPhsbhJIVOxxGZZETnW/oiYhsORy2jLRzB+Mu0MF4uZ6R1COerkeug16cGBKQm
         r+GFCqIY4f5YYfnvqcsG/TQwn41yZu9iNR0T9pyRMA/+YBCrgs/2VyANT8l5dX9LuZ0g
         AoVbeNbSXSA+XTunT8j7xmRROQ1MCDln0OUSBdLCZrHRXr196VVhCIee1BNoWsOrZHQU
         1mgo9A00+uqNtblyljskDgAhOGuKlErdEMm2iUycAOAxTsO/+9RxILLlXf+S/V0GNSWB
         GYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795040588; x=1795645388;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dvdec+IyNbikduPFgA8hs/dkCaGdlzon9yl3mPJRz7A=;
        b=QMPQa+SaCo7Gn0HBbkAzlOqDbZf2eyEw1y4OccOSiU4JbeC9DVGhJVsQLPMf4Xcrt2
         z4isq8HF8PWGMvIEJ54ph5GbIjBH2CNpHIlBVOjaK2jf8RU6dWje5dQ1F6g7IK2mYhCK
         ucj7mzgZlsJ3RoNNrRPM37xTL5GZcw+erX/HL+vp6dQ1CBMmuePr6Q169/EMtyTCF2iN
         hy61l9T2BzhLo0Wdzwims27dNUnP9f+Tmoesxi1sVBsBohZJcpcQGDQ4IBsNoVKV2N7w
         FEg0FuqvPfnfiF8aBMd3zzGbwTmEDBTF4bT6pLHBZbyqGA2uMpy9Vkyi/ygHkseSBu18
         jPSw==
X-Gm-Message-State: APuU4Z+aBM4aKrcHvMqid27zwBlKq0V0h1dFjXN2M9foYd32t48EtoCy
	Ri6FmG2W1R6E0NMvRc2rrY+8edgFiWBniUBJAVThMi0MWUZT8qc5MnpxlTy+T7pNsI0FVimhBKi
	nHi6E4TLMsfl4oATKkSr78vD6QT7oZD9CROep23PWuygP/2uZN/VF/gYMIA==
X-Gm-Gg: AZFdTZfnuPj8rthEte73jKhsd9NT79AqWmcAAbA1bzFgxqX8IruwRQabjo/mfq7qzEG
	NDogyLT1zsPoTEz0rnhQOB0FZC9BRyZnYKrOzLAyFgzeMPcXR3+5RYnVaUR5wvxhn27WlmJNbJD
	0iO/bl/D++v196onDe6E0+EDP4mMAZCztNnG6DLlgmmrJFxBbtK05qOoFKzfr9JnRpQFfh7lCp4
	a32d/bezAx7A2TN2xj1QoYA0ZGkRlhfa9Phnn1MG9u9B0LEk7D2By+B8jbj6124XbEb9OrW+o1b
	oidSXrArEhImdb2nImj5JyPwN3C5aNGSHp+icWezn2+IXqwH3iDbwKVFwHzxjq0VujLMIzw+wyn
	eicEvezCvKj8Is0URHRoYOpc7DyTX9CsuqIHkOJ5kRHqILLw7mBUo4JNx7sh0oB1yVg/BT902bf
	FanuTJwajw
X-Received: by 2002:a05:690e:1904:b0:67d:b197:82eb with SMTP id
 956f58d0204a3-67dd4577969mr2366608d50.70.1795040587271; Wed, 18 Nov 2026
 14:23:07 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 19 Nov 2026 07:22:31 +0900
X-Gm-Features: AclHuK_5lWi_KrcovKnxtr5IwiS06zNL7K8l1zYyVNUDN3XBr7g6kWBIO_wCzXM
Message-ID: <CAODzB9q9ieR9nEhh=sCVdOFJU+a2q3dRJZQOPkf=3QWXqzuBwA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 22:23:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25003

Hi!

It's this week's CVE report.

This week reported XXX new CVEs and XXX updated CVEs.

* New CVEs
CVE-2026-99289: ksmbd: fix app-instance non-durable supersede session UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99289

Introduced by commit 16c3064 ("ksmbd: handle durable v2 app instance
id") in v7.2-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f728cfee6929057087c303d07d7a6a7c61196b48]
stable/7.3: [a5b190b352b0ba85f4debe436f42950ced10fadb]

CVE-2026-99290: ksmbd: fix use-after-free after a failed durable reconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99290

Introduced by commit c8efcc7 ("ksmbd: add support for durable handles
v1/v2") in v6.9-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [248b5819591c577727930e4e255a455235fab50a]
stable/6.12: [5078a4e41b29acdf6be52e4a7cc8a59c2a72a471]
stable/6.18: [bd47ee501b6ac4a26ae41f780a43b7967302a269]
stable/7.3: [edacf65866a9f397438d5b9ff9f43312b29b4b3c]

CVE-2026-99291: ksmbd: fix SMB2 CREATE response buffer overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99291

Introduced by commit 8f1b796 ("ksmbd: add AAPL kAAPL_SERVER_QUERY
create context support") in v7.3-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [713c31a3a225b6239a37ac7fbfb394567f8b3519]
stable/7.3: [824a572c0f909ca51fdb7e18e4eee33ca7896c7a]

CVE-2026-99292: smb: client: fix slab-out-of-bounds write in
id_mode_to_cifs_acl()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99292

Introduced by commit 7ee0b4c ("cifs: fix hardcoded default security
descriptor length") in v3.8-rc1.
Introduced by commit f506550 ("cifs: Retain old ACEs when converting
between mode bits and ACL.") in v5.12-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a377a3645c7d0246af0bc4ef24db94bb2670bdde]
stable/6.12: [cde80904e285a7ac29ba2e06bc23a60b09b05f54]
stable/6.18: [ba57bfe1a9fa1566757cd3f3310ccdf88f4b7673]
stable/7.3: [be1bcc9147facd85dc2ebe48688afde6d5590f10]

CVE-2026-99293: fuse: don't BUG when the copy buffer is exhausted

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99293

Introduced by commit c090c8a ("fuse: Add io-uring sqe commit and fetch
support") in v6.14-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1338aae7b4054e26f322155423f6aba90aeea23]
stable/6.18: [61adcab593ff6bb806ba09df8c2c3d7e19edc908]
stable/7.3: [10a58bf0107a02854584ed79281d05a84d62d900]

CVE-2026-99294: netfilter: nft_fwd_netdev: use recursion counter in
neigh egress path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99294

Introduced by commit f87b946 ("netfilter: nft_fwd_netdev: Support
egress hook") in v5.17-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d47b55b36d2ec73fe6901212c8b28a593c3b27c]
stable/6.18: [fcacd948b10a351aa128acd3c2c4cee62d1ea677]

CVE-2026-99295: smb: client: stop processing a read response after a
receive error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99295

Introduced by commit d08089f ("cifs: Change the I/O paths to use an
iterator rather than a page list") in v6.3-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [51efca72345acdbedc4af76782d464bd15ba50ff]
stable/6.12: [af78baeacd731a98531eaa3103bfe03f147cffb7]
stable/6.18: [ecc327edd96a65ac177379664cc0972d8a23dfa4]
stable/7.3: [558cb79cb242ce7ca8b32c4b39412d125879e8f2]

CVE-2026-99296: libceph: bound mon_command ack decode to front len

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99296

Introduced by commit 6305a3b ("libceph: support for blacklisting
clients") in v4.9-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62b41a16d8603d4d809fda212f15c3e9c783a82b]
stable/6.12: [c6696ac94c8c3ad79a9fa57fc334af2dc1a1f72e]
stable/6.18: [04a04953b4828bfd8efd4ea3e7e9ad7dac5b083b]
stable/7.3: [be9fa57665efae4060d17ab21675c1c033d54a80]

CVE-2026-99297: media: em28xx: fix double free in em28xx_alloc_urbs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99297

Introduced by commit d571b59 ("media: em28xx: don't use coherent
buffer for DMA transfers") in v4.17-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd427b8adae437cac78a2332241a03cac56e95c2]
stable/6.12: [9bc203322dbc8c2fe608555e387d4b493c4da2ef]
stable/6.18: [ecf511b8157e0648080bdae37f4f2eb98328c4b2]
stable/7.3: [660c91b3100c949a0c33faf9d659d1c786ccd1ee]

CVE-2026-99298: net: ipv4: add zero check for snd_cwnd_clamp

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99298

Introduced by commit 814d488 ("tcp: fix the timid additive increase on
stretch ACKs") in v3.19.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [363c8c79220d0db4d65dcd570529ddda15067cb5]
stable/6.12: [0a978359afe76aadfbc57acee88c08999543a7ae]
stable/6.18: [f9af5772ff0ef32fa4ffb43fc10861823e6a06e3]
stable/7.3: [b8111914eb7cb1d269c1dec4a4958468ac7e17a4]

CVE-2026-99299: media: em28xx: reject audio endpoint with zero packet size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99299

Introduced by commit 1b3fd2d ("[media] em28xx-audio: don't hardcode
audio URB calculus") in v3.14-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aebfe430ba885d2f8fc882d7a6d60a7fdbe535d8]
stable/6.12: [ffafe6ecce8794ed821689b874964da3ab9d0869]
stable/6.18: [dc0072c1b40fc376c6cbe821de947f3744ab254b]
stable/7.3: [e282da1201f16ff75b95f85cc0b0c1de7ff59731]

CVE-2026-99300: media: go7007: only set audio_enabled if
go7007_snd_init() succeeded

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99300

Introduced by commit 866b869 ("Staging: add the go7007 video driver")
in v2.6.28-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2eacf058d2dbb0ae3aaf576459da9e5f2b6bbfbd]
stable/6.12: [1db31d3ddc386a8094a34e186243e26ce8fd175d]
stable/6.18: [8e2fc3941b4005eaeef0a6b69b44a8a4941b57ab]
stable/7.3: [5d17cf3d380d56018a5ae8ef03af8df12ed910e9]

CVE-2026-99301: virtio_net: atomically disable rx mode work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99301

Introduced by commit b9f7425 ("virtio-net: convert rx mode setting to
use workqueue") in v6.9-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1234707482053f1d1ac7c5756207d2c29057974c]
stable/6.12: [04d1e4fc965c8a4378093174e908800f400b7485]
stable/6.18: [c05c367e7a99521cd654b56042757979968b5644]
stable/7.3: [3f4c7168ee28e582314249d86833bd515b945196]

CVE-2026-99302: nvmet-rdma: reject short connection requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99302

Introduced by commit 8f000ca ("nvmet-rdma: add a NVMe over Fabrics
RDMA target driver") in v4.8-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [635e760169a87abf03874cd4636cd91b580cb427]
stable/6.12: [22d0eb8d7aa4e45d22491d7cc1327010f19c86b9]
stable/6.18: [36c3af0e94b6c385c4934c028cbca27e138ae1ee]
stable/7.3: [c17d443d1e984a0c0840692c6435cdc455936160]

CVE-2026-99303: speakup: Fix NULL pointer dereference on VT switch + selection

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99303

Introduced commit is not determined.Fixed in v7.4-rc1.


Fixed status
mainline: [e1301ab8a8411fccc7effe0711fc09939a94953c]
stable/6.12: [0400bff986064836dd9e7adb4e1c19b0bf639af0]
stable/6.18: [1a40cbb9d83ad8c669125554fcd73e626a00dc65]
stable/7.3: [cb1b95b98b63f10f38fb96a2ba17a9919017f916]

CVE-2026-99304: ceph: fix integer overflow in the snap trace bounds check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99304

Introduced by commit 963b61e ("ceph: snapshot management") in v2.6.34-rc2.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3bf89767e3ca9506f1c7167cac97c41ec254d42]
stable/6.12: [bf8f13872959af1d87e36b7d27096a09fdcf6e47]
stable/6.18: [f0dbd6b9b05e919ebab668f3479aebbcd2431fce]
stable/7.3: [25ae51760b751d170e29425b7851ee577e2cd5ba]

CVE-2026-99305: fbdev: udlfb: don't rebuild the mode list while the
framebuffer is in use

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99305

Introduced by commit 7d9485e ("Staging: udlfb: Add functions to expose
sysfs metrics and controls") in v2.6.34-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac9cfa552102b8e80e88c2872e80dc9cb5f07dda]
stable/6.12: [291010d5de1c9efc38e98c416b6230500bfae438]
stable/6.18: [1e13b8957510cfbc7367b3be1f08adc1757bb6d4]
stable/7.3: [4bc608af98a3da0fa0b17af67a64d0d11d625a1d]

CVE-2026-99306: ceph: reject mdsmaps that claim more than CEPH_MAX_MDS ranks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99306

Introduced by commit d517b39 ("ceph: reconnect to the export targets
on new mdsmaps") in v5.15-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1742590d2b2fc5fb217e1a9b520108f1fe282e5]
stable/6.12: [7931e6798f419bda9ac8cf0c095323eff90a7f52]
stable/6.18: [e9d72cf5d1bf5b4ddfe86707ada614973d75bf64]
stable/7.3: [0574e4aff8e4b28e0d5636204ed4ba2350b8701a]

CVE-2026-99307: ceph: require the dentry lease record to cover struct
ceph_mds_reply_lease

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99307

Introduced by commit 4ac4c23 ("ceph: decode alternate_name in lease
info") in v6.6-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7286b2ffe04d4b39b4e9884f714792589d94f316]
stable/6.12: [380bc69a0dbc50549cb196da40409aed69c84cfc]
stable/6.18: [5ab17ed54e8b7ca64a8d167a09d6a2c865ed51cc]
stable/7.3: [058e1c38722a6d5b0181f38fdec03d5da95c3ad1]

CVE-2026-99308: usb: xhci: Fix bounce buffer overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99308

Introduced by commit f9c589e ("xhci: TD-fragment, align the
unsplittable case with a bounce buffer") in v4.8-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [68c5cb7574c567e83ba95258cb146db95e069a87]
stable/6.12: [dab2792e136385bd34b36d2b95db94862ed902cc]
stable/6.18: [d0d15d7a11f2a45e5d29ab4780a094992d7a26a2]
stable/7.3: [e95ace4abebd564b50b856513e24853d35be06cd]

CVE-2026-99309: ksmbd: fix overflow in dacloffset bounds check in
build_sec_desc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99309

Introduced by commit 8f05411 ("ksmbd: fix heap-based overflow in
set_ntacl_dacl()") in v6.0-rc1.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [eb96e2a0e817807c48dc8387ca6a5249fdeae3a0]
stable/6.12: [bd92e03122f33c159b552867a4abc098d405dfed]
stable/6.18: [4f238380ea3803afdc815c615521c6f6b13989a3]
stable/7.3: [d1e92aa651caa352261fb3b78460b7722357835c]

CVE-2026-99310: nfsd: hold cl_lock in client_has_openowners()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99310

Introduced by commit 4eaea13 ("nfsd: improve client_has_state to check
for unused openowners") in v4.4-rc1.
Fixed in v7.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5336899b5491eaa2ac22c2925d87daab2b140eb3]
stable/6.12: [202b7a6c462daa55a9f4b01f0a25eca2b8d5f2e3]
stable/6.18: [540649cb8543472f6edfe9ae8b42c04aa3bd67e9]
stable/7.3: [a596d1979fcb4e5011d3d48ac4d927f81c9c9cab]

CVE-2026-99311: udf: fix return value for non-recorded-allocated
extents in udf_map_block()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99311

Introduced by commit c226964 ("udf: refactor inode_bmap() to handle
error") in v6.12-rc2.
Fixed in v7.4-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [0f242ca0878896df30292f4922700a32e8fdd039]
stable/6.12: [0d7f6c2b3c07fa239ebc169280eba9932cc56f46]
stable/6.18: [df713b82b4b9671c16b52b60f3412c677719e2b8]
stable/7.3: [f022984a4a1c18aa9c506790eb47da000dce95a7]

CVE-2026-99312: KVM: x86: Unconditionally reset MMU context when emulating INIT

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99312

Introduced by commit ed129ec ("KVM: x86: forcibly leave nested mode on
vCPU reset") in v6.1-rc7.
Fixed in v7.4-rc2.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [c7c288d178cb0b78d3464a616b16b1aa0b316049]
stable/6.12: [f55a3e4e08dc004b4bab7c1e9323d7e7e96e266a]
stable/6.18: [24f644ea26c2ebb7b14c3baa2aa92d37fde3095f]
stable/7.3: [d47bae9eb33b3ca0843a0954b7d0cafb354c99b0]

CVE-2026-99313: HID: logitech-hidpp: fix race condition when accessing
stale stack pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99313

Introduced commit is not determined.Fixed in v7.1-rc1.


Fixed status
cip/4.19-st: [4300864222750e850bdf34677dcae8fa6ec5c833]
cip/4.4-st: [2697a8eb1c9bc45d0d0c6327f04f67ba20bf447f]
mainline: [e2aaf2d3ad92ac4a8afa6b69ad4c38e7747d3d6e]
stable/5.10: [0fe696148d2c6486e52220aab822135ed7d05f38]
stable/5.15: [88effb7680aea4fc9afaf5780a706f5f30d3de42]
stable/6.1: [f427383e734e95af923ac470782ad9a3d1f0c276]
stable/6.12: [e320e65900f0e3bf2874e6f5091fec29384f4a60]
stable/6.18: [4ed6f5d94cc86af5e1d4a2f5cdaf565d4d58300d]
stable/6.6: [8f282d12550e3beaf3fea782b5befa65f78b3c78]

CVE-2026-99314: ALSA: us122l: Add missing NULL check in usb_stream_hwdep_mmap()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99314

Introduced by commit 030a07e ("ALSA: Add USB US122L driver") in v2.6.28-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5d3eb483fed59fc0f3b059b8b6a32cedc922360]
stable/6.12: [0f128b326d3defab6bf5c33c09e55addd87e74ec]
stable/6.18: [03d3690ba06713358cd8c89bbec090040c272438]
stable/7.3: [6fdd96fa2f7a70d61eeed166e520a990c40ff223]

CVE-2026-99315: ALSA: us122l: Fix NULL dereference at hwdep open and release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99315

Introduced by commit 030a07e ("ALSA: Add USB US122L driver") in v2.6.28-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [820e0050866942b5498488496462d12c6ce1c7a9]
stable/6.12: [3be1ac0b73e9bf73eec0000197d0177ebeb3cc79]
stable/6.18: [57dc5db514ab188a24cb300bda70a1ead3c9e479]
stable/7.3: [b21aa212c9ba4536e66d65783cc883951c95ba01]

CVE-2026-99316: ALSA: usx2y: Initialize idle URBs before submitting streams

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99316

Introduced by commit 030a07e ("ALSA: Add USB US122L driver") in v2.6.28-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ceb0d8c22473933099b46cec70639d0f1f7c68ad]
stable/6.12: [cc826d8f6074305af7bf1d2b7c13564d194db914]
stable/6.18: [1f32f490350fae3d64f60b5ab9b02e5254fa0a90]
stable/7.3: [aa91b5324b5c856e18a9d356df875b29fbedd33a]

CVE-2026-99317: ALSA: hwdep: Serialize DSP load requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99317

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aee83c204f80d56b4d55f53acdb8594308ddcd4a]
stable/6.12: [200bda52a9fd604e13c57d3a548639c13bdfb19c]
stable/6.18: [3634a1beb0395f02807d41a2edf4288732d3f90e]
stable/7.3: [1b94ca29b1edbbdb357c2c8a9163d1d1755e4ad2]

CVE-2026-99318: ALSA: bcd2000: Fix use-after-free of MIDI URBs on file close

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99318

Introduced by commit b47a222 ("ALSA: MIDI driver for Behringer BCD2000
USB device") in v3.16-rc1.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6c7bb1f0799591a62be75b9bcf84245b4f208b7]
stable/6.12: [791c259be56d05f90f7642df337f209c108003fa]
stable/6.18: [752eea15d0e67a468e484c1f166cdba694ba6de0]
stable/7.3: [a4c306eb3ba35a1e7201e25aef7e0537da609e72]

CVE-2026-99319: ALSA: usx2y: Refuse a retried DSP load after a failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99319

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f8101b6adc87a3ddbd51fcb6609251591758026]
stable/6.12: [1f9c4b6350ce31e3fccf2a82d47bf35b27167167]
stable/6.18: [02f8c4fd65f33243ad1f25a98f2af211f9fb7593]
stable/7.3: [8b21cc8bd182b49415faa24ea9f26b51eea96efb]


* Updated CVEs

CVE-2024-21963: iommu/amd: Force device table to maximum size

stable/6.12, stable/6.18, stable/7.3 were fixed.

Fixed status
stable/6.12: [e8f1f1ac434f24604d93ea3c8cbac513b2dead69]
stable/6.18: [046f0b83f18c6313f63419517bb4185e3e0d1a6e]
stable/7.3: [bdbbf5ad5d032e8cb4b5356d0f3970829f0309c0]

CVE-2025-38050: mm/hugetlb: fix kernel NULL pointer dereference when
replacing free hugetlb folios

stable/6.12 was fixed.

Fixed status
stable/6.12: [64e40bc15cacbe2e59e0f9140978d94d68e72738]

CVE-2026-89692: nfsd: clear CALLBACK_RUNNING on failed delegation recall queue

stable/6.12 was fixed.

Fixed status
stable/6.12: [3c13a8dda2048995dae656a2be1d34bbe46aaa52]

CVE-2026-89788: ksmbd: fix tree connection use-after-free in smb2_tree_connect()

stable/6.18 was fixed.

Fixed status
stable/6.18: [5f64ad5097ec2503c288e40d151d706b93b146cf]

CVE-2026-99272: smb: client: validate the data area in SMB2_read()

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [b949f6a0c08a57439334f39754ee7bd3c315d4a3]
stable/6.18: [082ae8a34170b7388106aa0897f47405f0824946]

CVE-2026-99275: smb: client: reject short SESSION_SETUP responses

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [136128f84f13849b732ffabf24c5ee891a2033d4]
stable/6.18: [9a0b6567936c3f8fef34c4f4a995f0a1473af7d0]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com
