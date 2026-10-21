Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11938.1792624925506257100
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Oct 2026 16:22:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=T9oO43R6;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.47, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6798d4ab549so1271767d50.0
        for <cip-dev@lists.cip-project.org>; Wed, 21 Oct 2026 16:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792624924; cv=none;
        d=google.com; s=arc-20260327;
        b=iIagRY88QE5GW2IU7YcekeX5TKd0gucuL4XaGXVq+Tl9ItPA62F42lrTILkioPXmxv
         8FAtA1/HTvhf+Vm5l4PphXb6Ho3LnpHH0gq9hPtiC2sMddglkxO7s4Uss5k0A6aZQCEE
         koa3tRt1HTxZxSHMn+dDbpp8v9MCysfNJICerwO/PytcbI+0Q/j6Eg6w35HG0/WYTWTf
         knYas8xn7kjkVI0XxMLjtoRu3LywuzQZRTxHH5NVDAB/NagFM0tLykbjAowXqhwQTIRI
         lTSL/wm0c1YgoVvIvEe7Geqn4blbbCCxZGNedvOcCj4qwOyaCNKUzjRtNk2pyI7hC4Cf
         G8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=XdpqIQAq5K+9dYzKCn1F+lyB6K6yCLid2n7WFpjVLIg=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=fPx73tecZiYbcGJk2k+bEoo4VAYLfp4YAadgQ933ueMeh1iGYQ7KlR47vausTBaFYK
         ngl6Rq78Ccs8ca5iTxTQjJcfAoBqIEa55q6NqAOori6prBtKcv/1P0vuh1og0o8YTvHe
         ttcI4m3UmB+Y8I+CYP1iIKBs4Px9wpwew+OCrL1udLch7/LY11M5mkuoIuoElCT6l/Ri
         cXRJfIJqWVo3sTLtwNlOnv7zpn4XaPBfD6zoec28MqdoUIVsE3O8YQxI/2s3hqONFvCU
         EPW2QIfcT06n88qICl8Zk9QvRvFqmVqL3935UUt8ot0/fkDsDZrQE94Cxxl2807fJsmr
         pSYg==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1792624924; x=1793229724; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XdpqIQAq5K+9dYzKCn1F+lyB6K6yCLid2n7WFpjVLIg=;
        b=T9oO43R6ldf39hhSBsgKvtouaavz26yjM7mHJnWKSq3in+OtwhR7HDPhniPP/klIJb
         JMnm6flfF7Jn9/WpA3Cvc8EpMiZOmtXZ6c3UPh7uZeiwuQapq5UZhD6EIPglhorGY7P3
         79hzE1kvOX+pDDC9HZCiwb5jrjJ+2t/IGyyPYJ/9Ws3q5nCBEy9mvPU2JGFTS0moI6r9
         BHt+8HojQNfhG4ZDXz3ghvF6VXsD6lw2biZl86sG8ZIsnvuSyTXXxW3WHZTa4IkB9YZy
         4GDClYdHZV75PC84EeIaTqjmYloyQjmrbTvu+fSH4uFlXFvOCIziov4YxZHNO62oITz7
         KuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792624924; x=1793229724;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XdpqIQAq5K+9dYzKCn1F+lyB6K6yCLid2n7WFpjVLIg=;
        b=0I8URmoEwpbgnJtEMd1f+lRAHSfCiDC5cZTokCsaNPd/F2kEdqLRirmBKXzxUjmbRh
         pX1NnmobpeU9zdk/QO+GcV02ViykxGu9Oxmy969TBLbMNRwW5dN20pue7hsBx6DMAjjk
         1sRNMhASYVurZYIl+F1hQxBoa7FNYbeiCLz4ntV/5sG+TzL89OL5m1Z3y6Vu0vo0hUD1
         yiN2J5QIAONstAscsyUUCgt9VoW0Lc60S4RYlrx2bzrE7HUlaAH8mwV/keq7OTjOd/hy
         RS6+39X1nimU97661VJO93664WkapPFY/n3JdQcy3oAqkQsjo9KArf9oj9bjgI0AGteL
         rSGA==
X-Gm-Message-State: AFq9FYIlM2LQ3rf638teykbYRmotwUVKfYHfTCFvZbwuBXl8aNT52g8D
	m7Z9LxBWxxjhhmHfg5Q8dRSL4aPS7G8xOWHTtbAIggQbq1JhdGwzlbCJCfWHlnU70msK+PHFspc
	pJwEFY/ZExIgbMJNS3tgbz7W9NJcrA73Va0Vfsh5ciDMtt2OXHiGEHWuODA==
X-Gm-Gg: AYBFou3N5WI/BT7WABvO+0c8EDD32hDIi0XeJP1snF/mVjlyks47H2MoGAOKjQlNWAe
	MbalzikbhRTH0U0k62IFqeIw6vvX4R8d5cF1iObolwnG3eE/paxtsK6zssEb28jbAqns84SLGnT
	QihVZUTofWo0r3rXSZxKFTBPevr/BfQnQf31XqanIoWXHueTps5+7g3tS0H/7uDUsLU16nDESeF
	aEz3SYasNhXefNIQWG6E4NH3ILYta2XXYDKdExpADpXtFDyJJ+QkDWMDmzECACvhPepbqdhI2/z
	Zz3i9q+TeSE+0vIXGpOYK459t2tI2J8tJuOPY/e/JiN6JNc2OZv1LNUPC1/XGtOFrj+Q6+0xURa
	qGP/V4/Xg+ds5Kg0tP50uI0CG55rKyAj7S3ASz6N/xbxqhjOlkjGU4rijFrfwROsTuRH6buqh4p
	oZw32qgz3C
X-Received: by 2002:a53:d14b:0:b0:677:cbe8:4fd5 with SMTP id
 956f58d0204a3-67a0e53b257mr1459535d50.62.1792624918854; Wed, 21 Oct 2026
 16:21:58 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 22 Oct 2026 08:21:21 +0900
X-Gm-Features: AclHuK_z82Qo-WaAGyCLQU-FYRJeLqbYsk3jVy4gsojlAmQuR20OtGY03ip082o
Message-ID: <CAODzB9q56nu7Z_wAG3PGmOvAxxmtaynHDVTF9Eg7qNQ9fSn5oA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 21 Oct 2026 23:22:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24505

Hi!

It's this week's CVE report.

This week reported 440 new CVEs and 1149 updated CVEs.

* New CVEs
CVE-2026-98432: ipv4: free inet_opt and ireq_opt after an RCU grace period

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98432

Introduced by commit 079096f ("tcp/dccp: install syn_recv requests
into ehash table") in v4.4-rc1.
Introduced by commit c905dee ("tcp: Migrate TCP_NEW_SYN_RECV requests
at retransmitting SYN+ACKs.") in v5.14-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3f33b0a1d89d738e2b913dab519226eaf76e15b]
stable/5.10: [b3b027ef0cd322bfa839b9aaf5b27551eea54cf6]
stable/5.15: [95a8c8fa9f27dce64c40c41c062de7728bf34ab5]
stable/6.1: [89b5b1eb7d633c33832b7ff2c02e19a144705036]
stable/6.12: [11a03ce3c4a62d84c10ccdfe47f8075006498568]
stable/6.18: [a47406c769f72c070386985488f1c4d057df86b2]
stable/6.6: [742f73df544e03744f2981c467d6542fe8172a2a]
stable/7.2: [26d4c36d318cffbbd160884a0e4cec0da4da4936]

CVE-2026-99999: ipv4: validate checksum_start before completing checksum

Announce: https://www.cve.org/CVERecord?id=CVE-2026-99999

Introduced by commit f43798c ("tun: Allow GSO using virtio_net_hdr")
in v2.6.27-rc1.
Introduced by commit bfd5f4a ("packet: Add GSO/csum offload support.")
in v2.6.34-rc1.
Fixed in v7.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6785011f8b16abf40b1e9d8b2e332232b3e68822]
stable/5.10: [a464d950f31c89565cbaae038cc60db04fe01956]
stable/5.15: [0fab003ef4698e0628060a45a48f14b43ba2a40a]
stable/6.1: [94524b7b32691de2e2ce162c04d6cbc9106e5cbf]
stable/6.12: [32a8b0adaa18e52aaa0b246b5ffe683075354dbb]
stable/6.18: [f3e835af6226f1dd12160cbd696081e9b6155de0]
stable/6.6: [a65f69e0f38ffbed1b128029e09097436416dc8b]
stable/7.2: [c3e33464746166264334641dc850a36eef7e6326]

CVE-2026-98433: KVM: PPC: Book3S HV: fix secure device page leak on
uv_page_in() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98433

Introduced by commit ca9f494 ("KVM: PPC: Book3S HV: Support for
running secure guests") in v5.5-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a416ee20bcccddf91ca5b63696a23b9d11d73aa]
stable/5.10: [ed2f2ff63cb7e71204096e765c6d02c3b6974b95]
stable/5.15: [8f3b7746874b39fc20e0363c9076c7787d4765ba]
stable/6.1: [a933d7024359e2e566b07903d1294b84f90482ae]
stable/6.12: [f3d4b2fc30c97cf8e6f8b880d2de9c17ecac7f5b]
stable/6.18: [dfb84274932737e338ff5eb27f34b4c8ecb01b50]
stable/6.6: [c41088b2765af1e97e7bb05f906ae1823eca0388]
stable/7.2: [fcbff8008b0e08cd53b611bd0ff7e01f5b962f80]

CVE-2026-98434: sysctl: Check range in  proc_dointvec_ms_jiffies_minmax

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98434

Introduced by commit d174174 ("sysctl: replace SYSCTL_INT_CONV_CUSTOM
macro with functions") in v7.0-rc1.
Fixed in v7.3-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82431877d837a6c2593efd8e66ba28b35a220ca4]
stable/7.2: [1c23dba51dbf7e86c7c2e617c964be1411329cb4]

CVE-2026-98435: EDAC/altera: Use parent device for devres in altr_portb_setup()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98435

Introduced by commit 9110498 ("EDAC, altera: Add Arria10 SD-MMC EDAC
support") in v4.9-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9868f5c077dfe0b606331f2e782484f91a5789a5]
stable/6.12: [8325ecf3f16d764a0e0ba42c95b63f08e38710a8]
stable/6.18: [2cf03ada03532bfb42f06fbf01d9e2a99e6011d7]
stable/7.2: [dc4797c909b6cacb1bb24449e6c57d50a14d73bf]

CVE-2026-98436: accel/amdxdna: Disable device buffer exporting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98436

Introduced commit is not determined.Fixed in v7.3-rc1.
Affected file was added by ac49797 ("accel/amdxdna: Add GEM buffer
object management") in 6.14-rc1.

Fixed status
mainline: [9480dd7ec3fcadd4217503e4bb32c16e19e4b21f]
stable/7.2: [33b00fa8023e8ade3409aa9c833b8ce65b8c29eb]

CVE-2026-98437: media: qcom: iris: fix runtime PM reference leaks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98437

Introduced by commit bb8a95a ("media: iris: implement power
management") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f87d7eda07fca21efe4b96169ae59007db46e60e]
stable/6.18: [fff1ae8d0c8c97668e4cbcc6e1fd2cc740013795]
stable/7.2: [7a52e76b63095e05d92f15f16f45421cab9789e1]

CVE-2026-98438: mptcp: options: fix uninit-value in mptcp_write_data_fin

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98438

Introduced by commit cfcceb7 ("tcp: shrink per-packet memset in
__tcp_transmit_skb()") in v7.1-rc1.
Fixed in v7.3-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b110f1dd6cb6a9930503354a01a315e0a821eaa7]
stable/7.2: [9a682067dd7b9dce6b94a0a05661dcc921446402]

CVE-2026-98439: smb/server: cancel async requests when closing connection

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98439

Introduced commit is not determined.Fixed in v7.3-rc1.


Fixed status
mainline: [4fd5bad647bfa45eb86bfd2f03ba1bef3fcd5851]
stable/7.2: [0947087678f465b64eba2acebe808d5c6cfea036]

CVE-2026-98440: KVM: arm64: nv: Delay freeing of shadow S2 structures
until VM destruction

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98440

Introduced by commit 4f128f8 ("KVM: arm64: nv: Support multiple nested
Stage-2 mmu structures") in v6.11-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5843f4effaa2ffac3e789ecd4456403564961d4]
stable/6.12: [876049f026b4dfaca0cc78ec81be0e639ca8525d]
stable/6.18: [22e82acec93a681071ed36f70eabe2d0c4e0bebd]
stable/7.2: [5bf1c9175e657b3c2dc1cf77403031ac7aadcf66]

CVE-2026-98441: net/sched: act_ct: avoid modifying shared unconfirmed ct entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98441

Introduced by commit a21b06e ("net: sched: add helper support in
act_ct") in v6.2-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f85009dfcd65e5969526b0db7a49b5413746e630]
stable/6.12: [2b783c562c3238ff50c34fd7a72a735c9cc73d9a]
stable/6.18: [4a04ed91575819fb1859311113e95700b709bec7]
stable/6.6: [c812bb4aea13d385d048b5b24756aee2edf6f99e]
stable/7.2: [b097d9d7a5b09c8ec5c4c1a08e35ac5a66b06b44]

CVE-2026-98442: net/sched: act_ct: fix helper UAF due to extensions realloc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98442

Introduced by commit a21b06e ("net: sched: add helper support in
act_ct") in v6.2-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dad19b59da050cb60d3f7023dac2a042a84bf0bd]
stable/6.12: [1679bbf5fbeac52a310b1a58b2b301bbf388bdbf]
stable/6.18: [812c16a255e7773a544e88b39ae6daed25544d30]
stable/6.6: [31f5fe29a572037ee19c233dfe506849940c484b]
stable/7.2: [8988f4d11f3fba0ab38122178836c683ad516a05]

CVE-2026-98443: xfs: fix cursor and pointer handling when recovering
iunlink buckets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98443

Introduced by commit 04755d2 ("xfs: refactor
xlog_recover_process_iunlinks()") in v6.0-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [65f39d09d73718611cee40399179323b5d4ead00]
stable/6.12: [8c9d5b8a96d6b93eb24e07b4163c89341ba29bd1]
stable/6.18: [66a2179d02668f8df44b1a249899006f3ba38ea0]
stable/6.6: [47a948ba653a463d429e02fda2f06a3d6b78666d]
stable/7.2: [961c717e6bf0e53c2c2b1fe4aef1add9390fedab]

CVE-2026-98444: xfs: drop dquot flush lock when we can't find a buffer to flush

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98444

Introduced by commit ca37818 ("xfs: convert quotacheck to attach dquot
buffers") in v6.13-rc3.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [ffb48dccce1960a9ea24463a2f3c21d124d6b672]
stable/7.2: [41bc624377f08125eae164c62ce043791ade93b7]

CVE-2026-98445: xfs: don't let memory failures leak blocks and kill repairs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98445

Introduced by commit be40841 ("xfs: implement block reservation
accounting for btrees we're staging") in v6.8-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab1c416d2377cdc16123ef521aac4da1c468c3d4]
stable/6.12: [3380151cf0ce8ad0c1d356fed51e4b69e1d28e50]
stable/6.18: [b15c79fca28060fd9c7e77f2c3ebc4ba023974e8]
stable/7.2: [0e0d3372a84029da1768c7a4c4601484af5b58a2]

CVE-2026-98446: xfs: don't let hidden_space go negative in
xfs_metafile_resv_init

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98446

Introduced by commit 1df8d75 ("xfs: make metabtree reservations
global") in v6.15-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [476582d754cdc5110f806001417fea6c77824c13]
stable/6.18: [930a9c1c321efdaa3e7f8caecb0479cee3baf342]
stable/7.2: [f0d8352a39f4a2e329ae45b71bb0d49e2ca0a6dc]

CVE-2026-98447: xfs: fix wild memcpy access when formatting ondisk
rtrefcount btree roots

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98447

Introduced by commit f0415af ("xfs: wire up a new metafile type for
the realtime refcount") in v6.14-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe2f9135df43db849e74f03956d322ac20b59af7]
stable/6.18: [d46492fb8018d12d00651b06b9d240e747110b38]
stable/7.2: [2703b954d306ebfe3b11e33e259759329c11b690]

CVE-2026-98448: xfs: release orphanage dir inode if chown fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98448

Introduced by commit 1e58a8c ("xfs: move orphan files to the
orphanage") in v6.10-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c32cdc986467eaffeedb6c5334852809555b82d]
stable/6.12: [6b66b1a59df6c3f9b4ad9b39a32ca86170ade357]
stable/6.18: [6a65a68097a1903988b256d5b367da7b0863a1d5]
stable/7.2: [f813aefd9e09c8cda38a71580b6a01552d97cade]

CVE-2026-98449: smb: client: delete compound mids on send failure before unlock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98449

Introduced by commit ee258d7 ("CIFS: Move credit processing to mid
callbacks for SMB3") in v5.0-rc2.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f6f8a48399f82f4a83f7b9f25b9707e0062a4f9]
stable/7.2: [70783946f3b5d0c06ec7df0f5e7bec2bfad24efb]

CVE-2026-98450: smb: client: close completed creates on compound wait errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98450

Introduced by commit e0bba0b ("cifs: add compound_send_recv()") in v4.19-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c5c547f037bc18f0b8d0b5db5a648f8f630ce85]
stable/6.12: [2cb07d1a6a30283dbfc809c8036bc1fd103d59fa]
stable/6.18: [224b56b7c02b2bfb1f5bee18d5f56ae6b052be44]
stable/6.6: [8afc80156b1d9e2cfd02d42c255305fad95b59fc]
stable/7.2: [253612499ce9b4cd7bb922fe507ec204bddd9313]

CVE-2026-98451: smb: client: use finish_no_open() for non-regular inodes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98451

Introduced by commit d2c1271 ("cifs: implement i_op->atomic_open()")
in v3.6-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e66cf1625ec4a3fe68346119f371def713fd0a4d]
stable/6.12: [ed03d547598c92a036f20e89156540995cac889a]
stable/6.18: [70a7918fda54a06d836acc91eb9a3c7e860fe0a0]
stable/6.6: [045532f920d86dd76600b635f9756e5fd671ddfc]
stable/7.2: [3c07deb26273155c180aedfd9041ab58015d2521]

CVE-2026-98452: smb: client: clean up failed cached directory opens

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98452

Introduced by commit b0f6df7 ("cifs: cache FILE_ALL_INFO for the
shared root handle") in v5.1-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2ff5fb93ea83034025850266b5eed391f96b825]
stable/6.12: [48958ddda3d7eee3600261e2d90671f63e055dc4]
stable/6.18: [abab661eed00fa102d3c35ddf1cce4f687e718c1]
stable/7.2: [7c1509598a4fdfb54cb09ce33e4405bd6dbd8295]

CVE-2026-98453: smb: client: close handle after create-context parsing failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98453

Introduced by commit af1689a ("smb: client: fix potential OOBs in
smb2_parse_contexts()") in v6.7-rc6.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [566820af017e81497fb5e9d3ad6e7ffe2828bc8b]
stable/6.12: [80c67cc71d32ccafc89a29b669243b40d81b930f]
stable/6.18: [f09875ff901e933e7b22c913daf51d21e9d93a45]
stable/6.6: [eaa97a196a107d4ef8775df2248181624151812e]
stable/7.2: [cdb36b09fb1f86d638d0afb44d621ed3f7c1d8eb]

CVE-2026-98454: smb: client: fix create context out-of-bounds reads

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98454

Introduced by commit b8c32db ("CIFS: Request SMB2.1 leases") in v3.7-rc1.
Introduced by commit f047390 ("CIFS: Add create lease v2 context for
SMB3") in v3.12-rc1.
Introduced by commit 89a5bfa ("smb3: optimize open to not send query
file internal info") in v5.3-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67f4c1c6a1b51e203d986779299824d1c2c590a6]
stable/6.12: [28bc9a871799363afa3139e961a8e3684feb8704]
stable/6.18: [05a7fd80024ff32b9b40ab1478bb172eeab1c386]
stable/6.6: [e4c49012708c917eafd9c27054b02d0f8b30fe64]
stable/7.2: [cecc5399987e73a528ce2b662eeb54af69163cbd]

CVE-2026-98455: Bluetooth: RFCOMM: fix NULL dereference of
dlc->session in RFCOMM_CONNINFO

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98455

Introduced by commit bb23c0a ("Bluetooth: Add support for deferring
RFCOMM connection setup") in v2.6.30-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [46f8ffd0a1f1eb6cbc94946a92c11ef601e228a1]
stable/5.10: [c3aee3fc1287c8a555baf3895959087cb0c33fe8]
stable/5.15: [4bf5ca47203049ce3648f750a53dcdc98bcc9e3e]
stable/6.1: [1c4f7e1177da2f229be04139c27e5370a1cfba52]
stable/6.12: [c7362f6a18ed167f52f08ce25eeec8a7818c5004]
stable/6.18: [8f5b30cc12c409ff62891e47ed51e6bf0945a3ea]
stable/6.6: [84ae3cfd7d3a63591a2eb4faa24faf678c6708aa]
stable/7.2: [005b23d9e324fe5d0acbcfa70c625f2e81189046]

CVE-2026-98456: Bluetooth: mgmt: fix race in read_unconf_index_list()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98456

Introduced by commit 73d1df2 ("Bluetooth: Add support for Read
Unconfigured Index List command") in v3.17-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5dbb41b212c50c095a4dbee3017a84fe94f033b]
stable/6.12: [8ddf962c76432a10a6cb80042875cbc48a9c056b]
stable/6.18: [416546cd6a54e9b68f2b91bc680b1ee17dcd77a1]
stable/6.6: [524e0450dd9a396f99a81b045219b0e2ea0dab57]
stable/7.2: [2e8bba0360d1379bfa8da47c8f5dadbb10a3fba1]

CVE-2026-98457: Bluetooth: L2CAP: validate frame length before control
and FCS access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98457

Introduced by commit 1c2acff ("Bluetooth: Add initial support for ERTM
packets transfers") in v2.6.32-rc1.
Introduced by commit fcc203c ("Bluetooth: Add support for FCS option
to L2CAP") in v2.6.32-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c78a213d9070b610c7f418af2c25b66180b7e37]
stable/5.10: [4373ba79a267947e771c438507f7b103e30bdb21]
stable/5.15: [965bd88ed4b4763cb765dd65885adcfa588c6b14]
stable/6.1: [3acf6a0038ec0d4e8f4dcbfc2a557dff5f61cb70]
stable/6.12: [1fdbb2a712a9a162ee817c959740face80b3d929]
stable/6.18: [c6a288e6001bcce16553c3853e0f5a45eaaf85c7]
stable/6.6: [8c7556c7cd17e073bbefdc4a9a4694a207544c37]
stable/7.2: [f557274af7b94b6134692e6f26b880f1e34c15bf]

CVE-2026-98458: Bluetooth: ISO: release unused CIS holds after channel attach

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98458

Introduced by commit 69997d5 ("Bluetooth: ISO: handle bound CIS
cleanup via hci_conn") in v6.6-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0fcd4dad555c96e0bd3a1b8c569f989be85c7341]
stable/6.12: [e0e8b70207eaf27aee0a05ec5bf2d1b6bcb004d1]
stable/6.18: [ed4c026cc4094dfb7a329b9d8df0ddd0be1b2458]
stable/7.2: [e5fcca51177f224604e3a8c926ffd5edbeb58b09]

CVE-2026-98459: Bluetooth: ISO: balance the parent hold in hci_bind_bis()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98459

Introduced by commit fa224d0 ("Bluetooth: ISO: Reassociate a socket
with an active BIS") in v6.8-rc1.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [4c94557dd02569efa6c1072a0439addaef9a5224]
stable/6.12: [03a91cdf6862fb351a74f035ad21e70112438552]
stable/6.18: [4e49206d9574a4c109480198e73aea34ad0ed7f6]
stable/6.6: [ff28e6c67143c76ef50c3eac01f2fad411705f71]
stable/7.2: [bbcd723ee7a84bc868142fd57717af88e54e555a]

CVE-2026-98460: Bluetooth: hci_sock: reject out-of-range OCF values

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98460

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e93fad891c72deb84cae49430163b384ebcc92b1]
stable/5.10: [70b0a27bdde0cb524349c8261202c7c9393cf5e9]
stable/5.15: [598686f5d65b9af2223ed9d22fadba16e09f6ca8]
stable/6.1: [c1fd465ea1c5aef459f9bc3ac602b5353e0f536f]
stable/6.12: [320dedad15e8bbaecc8d2d7fd4189defb84caa85]
stable/6.18: [173457fa3e99ef4188dd0fe63e4dee98d0e441a9]
stable/6.6: [68f0bcc4e16e31ff8dbe6ca93116eb70d7b6ac44]
stable/7.2: [47d67ec424e63e61e9eb58633d43a9d58a1852b6]

CVE-2026-98461: Bluetooth: hci_sock: validate event length before filtering

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98461

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0a6cf99afd57a39598b1beca0e86ef5004980de]
stable/5.10: [39e99d85071bca0feeec3164a9437ca1bff297fc]
stable/5.15: [ebdd49cec380731844ed9df4092a29a014623df4]
stable/6.1: [2501a3b7b7144d1d11939b355a48ed01f83d0c62]
stable/6.12: [3976bbcd43b9b94c53ac9b0fd28888011588f4cc]
stable/6.18: [f894f6292d5122cd62d30600736b4a0ae79f7770]
stable/6.6: [dca25c204f71be0556a15177dbe037237ac43e5e]
stable/7.2: [1a92763c2ba721bf113cd83f913fe8c511b4a4dc]

CVE-2026-98462: Bluetooth: hci_conn: fix CIS hold ownership on reuse

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98462

Introduced by commit 69997d5 ("Bluetooth: ISO: handle bound CIS
cleanup via hci_conn") in v6.6-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e06d549fcd4a0ba381ed67ddf1ab3c7a6ca4314c]
stable/6.12: [072bc8659f22566083f8eef7dc5903bbcaf7804a]
stable/6.18: [3ff5a8d949e3a2a435d0a5ee05074cd371b0158a]
stable/6.6: [10f959cb435217b4b407864e5be0eb779e389490]
stable/7.2: [947eb2f41f70d371eb16897ee4e8e32bff73b476]

CVE-2026-98463: sched_ext: Derive SCX_RQ_IN_WAKEUP from the core enqueue flags

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98463

Introduced by commit 57ccf5c ("sched_ext: Fix enqueue_task_scx()
truncation of upper enqueue flags") in v7.0-rc4.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [df5cdc2c832ca4e8a6d774596b9005558761a403]
stable/6.18: [6c401ae426e20e53a3398a8e79afd0964c0f5110]
stable/7.2: [3fdf2ceb31e8aff77451e468bc8409e10587916a]

CVE-2026-98464: RISC-V: KVM: Synchronize hrtimer callback during teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98464

Introduced by commit 3a9f66c ("RISC-V: KVM: Add timer functionality")
in v5.16-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aaad136d56d91252517272b68cd533e5714698d5]
stable/6.1: [9bdbae64ae0dab93041ebc57ec4e93def793fc2d]
stable/6.12: [e66aced74f0122380603c9910a71d77618b28f0e]
stable/6.18: [ea91f05a55b807ead3166546a2c75f4185ca645f]
stable/6.6: [2af03b606aadaaeb386658ef798c79bdcdef87c1]
stable/7.2: [3cc6184bd5920c9685d87f4e260568feba08650d]

CVE-2026-98465: RISC-V: KVM: Serialize IMSIC attributes with vCPU migration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98465

Introduced by commit db8b7e9 ("RISC-V: KVM: Add in-kernel
virtualization of AIA IMSIC") in v6.5-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ae12ccaec6ec74945d8c1ef39f2c1b8df779abc]
stable/6.12: [a29c5d2dd2ef9a8617a9a6d5585696d5f149cd98]
stable/6.18: [c525772c304c971b0d3a1f2898dedbae653efe90]
stable/6.6: [6c2bcf6b173d4afed883cceea9d47f2c5194161d]
stable/7.2: [71acbea44e78665ea90e3c310fca6bbdcc0252db]

CVE-2026-98466: KVM: arm64: Transfer the hyp stack pages out of the host stage-2

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98466

Introduced by commit 1a919b1 ("KVM: arm64: Add guard pages for pKVM
(protected nVHE) hypervisor stack") in v5.19-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a8c562892b96f35bba1e00d5e455a15963bbb92]
stable/6.18: [e5dd2a91a7ae3a276e6d79806127e923936e241b]
stable/7.2: [22df195bff84300a3f04813d6148765c77ac565a]

CVE-2026-98467: KVM: arm64: nv: Fix null ptr deref on nested wp/unmap,
teardown race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98467

Introduced by commit 7270cc9 ("KVM: arm64: nv: Handle VNCR_EL2
invalidation from MMU notifiers") in v6.16-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c74e233cdedd11592775fae2a6243e67ca3f891]
stable/6.18: [970de111c087488e53cadf5480b94e0f695db985]
stable/7.2: [3cefc1ab511fad6a0f708e7a4aee9f91346e9457]

CVE-2026-98468: KVM: arm64: Fix spurious warning for benign stage 2
teardown race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98468

Introduced by commit ec14c27 ("KVM: arm64: nv: Unmap/flush shadow
stage 2 page tables") in v6.11-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38b70fc453c3112f1a62583b89903ae41116cc27]
stable/6.12: [f44a92633136b409ebb9b7036fceb7e11de60a20]
stable/6.18: [c23ed110d27ba99cf3a881986514f79aacedf476]
stable/7.2: [330346dda3bf5f8a3b06723024f7d906326270cf]

CVE-2026-98469: KVM: arm64: Fix AArch32 DBGBXVR<n> handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98469

Introduced by commit 3ce9f33 ("KVM: arm64: Fold DBGxVR/DBGxCR
accessors into common set") in v6.14-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b1bca1b1ab77f60a62087337bfe6e2f0efb9e6d]
stable/6.18: [8530a05b304d312fe7dfbc5df7d3e87cc31b256a]
stable/7.2: [af6813d16ace2765011ca1c567be86ade1d1ee8e]

CVE-2026-98470: KVM: arm64: Don't WARN on an unknown VM ioctl in protected mode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98470

Introduced by commit b12b3b0 ("KVM: arm64: Check whether a VM IOCTL is
allowed in pKVM") in v7.0-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49d9d295d69d07e850cae35933ba8519e2915f26]
stable/7.2: [cc53eb5c6515e3221314624a22c9da9c80a67f63]

CVE-2026-98471: KVM: SEV: Do cache maintenance on the source VM during
intra-host migration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98471

Introduced by commit b566393 ("KVM: SEV: Add support for SEV intra
host migration") in v5.16-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [93de2a6a4b91b72607136dd656edf03fb399d27f]
stable/6.18: [37dfb676fafd1eef36fe0bb649607afbb0d5521b]
stable/7.2: [d4cc2dff12116a700add601c0262132cc26e1b2c]

CVE-2026-98472: KVM: SEV: Free have_run_cpus during VM destruction
even if VM is no longer SEV

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98472

Introduced by commit 6f38f8c ("KVM: SVM: Flush cache only on CPUs
running SEV guest") in v6.17-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12c1f6e03f944e399bd2c88441dca5dc702b95a5]
stable/6.18: [6aef7cf800098749ff5d660222efaf6e01e98c09]
stable/7.2: [9784e5ca91b37b387f3f414af4340c54f7a63566]

CVE-2026-98473: s390/vfio-ap: fix KVM GISC and page leak when queue
removed from host config

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98473

Introduced by commit b9bd10c ("s390/vfio-ap: do not reset queue
removed from host config") in v6.8-rc1.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [65e05ec252a9b79e75930d3c4dd42d8877db04c5]
stable/6.12: [da69d3ac53490724eba0ade9deb4e539a6ae9034]
stable/6.18: [cf441a0db681dfad5e89b015d6be11365159d7a9]
stable/7.2: [3c3433657c82f200dae36c29e2b80681c81b85be]

CVE-2026-98474: s390/pci: Fix missing device lock in zpci_report_status()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98474

Introduced by commit 4ec6054 ("s390/pci: Report PCI error recovery
results via SCLP") in v6.14-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0261aef4b15efcee2860ab857e5cb05e9bfa47b0]
stable/6.18: [743a8458978d13d84a1cf74bcd29b9959a75d3a0]
stable/7.2: [1b957d5c2f737cda731cb1a1b71a7524d54538f2]

CVE-2026-98475: s390/cmf: Fix virtual vs physical address confusion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98475

Introduced by commit 14edd0d ("s390/cmf: fix virtual vs physical
address confusion") in v6.9-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f4d04425e66af2ecee9d1a49ae0484436f3c2fd1]
stable/6.12: [b11f369be31ea11c746833e4d3ad51dcd6b5fa2b]
stable/6.18: [748ec2f7f5df9b4fc742546a8bfc8aa5d847353e]
stable/7.2: [7f78226eb743b362f52b212d7763801642539d1c]

CVE-2026-98476: s390/cio: Fix NULL pointer dereference in
ccw_device_get_util_str()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98476

Introduced by commit 1996523 ("s390/cio: add helper to query utility
strings per given ccw device") in v4.18-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b76268dac968612f7283d59b539036de955b7d9]
stable/5.10: [9d8b21820caed9128945fffcedf03e2a4c21eee2]
stable/5.15: [5fc54e04dad90b15d0430118b3f288a1d64e66c9]
stable/6.1: [27e396a89f76f742abdbe9f8c4a58a6e806fdf59]
stable/6.12: [5e006ac90a4d331db1dd712b91fec849b45ffc01]
stable/6.18: [c3bbcb32deecc06ebb1762398399b566d5ff2fc9]
stable/6.6: [dbf30e661ceb9a52c94c85719716391dcc29142a]
stable/7.2: [44b16b02608058fc72198ac0205969f0f43065df]

CVE-2026-98477: perf/core: Fix NULL pmu_ctx passed to pmu->sched_task()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98477

Introduced by commit bd27568 ("perf: Rewrite core context handling")
in v6.2-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36bb85cf36cab15fb611cb44b78a5df06e4e69a2]
stable/6.12: [b5409311b606d536cc485f3706c242c2afa93edb]
stable/6.18: [249a2bd87a0e57dc28f36e992807edc9cae309b5]
stable/6.6: [98181f9721f75f1a544dc563b0d8fed1d5c398d5]
stable/7.2: [ec15f6a50183fc01f470af74ad49900fb3731fca]

CVE-2026-98478: scsi: ufs: core: Keep internal commands dispatchable
during error handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98478

Introduced by commit 08b12cd ("scsi: ufs: core: Switch to
scsi_get_internal_cmd()") in v6.19-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b52d695d062095327b944acf7daabbc816ab319b]
stable/7.2: [9f6f4840def931814c106fc800f57a2d26befee6]

CVE-2026-98479: scsi: libiscsi_tcp: Check the data direction of a Data-In PDU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98479

Introduced by commit a081c13 ("[SCSI] iscsi_tcp: split module into lib
and lld") in v2.6.29-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bce07e2f37b5e4a427d36fd6b1c14067b27591db]
stable/5.10: [79991b770fc3685b1d5cf805b659a879edd19931]
stable/5.15: [8db1232945bc663fb94f300090a1fc108de99296]
stable/6.1: [94e5bdd08e51c450d954bc592f591c233ca5c9df]
stable/6.12: [e3b25bf2cf2496e85bc05b33360faf9fdf880e03]
stable/6.18: [ee56b5e18f566c0b5a183379dcd63d402cebf2f8]
stable/6.6: [de96dc11aee0d058927bff94a168e3c5c46483e2]
stable/7.2: [24ffc919467d20951f0f132d1c75294e2e91e09b]

CVE-2026-98480: nfc: trf7970a: power down on startup RX gain failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98480

Introduced by commit 5d69351 ("NFC: trf7970a: Create device-tree
parameter for RX gain reduction") in v6.17-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2acbde7e67df44efa8f0963462d1192e7694ffc]
stable/6.18: [cc444e4ad43461374dd128573eccb8979d2adb4c]
stable/7.2: [6ef70d790425e76b42c69e416ee78c62bdc37d00]

CVE-2026-98481: nfc: port100: reject frames whose declared length
exceeds the received data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98481

Introduced by commit 562d4d5 ("NFC: Sony Port-100 Series driver") in v3.13-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [092c6a605cbd6414ef499834c2e0da69c2c3388e]
stable/5.10: [0d482995f0cdd0302450aa300c684c642d8ab31f]
stable/5.15: [9e8df087826b9999d1b83b06f5d85675d5a69c9e]
stable/6.1: [db66a30588630c7de30ef033f00daddef69f6ad9]
stable/6.12: [e4da1452e10c6472a4bac48dc2f6a35fff1fcd69]
stable/6.18: [14b1467cfc6630583650f33538174c5a1ec685ab]
stable/6.6: [144ad477c381e2c592b64898d04ab4ce03b32861]
stable/7.2: [035056e07ea65be670284246d9bc62f2f00ff4a3]

CVE-2026-98482: nfc: llcp: drop truncated I/RR/RNR PDUs in nfc_llcp_recv_hdlc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98482

Introduced by commit d646960 ("NFC: Initial LLCP support") in v3.3-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [273f9d667cde649f8de9d72b1303cc2f4b658c50]
stable/5.10: [3afdbebfee2ef7e9510880868cfb482cbffe6836]
stable/5.15: [9b4086eb67a9a3b1ce69fef1b6793827363703ce]
stable/6.1: [51b6d73373589abb9de4d84767b0db1bc8d395d9]
stable/6.12: [18f60ee882403d5b48097f5f6ae45f794e4cc643]
stable/6.18: [810f204ef8f61f0c930cf6b3280050b3ee6a8ae7]
stable/6.6: [066205553a0106565bcede934f5721c25ebd6e4e]
stable/7.2: [744e61bd06188d8bb068c26a461c252f242b05c9]

CVE-2026-98483: nfc: fix use-after-free in nfc_get_local_general_bytes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98483

Introduced by commit 6709d4b ("net: nfc: Fix use-after-free caused by
nfc_llcp_find_local") in v6.5-rc1.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [dcab71a7011918f6fdba7adcec02d217dcb84b8d]
stable/5.10: [25bfa673adc70189c0bc872940421ae59f789cf6]
stable/5.15: [2b31d0cc95856c856ada91f943fb14dfdf29a923]
stable/6.1: [c40f61a6a413f3eaf028e5fe367fd9749e503ab0]
stable/6.12: [d8c929e9afdbc33b1876ecb97a517e850449b5bd]
stable/6.18: [841af260ff477f6191872bc3b2e15488615c1827]
stable/6.6: [19bcfc2a56d0b82919079b5424c5a9a0ac897dcf]
stable/7.2: [9ede11e12f965ace97c4e0f606667f24fb41e7e1]

CVE-2026-98484: netfilter: nf_tables: skip expired catchall elements
on insert and delete

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98484

Introduced by commit aaa3104 ("netfilter: nftables: add catch-all set
element support") in v5.13-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70194dc37670bd08e44b471389861cc01bd3a3c9]
stable/6.12: [2f07da3881525f7cbfed1ced2796c71a201505b9]
stable/6.18: [12cf803edfffef96f6415f0b5dbc7ec88842ea0f]
stable/6.6: [5e20b39aa7844769a7a782484bc1a809ffbc513e]
stable/7.2: [4fb8b1ccc475651e480e509de126bb9ce7f3cff9]

CVE-2026-98485: netfilter: ip6t_rt: fix zero-address non-strict match
out-of-bounds read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98485

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82313c169eddc02b1bf5ba6b427803e272d3ec42]
stable/5.10: [959d1829d1ce8b91b435b24a923b51bcc8897090]
stable/5.15: [fe336bab13834394320997de8b16ca4a913b4f13]
stable/6.1: [5a54f8b7f7fe207a5c14713015a5820588faf1ad]
stable/6.12: [dd55c0ea87bf70e4e4b3b683acd29ef981335b26]
stable/6.18: [191239b0939692e92459d8d32cad14247fa93f89]
stable/6.6: [b89249819a7d6698bed152feafd3bc6c08489d15]
stable/7.2: [d9cf4ac6f326330e1fe4d95671d36a6ff3593f64]

CVE-2026-98486: net: ena: fix MMIO read buffer leak on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98486

Introduced by commit 1738cd3 ("net: ena: Add a driver for Amazon
Elastic Network Adapters (ENA)") in v4.9-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9476b4468862927297c94c440863cd8ed1e7cc83]
stable/6.12: [7bd3e9a2d0c288e54f51df260d9433163f5fbc1e]
stable/6.18: [30ff01b4c7e419bb70f40f01dcd7f6af680808b3]
stable/6.6: [a0f5fd7a285f44fa402242f26feddfe1d4a0fc6c]
stable/7.2: [47785f9f638b064ce6e32e8e3b6f1ffd83849fc2]

CVE-2026-98487: net: bridge: mdb: restart port group walk after deletion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98487

Introduced by commit a6acb53 ("bridge: mdb: Add MDB bulk deletion
support") in v6.8-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab1404ac81154a89fb61ac50ae9a04cd8d4834dc]
stable/6.12: [46ec55855c972504258c371677ac039ba20e5d12]
stable/6.18: [ab3c4a4c85f2e1e8d04b5c1770dea8412d21c7fe]
stable/7.2: [fe2a42789c12eb7c5d3a42191e2cc735a6c35ead]

CVE-2026-98488: net: atl1e: fix soft lockup on out-of-range
hw_next_to_clean read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98488

Introduced by commit a6a5325 ("atl1e: Atheros L1E Gigabit Ethernet
driver") in v2.6.27-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [374bf9e4b90f979e052332c4faca2d745c491a12]
stable/5.10: [ca862b1a4af7eac19429ca7ab92625f94ff4a46c]
stable/5.15: [4bbb44075bd3e773d61706882ab923ece8b3b519]
stable/6.1: [34bc747a61bef572244b01b095552b629cd8d2a2]
stable/6.12: [a277422d194c62daa1b961f5f739689e53fe7301]
stable/6.18: [4b7161804d8f31227551901f93947bb4eea4690b]
stable/6.6: [1d8c85359b5075c7937925b673add7ed00e57ec8]
stable/7.2: [3a7d9271b37c80fb7db04aff3bc5621cfdaf9bee]

CVE-2026-98489: net: atl1c: fix soft lockup on out-of-range tpd_cons read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98489

Introduced by commit 43250dd ("atl1c: Atheros L1C Gigabit Ethernet
driver") in v2.6.29-rc7.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36c2009d90f2210ef92e6f4f2850e8b57b09e754]
stable/5.10: [e7acd4cdeccbcdfd407adeb72b1eba14d1145b6f]
stable/5.15: [5ea2576a4f5ec476f33169fdbe9090d2b038ad13]
stable/6.1: [4daf80da0c38b8cd92c111ad96cb38322aabf586]
stable/6.12: [9f2cc71a2e2799d9c993c73f1bd36507eef6ae43]
stable/6.18: [586847400b1168a88917287ac02c2c91a620b841]
stable/6.6: [57b55367b6e3accc55a989afeaf127063e3614dc]
stable/7.2: [d4ab263e40fcf7cfa38a43ec774067d32eb94e16]

CVE-2026-98490: net: openvswitch: conntrack: fix helper UAF due to
extensions realloc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98490

Introduced by commit cae3a26 ("openvswitch: Allow attaching helpers to
ct action") in v4.3-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a4151e6be57b098b7a5ebfbde58585e83200cdc]
stable/6.12: [afcf362625190c5260530b1d6c7daa98831f6b83]
stable/6.18: [5f23080a625dd7855ab91485c8d691a54a1979f0]
stable/6.6: [18866dc1f525f9ee4de7709529d1ae1af8d8e8be]
stable/7.2: [e02a83bb0b7a203f6a22f55ad5f426765560f811]

CVE-2026-98491: net: openvswitch: conntrack: avoid modifying shared
unconfirmed ct entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98491

Introduced by commit cae3a26 ("openvswitch: Allow attaching helpers to
ct action") in v4.3-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26b2bd70d22457556e2fa01cbf1192cb1a94d619]
stable/5.10: [e0fa5ea434b7e8467ef3adc64e3858b1ca2a642d]
stable/5.15: [37e3c878b183a115f9a114067f9ef3b408ad27fb]
stable/6.1: [707c2dc77891a874f4e8c52c285a511079164ec8]
stable/6.12: [55e5256adf3940e71802e2f749cacf81518726b0]
stable/6.18: [e2829ae5459ddb5fce526b2e84697edf6c0c3cef]
stable/6.6: [de41ee24f77b0fc45397db3e277cae2adbd43dfe]
stable/7.2: [457e0df1b5711fbeb7ba1b6bfd826f5ef30e7e55]

CVE-2026-98492: net: macb: fix dma_alloc_coherent() leak on
macb_alloc() error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98492

Introduced by commit 78d9018 ("net: macb: single dma_alloc_coherent()
for DMA descriptors") in v6.18-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23d42b9a3bcd55b17d3b371544fedc708c2397e9]
stable/6.18: [bda487567d0b7b15dfa876511085c0666b9efad5]
stable/7.2: [259e6cbb6a097da8ced544ee92a6fbde35aa1338]

CVE-2026-98493: net: ipconfig: bound DHCP option construction

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98493

Introduced by commit 130c0f4 ("ipconfig: send host-name in DHCP
requests") in v2.6.36-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e47a1958e12abc3a17b5231a4f21c8f1bf662e08]
stable/6.12: [abcba6f080c63e403037ecdffde43170d242376a]
stable/6.18: [24e79508b237dd2a69bc6fb6ac5cf7f126178307]
stable/6.6: [38a6a118260ebfc82d0c653194d616bdfbd236ac]
stable/7.2: [cbaad2922bd5d4d303055ae9afecc8999e6b40c9]

CVE-2026-98494: net: atl1: fix soft lockup on out-of-range
cmb_tpd_next_to_clean read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98494

Introduced by commit f3cc28c ("Add Attansic L1 ethernet driver.") in
v2.6.21-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43e746821f5f5afbbf68e388bf9fbe221e03bfca]
stable/5.10: [5d7ac337d37cb97d77e4c910d37746694b606661]
stable/5.15: [c55e51d5899e80f9593b26985ed0b89e0c828a5e]
stable/6.1: [6ab9f61ca851f02ae4398cebaf00735a22e1d6ca]
stable/6.12: [79e2447b11322c27ef9ac423be0a94efc7691f02]
stable/6.18: [0f573b0576252d44fb27ab8470ea873bc6408ef3]
stable/6.6: [632cd7b81cb7bab36112f02eb2ee7f7cc1214fb1]
stable/7.2: [6285919d4c06254d257d24dc980f6332e1984a82]

CVE-2026-98495: net: arp: terminate device name before lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98495

Introduced by commit 36fbf1e ("net: rtnetlink: add linkprop commands
to add and delete alternative ifnames") in v5.5-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d8b6529e80bcb4fb8177121404cbb3377acaebd2]
stable/5.10: [ae6d704dbf9542b0a0830ec91a2db4f30307e7d8]
stable/5.15: [47107491b48ceef0a2faa7a010cfa961f211ef9f]
stable/6.1: [7389757d88f54237951d7497d9c4dae7cc6d64be]
stable/6.12: [414bbad9928598904313299ac9e037a73f520be1]
stable/6.18: [ba664d83638640cf454b65167339cbf20dfd6f10]
stable/6.6: [1b08c5c3ac27c9ff91c5309f4a32b4e91ce2263b]
stable/7.2: [35e716a70733472ede300540082d64c33bf3b4c9]

CVE-2026-98496: net: airoha: npu: cancel wdt_work after releasing the WDT IRQ

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98496

Introduced by commit 23290c7 ("net: airoha: Introduce Airoha NPU
support") in v6.15-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4bdee8060d1e4581624e68fbd369b1afb14df4bc]
stable/6.18: [aca91d8fa0ecbc990ebf9a688c684dda78a43c00]
stable/7.2: [da9d42531f3a6dfea2e9c775b62a46185dbf280a]

CVE-2026-98497: net/mlx5e: fix swapped IPv6 IPsec policy masks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98497

Introduced by commit ca7992f ("net/mlx5e: Properly match IPsec subnet
addresses") in v6.15-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10de7ed8ef4840da9ca21de4c29578657ac367db]
stable/6.18: [3803dc8477f08e0dac4050cafee0de43f32727be]
stable/7.2: [e73f832f0a7b2c6ea45b2124c732d639be97b547]

CVE-2026-98498: net/mlx5: Fix rev_entry reference leak in
mlx5_tc_ct_shared_counter_get()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98498

Introduced by commit 1edae23 ("net/mlx5e: CT: Use the same counter for
both directions") in v5.10-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0bf6bb567f0edaa771e7dd208ef98da50e6a4485]
stable/5.10: [598daa5f95883f881a54967da40ce0fdfc1fdaa8]
stable/5.15: [79a3257280a335bbebbcd10d3895e8468bdcd6ae]
stable/6.1: [c45c997d0c27359b502587897f775c5a277f0bd4]
stable/6.12: [60eab87d0a798070bf5a856b1d9e5785ce92da53]
stable/6.18: [99d8dc51663747078c031acac32edc6d90c8f1f7]
stable/6.6: [288721013605b4e0304e10f6a087b77f71cfad11]
stable/7.2: [1f13989a0704bd98cab09f9bee63e2c8a98ad4dd]

CVE-2026-98499: HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98499

Introduced by commit 8341720 ("HID: wacom: Queue events with missing
type/serial data for later processing") in v4.16-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9aa237cf66495b2426ddde8532e9b08a0ed83aaa]
stable/5.10: [9aa62f967b6a4bb30aa3b778e02c8a5ca6bcde51]
stable/5.15: [26471d954bbfbfb9032994f7f485802ee20e0582]
stable/6.1: [456afe4707e23cc114ad833197f63b52bb8fd1e7]
stable/6.12: [eaa7d29341ef4b91e84ad097562982288a7c376c]
stable/6.18: [c3129e6f26e18c0886ede7265f187a7ec289e1d1]
stable/6.6: [65e7c4b5366b770c60dfefac3f1d06e33a9e411e]
stable/7.2: [4b09b7c84b8633cd041181616bd15bf5e73c164d]

CVE-2026-98500: HID: hid-oxp: use cancel_delayed_work_sync() in remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98500

Introduced by commit 84910c4 ("HID: hid-oxp: Add OneXPlayer
configuration driver") in v7.2-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abd24922c2a9797d6184be0561dd85e7bcdfd091]
stable/7.2: [eed737d89fa368251018a62e1d698958ef7dc635]

CVE-2026-98501: HID: alps: fix use-after-free on input2 registration failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98501

Introduced by commit 2562756 ("HID: add Alps I2C HID Touchpad-Stick
support") in v4.8-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3aba3442798ce4a4c8ce3104d7b286d61e605f9]
stable/5.10: [64f824dccfd316fd3db8ea1cc4e8a76ad6a02740]
stable/5.15: [2e55d76e6e8a756f6d87c241de975599f82b02fa]
stable/6.1: [ef8ca5bb4c8b9696f38b1bebce1c851baa02b77b]
stable/6.12: [47e5e177e9e4e10da6f2759d5ce8d049e33efdc4]
stable/6.18: [925da1d2a24787f24872de13a4680437c54de179]
stable/6.6: [5a8ad63158165bacd6a1d7420e0fe5364c913b06]
stable/7.2: [443f6b93442b10b972a16f57ceaaea75b77892b6]

CVE-2026-98502: HID: alps: unregister DualPoint Stick input device on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98502

Introduced by commit 2562756 ("HID: add Alps I2C HID Touchpad-Stick
support") in v4.8-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa9dde93e05a837645fdfd577eea71f0733f0694]
stable/6.12: [1170ebfba562b3938ff7749b2e42e4420f19436d]
stable/6.18: [aa4845a710ae9fee6a3831f5c338904cea77c3aa]
stable/6.6: [bd9571812d02242b6bba2637fba924a78a5c6fa8]
stable/7.2: [978e801750c7b0859e87eae619f7d88fcd88333e]

CVE-2026-98503: packet: use ubuf_info completion for TX_RING packets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98503

Introduced by commit 5cd8d46 ("packet: copy user buffers before orphan
or clone") in v4.20-rc4.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [9518405613863d0bf0700927a21367f5942cf058]
stable/6.12: [e67c455d79fbf709a94965f09a2be6bf4f4ba5fd]
stable/6.18: [eda9bcb721f15a93746a99eabda33d80b86404fd]
stable/7.2: [2a0c9afefc0ecea2cc30ccfbbbc98182a0986191]

CVE-2026-98504: PCI: of_property: Omit bus properties without a subordinate bus

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98504

Introduced by commit 407d1a5 ("PCI: Create device tree node for
bridge") in v6.6-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8805840aad73df7146778be243a196d48b4f6430]
stable/6.12: [a6d97d10e49ae49026ae13af6c41634fce470a37]
stable/6.18: [879c911f77b8a7862aa16079b04efc3fdc5d32ec]
stable/6.6: [ccd32fa3489cbe86a0b281da4447b4c7eadb3518]
stable/7.2: [aee774588abd78f75952fd34c3fa461bc46b62c2]

CVE-2026-98505: mm/damon/vaddr: avoid hw-driven pte updates during
damon_hugetlb_mkold()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98505

Introduced by commit 49f4203 ("mm/damon: add access checking for
hugetlb pages") in v5.17-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39c0ceedd54557bdc1542de08d22b2ed33e534e4]
stable/6.12: [00457981327c80bcc56e07d4714fe189337a19fa]
stable/6.18: [e59cb7eda7c06334a0faf5aa44adb6acf2a1287a]
stable/6.6: [7ed1062d154ec2401f2c894fd6858598bb1160b6]
stable/7.2: [6e74ffc9ecf6ec24eee117150da78a1102be74c5]

CVE-2026-98506: mm/hugetlb: do not dissolve gigantic pages without
runtime support

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98506

Introduced by commit 6eb4e88 ("hugetlb: create remove_hugetlb_page()
to separate functionality") in v5.13-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a363c62a653cc8b3e21da9545fa4e028ef50f9c3]
stable/6.12: [ddc1055b557506a6ea8930dfbd8d1555d6a3f01e]
stable/6.18: [ccf96a4b8626a001c13c5836d8357f31c57bbd8e]
stable/7.2: [443628f755b35bf45044f68b970b65cd531c42fd]

CVE-2026-98507: mm/rmap: fix missing barrier between anon_vma init and
vma->anon_vma publish

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98507

Introduced by commit 5c341ee ("mm: track the root (oldest) anon_vma")
in v2.6.36-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6ac0b3f6013c168f22cad97e79967accacb08e1]
stable/6.12: [a500df43cde075f6ea4b8bae495d89f2c35b3e16]
stable/6.18: [4cef512a955e4008ae4436a4fc97726976df1fdf]
stable/6.6: [465e222815c8839445d09028fa4c77e70f7f1c7d]
stable/7.2: [d348a715380bfcc6a611bdf722169d53fd01e735]

CVE-2026-98508: drm/virtio: fix NULL pointer dereference on fence
allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98508

Introduced by commit 70d1ace ("drm/virtio: Conditionally allocate
virtio_gpu_fence") in v6.6-rc1.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [846b3c64fe3e77d9db20a7e3e62dbbb637c773e1]
stable/6.12: [a8b83ed4a4b1d04c756f53e375e86d3881f66e72]
stable/6.18: [f2f1683955b95c9b958069da3050f7e8e129ff88]
stable/6.6: [9571ab7493561afb4624d69572a7ebb67d76d10f]
stable/7.2: [ecced0076b700b5896e52af10d0776be8be36b0d]

CVE-2026-98509: drm/virtio: fix memory leak of fence event on execbuffer failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98509

Introduced by commit cd7f5ca ("drm/virtio: implement context init: add
virtio_gpu_fence_event") in v5.16-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b74aad23d99b279bb34d135795f39a6d8ecdc075]
stable/6.12: [4e333e2336138f4659b1d7a0371c499f80428612]
stable/6.18: [8fa78900fd24247277c03dc7b8a2864cb12d4340]
stable/6.6: [43bfe2b60c149bf6effda25f245a00509061fa15]
stable/7.2: [ae583668f16d41fcc1b54f45848c1b6ac1d6669a]

CVE-2026-98510: drm/xe/vm: nuke PTs only after unlinking contested VMAs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98510

Introduced by commit b06d47b ("drm/xe: Port Xe to GPUVA") in v6.8-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24a22fb3c731474b68e986af6804db450fb88617]
stable/6.12: [70fddc065ac80845ffd33095b3635d59883cf7e6]
stable/6.18: [ba678c2b02e0d36b53deb5a6d5e5ea044d36def7]
stable/7.2: [bddaa5e4094c134452c29e20a26c4718827e4cb1]

CVE-2026-98511: drm/nouveau: don't bump pin count on failed re-pin in
nouveau_bo_pin_locked()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98511

Introduced by commit ad76b3f ("drm/nouveau: teach nouveau_bo_pin() how
to force a contig vram allocation") in v3.19-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a6870d3077faa501ca97760057ddca22b68418d]
stable/5.15: [a6e755acf85793a7b4d29ba27b5421af1087263f]
stable/6.1: [5cb7109f0f5f1b47b172e2d5b868d4ce3ae687f8]
stable/6.12: [73c7093e6cc1e6b181a79e16eccc4b8d4f34d8ee]
stable/6.18: [19f5a5839b308697824ff46e6213a2b4cb677771]
stable/6.6: [9924c1d64405be8d10b906368dfb1cfe0d0c6bf0]
stable/7.2: [189ffc7b6cad6390c0695031cb6c7c63472981e8]

CVE-2026-98512: drm/nouveau: RCU-free the scheduler-containing nouveau_sched

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98512

Introduced by commit 5f03a50 ("drm/nouveau: implement 1:1 scheduler -
entity relationship") in v6.8-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7eae6d8d768fabd6b59779ca7da79e02c74e113]
stable/6.12: [40edf5eefc3fd94592a91d6eb074d4fc6f606c75]
stable/6.18: [35151e9a8274174ccbb92e3b3ba7dc7a008dcada]
stable/7.2: [cd6e11b6ebe04a0a1f1435df561acada9eadc563]

CVE-2026-98513: drm/nouveau: Fix runtime PM leak in nouveau_connector_detect()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98513

Introduced by commit 0cd7e07 ("drm/nouveau/disp: add output method to
fetch edid") in v6.7-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e04611d3735543bd80a67d9d13dc13f503746fb]
stable/6.12: [87c2f8ce1100ccbbc40bfab067741edbd1f0ef02]
stable/6.18: [59aa1f8c95941e623891d46c805e8fb1257b5a3d]
stable/7.2: [780ad8e4df9f767806587d33b42372acf8fbe5e6]

CVE-2026-98514: drm/nouveau: Fix gem reference leak in validate_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98514

Introduced by commit 19ca10d ("drm/nouveau/gem: lookup VMAs for
buffers referenced by pushbuf ioctl") in v4.18-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ea72f7b7139b123713a7983448f910bc4514d9e]
stable/5.10: [af2f48c12365866abb327d75c21a13bbde84719c]
stable/5.15: [3c80e069470cf73c357c9edb5ec5fba20e6f6a98]
stable/6.1: [957619120c26d6727efd18504e6b488673d3900a]
stable/6.12: [8281930fc194ad448aaa5de8dd47fb6fb1cba327]
stable/6.18: [030e93fc91d55d9487b3b85fc0712bb795d77834]
stable/6.6: [74485cdc343060fce08f8f3990da524d783e43a7]
stable/7.2: [9e13c398a23445baf38f0a59033dd9872a2bfe20]

CVE-2026-98515: drm/nouveau: fix double-free in nvif_vmm_dtor

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98515

Introduced by commit 20d8a88 ("drm/nouveau: tidy up the client
init/fini interfaces") in v4.11-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97077ac87afe9e91ec074ef0be64454e7ccbf344]
stable/5.10: [023e7a01f8fb27799f0987b5bcda325d73a2904c]
stable/5.15: [375901ac0f286e81be00a4126e57d488cb401884]
stable/6.1: [bf542ecd4f60d4689818d194e7ca74772fe0f8b5]
stable/6.12: [279e5ac137370e274a09dd552547ae6bddd0d4d5]
stable/6.18: [109a8d2d5b7d2719ebe09df3f9241023900b3846]
stable/6.6: [f09f4a536935b15539f2de9fe775a2641202be90]
stable/7.2: [872a5473c02a26c955be44d52b7ab2f8ea70a2cf]

CVE-2026-98516: drm/nouveau: Fix bridge reference leak in nv1a_ram_new()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98516

Introduced by commit 2fa6d6c ("drm/nouveau: deprecate
pci_get_bus_and_slot()") in v4.16-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67b4411538c8341692548429d43256f25be99f7a]
stable/5.10: [add5e0a45e3971df9c65cc7b59c90559a25dc5a9]
stable/5.15: [2bda86f1fb2373a2ad8900341d5d6a6d68ce6ddb]
stable/6.1: [9ffb43369ae51af5d5646b1ef680ab1af0fb4ad9]
stable/6.12: [553c86816e99855d6784eebd2588d5d2198c280e]
stable/6.18: [6d497216c10af3dc9747b399295f385fabbac9e5]
stable/6.6: [ac4f1d28498b9798fc20f91f23a4256032186370]
stable/7.2: [3e0861ebb9ecf0b726ea42123bd579362ec1f977]

CVE-2026-98517: drm/nouveau/uvmm: fix UAF in nouveau_uvmm_sm when BO
is in TTM_PL_SYSTEM

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98517

Introduced by commit b88baab ("drm/nouveau: implement new VM_BIND
uAPI") in v6.6-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3359a372efb6d585c97019ee1b7f1874442bcebe]
stable/6.12: [1245b4b43da67596be61600dbd746539c79495ac]
stable/6.18: [0d29bf51f8dddcf8556bf76710d3dd3024a1a717]
stable/6.6: [34d9dffaf0ff43ac395a7955b3f7b5d9d6154bf3]
stable/7.2: [5b2fffbba290ed74f381911b9986570bc10feaa4]

CVE-2026-98518: drm/nouveau/dmem: pin VRAM for the whole registered range

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98518

Introduced by commit c322874 ("gpu/drm/nouveau: enable THP support for
GPU memory migration") in v6.19-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [64ca4cdd1031206424e6455f0ae4fb0560d8f46a]
stable/7.2: [06c69c64686a31783c8bec6495dc22822d38c4ce]

CVE-2026-98519: drm/amdgpu: Fix runtime PM leak in amdgpu_debugfs_test_ib_show()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98519

Introduced by commit 6049db4 ("drm/amdgpu: change reset lock from
mutex to rw_semaphore") in v5.10-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b86ab1bd6673c525adda88819d7658ba9e784ec]
stable/6.1: [fc5606ac91642d0f184b83ab833148c457c3c331]
stable/6.12: [e016347fb1829489e062ea51a98a51f48b1d582d]
stable/6.18: [c28e74395ab09922bbf5be42bc5a6ed1ba4f3c37]
stable/6.6: [2c1a643942caae938ea84df2648a9b0c136e09be]
stable/7.2: [2556dd3a36beb3a11041ef01b5e9762e2157909f]

CVE-2026-98520: drm/amdkfd: fix use-after-free and multi-container gap
in kfd_dev_mapping

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98520

Introduced by commit 70cadef ("drm/amdgpu: unmap all user mappings of
framebuffer and doorbell before mode1 reset") in v7.2-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3a31087b1c8df679b653c1a09d9abe5ff7ec8ef]
stable/7.2: [02b74891624e09a5512c6d84f267d01fcc306a3b]

CVE-2026-98521: drm/i915: fix incorrect RCU teardown order

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98521

Introduced by commit 912ff2e ("drm/i915: use the new iterator in
i915_gem_busy_ioctl v2") in v5.17-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2da6696e0c4e60414706e607029d0bb0330c67e]
stable/6.1: [4d4ca84213327da1f84ef7af3946dea6b14c5d88]
stable/6.12: [b12e041aedcf9fa77c6002a49f07eb20d0521b86]
stable/6.18: [cc890d3f1b15bf6481dc7270fba0b4fbba572813]
stable/6.6: [c53db9cc245219af6b528ca022a17ebfa91d80ba]
stable/7.2: [2dd0190e397ec6468095fd3e80e79276a7361449]

CVE-2026-98522: drm/imagination: Propagate map failures correctly from
pvr_mmu_map_sgl()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98522

Introduced by commit ff5f643 ("drm/imagination: Add GEM and VM related
code") in v6.8-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b824c293a6b56de8285a97984c507cba56bc4c4]
stable/6.12: [13c7ae1d92ceea18d55612fa9431ca5ac77025f5]
stable/6.18: [afe5b4d66d45b278ecd0e3d6889fb208ce2e5339]
stable/7.2: [d30ea2747164992f5e720f6f53695d422bdc0346]

CVE-2026-98523: drm/client: fix restore of partially initialized client

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98523

Introduced by commit 5d08c44 ("drm/fbdev: Add memory-agnostic fbdev
client") in v6.13-rc1.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [1fca688e9443003e33cf30453e7a7560367656c9]
stable/6.12: [11edd5b6735d2e1069ddce672b1836713647f7fb]
stable/6.18: [fcbedba553a9c430079ee225df2dc7ab556a2f83]
stable/7.2: [a69c4b678db808c0d89abb8cedeaaac38d1ef182]

CVE-2026-98524: rds: ib: Clear the sg list when mapping an MR fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98524

Introduced by commit 1659185 ("RDS: IB: Support Fastreg MR (FRMR)
memory registration mode") in v4.6-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58eb1b3325edac42dc6df72c80962bd53a3c8ca7]
stable/5.10: [1be3211e6ac77adbb1eac01314d989d243b32c59]
stable/5.15: [c42d316163f89cd23de2f3e24558177a8c29bad8]
stable/6.1: [8dca3c81344532a7f05edb3d12f31f3009410a90]
stable/6.12: [4468df5bcdef959fd96494e9968f323561a45f4c]
stable/6.18: [e2ee0616260080376123997488b5cf8a3870b8d9]
stable/6.6: [49ba5ed0129906e0362c2e4b5e21c89b2a41e115]
stable/7.2: [b36d32f30c3f1e58e3a5ae79d0f52836a316b36e]

CVE-2026-98525: mctp: route: iterate socket tag list in
mctp_lookup_prealloc_tag()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98525

Introduced by commit 63ed1aa ("mctp: Add SIOCMCTP{ALLOC,DROP}TAG
ioctls for tag control") in v5.18-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26cc0e69cce062cd3aa6fae33074684669c35a71]
stable/6.12: [09299addab11857e92eca55cd8ef3350b927c90c]
stable/6.18: [e35cb500dd14882f8dee61783fccd1823fd3ab0d]
stable/7.2: [f178300e2f56ca9ec2a3a0090608730bbee0af7b]

CVE-2026-98526: llc: reserve device headroom for allocated frames

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98526

Introduced by commit bf9ae53 ("llc: use dev_hard_header") in v2.6.34-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72b5b9a28b996e09b8b5b944370c79851bb68f52]
stable/5.10: [018020f5a48cc86fdd6dc2d380f6c70443ae7639]
stable/5.15: [3a3f57c4061d9e9cc3bc04205d36ce41ae3406c1]
stable/6.1: [7c38524b2b2456bd33cb360420da6cbf9cad1b33]
stable/6.12: [16ceac2daa89dd16917bc488ab05b9dd6961a603]
stable/6.18: [e06f8b6e27cc616d3c587e9784c4a033eb310a16]
stable/6.6: [1937222c2511ac91377d39f28106c34734f5f8c6]
stable/7.2: [3361c93e417384ebf28003e0fb6d5304653d3b05]

CVE-2026-98527: gpio: zynq: fix runtime PM leak on request error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98527

Introduced by commit 3242ba1 ("gpio: Add driver for Zynq GPIO
controller") in v3.17-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9438ab5328a177c9c0e5df87eb92a7162841e98]
stable/5.10: [e380fba02908b809f5bbef371259003cf5887bb4]
stable/5.15: [a3e9b7f7c9558f8c9592f8f817557bff98707bb3]
stable/6.1: [60a76cdd92e25f576dc58d756a565760dde1f7a1]
stable/6.12: [6e05f1c614a57a5d4c364dd12e20c6fd012f9d3e]
stable/6.18: [58a417a19d80141fff3abe6004e2e47285506e73]
stable/6.6: [25c08be2a5e7715f19a6e02bbe9b0e5f01c77aac]
stable/7.2: [6e20dabffbcd7b222d8e7bb85a7d8e8325df7699]

CVE-2026-98528: gpio: cdev: fix kernel stack leak to user-space in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98528

Introduced by commit d83cee3 ("gpio: protect the pointer to gpio_chip
in gpio_device with SRCU") in v6.9-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1feb5d39b05afd902ed9fc902ec5b15be03a4bdb]
stable/6.12: [8460ee5216ab9a38263b01dca4b0a27e083f70f3]
stable/6.18: [cf3d043582e106a0e57002bec8a6de8929ba3e1c]
stable/7.2: [60a466f231905cd96ae6f0f3c44a710c97873dac]

CVE-2026-98529: gpio: arizona: Fix runtime PM leak in
arizona_gpio_direction_out()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98529

Introduced by commit 27a49ed ("gpio: arizona: Add support for GPIOs
that need to be maintained") in v4.13-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9d810279f84b30738f7790c0ed15f8dd5b9024a]
stable/5.10: [40c010c1866382cb63ba7497d6ec74fcc60ab9cf]
stable/5.15: [61ed58b745c1186006b8357da651abbb7a6bff17]
stable/6.1: [5c8e87f33b68557a725e72f34051299f55c6fa9e]
stable/6.12: [9ee200f484983b0a178c593e57d2fe3e67061ee8]
stable/6.18: [a9f738487c11fb512dadef097b56020239c21810]
stable/6.6: [9d8d6cddcb7c0b8125f3a9e52492e929674009d8]
stable/7.2: [39748357db26b20a02ea2a25ce48943e6c6d6286]

CVE-2026-98530: kprobes: Fix permanent hang when flushing the kprobe optimizer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98530

Introduced by commit 73c12f2 ("kprobes: Use dedicated kthread for
kprobe optimizer") in v7.0-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5bfa9f1a9dcb6ecb607adbc1c0226605c972935b]
stable/7.2: [f05a01fc7d4f731b4c100d2aef1e85ad77728862]

CVE-2026-98531: ipv6: sr: enforce exact attribute length for SEG6_ATTR_DST

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98531

Introduced by commit 915d7e5 ("ipv6: sr: add code base for control
plane support of SR-IPv6") in v4.10-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d959c75c27f90e9ec489d18ce5ee6b852ad4741]
stable/5.10: [050a0aa3c80907b8c60a396b7e04d48d8b1a9e70]
stable/5.15: [209eefebee54c4a5f01d68b61e8ac9881eca2de9]
stable/6.1: [e3ac68c1cdc2535d127b2bfd50c263d16c8e4199]
stable/6.12: [195813bb7324c338eaba0aaa02b18681ee65b670]
stable/6.18: [6fcfc362344edea745a69f3a705de50b731f3418]
stable/6.6: [66bf65fa109326e4c4ddeb0b94093379f72838fd]
stable/7.2: [94214cf0a08dd2c5f37aeeea46078d9dfe8e4a0e]

CVE-2026-98532: ipv6: do not let ipv6_find_hdr() return an offset past
the packet end

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98532

Introduced by commit f8f6267 ("ipv6: Move ipv6_find_hdr() out of
Netfilter code.") in v3.8-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee319bd3a0e976af5087cbe59ebc50a66f31d202]
stable/5.10: [ca96b38730e31357ef4a9d76af1336958ac670d7]
stable/5.15: [531255de8971c06d5d5986f85fdc2525d707ba71]
stable/6.1: [543354c6efb27eae3372a3a9674aeaa2a86e2b2c]
stable/6.12: [1c70275ca87e769e1a52abc644d61372d8c016cb]
stable/6.18: [1d42828565889632068fbc2983c34d57c66af4e0]
stable/6.6: [dc92cb972e86790b8078337ec41015b748b8f8e5]
stable/7.2: [4254d5878c320c19961dd0b8e1d0aca4800d8b7d]

CVE-2026-98533: ipe: protect the dm-verity root hash with RCU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98533

Introduced by commit e155858 ("ipe: add support for dm-verity as a
trust provider") in v6.12-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2776e9c28513a1c855a94792b292cbcc533418c8]
stable/6.12: [3bd335ed62444bec61201df7d368a0779e5bd300]
stable/6.18: [599d0498a39319285afa908762e0c9fad29f772e]
stable/7.2: [d7c5bd3159235edb0f2febe2cd3d3b0fb53986f1]

CVE-2026-98534: ipe: fix use-after-free when auditing a newly loaded policy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98534

Introduced by commit f44554b ("audit,ipe: add IPE auditing support")
in v6.12-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9814077275eca36ebf8d510d2f076d235ff9f51a]
stable/6.12: [b72d6c72b4bfbc021e8e127fa13e0f27d09be737]
stable/6.18: [48f7d0233c3cc8d986d1177d0e5dd4af435e7265]
stable/7.2: [e9015d32752fa228ef2f0e07fd93fc53a4a4c723]

CVE-2026-98535: fsl/fman: Fix clk reference leak in read_dts_node()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98535

Introduced by commit 414fd46 ("fsl/fman: Add FMan support") in v4.5-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a644f09b2090ad22a13fbcf9d141084f573108ef]
stable/5.10: [874fd58b321a9238e47c2a46345444287f2a5781]
stable/5.15: [c2edf376d7804279878b207d93ffe6009c8d3d29]
stable/6.1: [5c90f99ba74b55ddd8e919224921033cc4077f01]
stable/6.12: [9fd6d0861ae2fd44c771d6bc93b29bbc1202fe8e]
stable/6.18: [c2a5e591858629b6c0e284010d2ccdbc22fd0a43]
stable/6.6: [e560bdf62b11dcaa2a018345f76869d89ed43a9e]
stable/7.2: [cb52f9f188c3174761ad3b37db9de751e002b52c]

CVE-2026-98536: writeback: report a Tasks-RCU quiescent state per cgwb
drain pass

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98536

Introduced by commit c22d70a ("writeback, cgroup: release dying cgwbs
by switching attached inodes") in v5.14-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [407a5d205179a4ab186571b0e16ec42725dc77bc]
stable/5.15: [863049b4018237d1590cd13b16e9fe9c0faad2c6]
stable/6.1: [42462b5bb0dec57db7f85d0f77655c737d45754d]
stable/6.12: [4eb889649eaf65f4a5727b04ba1c017b7d05bb16]
stable/6.18: [fd3bf32279df98751364b3609eb100a3e42f253b]
stable/6.6: [ebf1555ad2821be06f87a88ffd9a2cab8d2200e1]
stable/7.2: [260f586a80e7f624dd7f069898a75a904f34d373]

CVE-2026-98537: workqueue: Fix NULL current_pwq deref in flush dependency check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98537

Introduced by commit fca839c ("workqueue: warn if memory reclaim tries
to flush !WQ_MEM_RECLAIM workqueue") in v4.5-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db6365ced4d5855e321f772b240c0e473bcfcdd5]
stable/5.10: [8ffececcb88262389b4f91fed0fe4884b68204bc]
stable/5.15: [9bb739a5c5a570c28a62afb98e9326e2a49743c1]
stable/6.1: [cc190a6a1d20b87e6a9435202fc2a3bd84c79fb3]
stable/6.12: [0c6b9b1e295aeff1132ac7aa738148cc65f06485]
stable/6.18: [1dccf5dc2f8fe688270b261ca4216e03c6a1e674]
stable/6.6: [513121e69388604619ea8c0ee07e86a3d1b5b5dc]
stable/7.2: [f97e6d0572d1b39998e053732332bc3cfdd0b9aa]

CVE-2026-98538: writeback: bound cleanup_offline_cgwb() rescans by
rotating scanned inodes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98538

Introduced by commit c22d70a ("writeback, cgroup: release dying cgwbs
by switching attached inodes") in v5.14-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6988c90671e83db79df1b7b9d6fdb0e5947fd84]
stable/6.1: [2d1da58c79b66646721a644c6eb4dd1f9c5c9327]
stable/6.12: [624dd0931162523d70f9db8c120b5ec6429a9b97]
stable/6.18: [dd4b92067238771b604b59fdda8efed6d70ee823]
stable/6.6: [c96b4d1628868e1195da1a896f79e06f350a3187]
stable/7.2: [9dac137bf77e0683778fb34c86e730c6129e8cb6]

CVE-2026-98539: fs/ntfs3: use d_instantiate_new() in
ntfs_create_inode() and murder syzbot's "WARNING in do_new_mount" saga

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98539

Introduced by commit 82cae26 ("fs/ntfs3: Add initialization of super
block") in v5.15-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1abd643f3783ea8f8e273c18697ff0413aa92dc7]
stable/6.12: [6fda7121cb6a8ea6fbd77d0f787f04b8e8b5358e]
stable/6.18: [37ec7353f4ac495b28284b0fcb0e53d21d1b3f3f]
stable/7.2: [1ae2a242c15b03470b1b16289298e597bbe3bb29]

CVE-2026-98540: fprobe: Terminate the fgraph_data list when the
reservation is not filled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98540

Introduced by commit e0a3844 ("tracing: fprobe: do not zero out unused
fgraph_data") in v7.1-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d653a183973f5283a3db5a38cd5e195eb152244]
stable/7.2: [b7459fddcb27a4b7d01067678172afa362cf660d]

CVE-2026-98541: fou: reject omitted FOU_ATTR_IPPROTO on FOU_ENCAP_DIRECT

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98541

Introduced by commit 2346155 ("fou: Support for foo-over-udp RX path")
in v3.18-rc1.
Introduced by commit 7a9bc9e ("fou: Don't allow 0 for
FOU_ATTR_IPPROTO.") in v6.19-rc7.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [d22609f3d13fc5baacd92c222731b03c593401db]
stable/5.10: [fd20220f86947d66d4dba2d76f13a28dbd86ef30]
stable/5.15: [46b1ffb7e169c7e401dd890b29e55dbc261f8f01]
stable/6.1: [7f4ba56f5d310dd018972916167985010a5d66a1]
stable/6.12: [8b43f40798bb2758489fbbcae7e841ad4443c213]
stable/6.18: [b1229b210ef5a39c58be665e6798203751411842]
stable/6.6: [3bcc1624cc1cdcc05b566475d6e848093ab2a8f6]
stable/7.2: [520cf06b8ea0ba5bcc1b8b982ef07f02b5e56221]

CVE-2026-98542: cgroup/cpuset: Return PERR_NOCPUS in
remote_partition_enable() on subpartitions_cpus conflict

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98542

Introduced by commit 86888c7 ("cgroup/cpuset: Add warnings to catch
inconsistency in exclusive CPUs") in v6.16-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31c88350b7dd1522792f726f79607f31bb55c50f]
stable/6.18: [241e67b60308cdce25bba66616a109759edd1d40]
stable/7.2: [0751ab665cb3dcdac224b002565f2e28461740d5]

CVE-2026-98543: bpf: fs/xattr: don't assume the inode is locked in
path_unlink/path_rmdir

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98543

Introduced by commit 5646729 ("bpf: fs/xattr: Add BPF kfuncs to set
and remove xattrs") in v6.15-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35d442ed1f86465e49df3119fb898f985186db13]
stable/6.18: [7504b677c4370c9e4b153c553ff8831c093b1ff6]
stable/7.2: [640d37fbd34d03af727dbc567f48c0203d1de6b4]

CVE-2026-98544: bna: prevent IOC timer rearm during teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98544

Introduced by commit 1d32f76 ("bna: IOC failure auto recovery fix") in
v2.6.38-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [77b1718e39e5c9f6956fb60807326af20baf889d]
stable/6.12: [28e32ace754b57534ef0ca0fb99bcbea5b13ba2a]
stable/6.18: [4d97a141e85a034566c33c7ed854c8a3e8a268f1]
stable/6.6: [f04cbdfac9b8284146995ab7ba0d054ad1d20ec6]
stable/7.2: [e09d1c6729ee4a7812128902d9274ff565f958b8]

CVE-2026-98545: ata: libata-scsi: bound the ATA passthru sense descriptor writes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98545

Introduced by commit 9798192 ("ata: libata-scsi: Do not overwrite
valid sense data when CK_COND=1") in v6.11-rc1.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [80320b278fea07ffcda3f57b67b61658e0a4e1ca]
stable/6.12: [d9a7147b93624660626cd7c3b1143715699e1f5c]
stable/6.18: [1603abb0c50420e97cf4a1feddbd5e183c5fdf86]
stable/6.6: [c698f6deabf680f8f4a1727ef2dc80fe78815fbf]
stable/7.2: [80fbb0bc4d11683c88f2f9d3997ea02fcada5408]

CVE-2026-98546: arm64/boot: Disable trapping of PMZR_EL0 writes to EL2

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98546

Introduced by commit 858c7bf ("arm64/boot: Enable EL2 requirements for
FEAT_PMUv3p9") in v6.15-rc1.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [2bc6b218717b9d08f466f88209251d54bc09b207]
stable/6.12: [bb8c90c86441c090e9036f019cf1b4d7894a2c40]
stable/6.18: [071f51188a5d8ec10535541255587976d12fc7d8]
stable/7.2: [ce71865bf43f88bed9d9218e9218e537150be506]

CVE-2026-98547: af_packet: fix integer overflow in prb_calc_retire_blk_tmo()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98547

Introduced by commit f6fb8f1 ("af-packet: TPACKET_V3 flexible buffer
implementation.") in v3.2-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56d82862a0a243ac14ba11b6d7b57ddc2d064b95]
stable/5.10: [02afd75649a4e001031ed82153a5c39312ec0737]
stable/5.15: [eb5b3838b9200dac04bfe33483db0ee8287456fb]
stable/6.1: [297acc571d5813db76b147c745b91031d5f9c960]
stable/6.12: [b2bcc6a254d6f27823a56787668ae4ee8cdb6e71]
stable/6.18: [6279211e7d2456ecd195d236c9ee5e5c6fa5a17a]
stable/6.6: [be1aacff399d519cc48d6b34354a54dd79041140]
stable/7.2: [218a944b9e035d4b47d59c69af6ca13319da15fb]

CVE-2026-98548: sctp: discard the rest of the packet on a stale-cookie error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98548

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4498467a8af06cfa3d71cb04bd7c4170dec8f449]
stable/5.10: [c0af3fd150fdc43821df3bb77e5ec74faf4dfc7a]
stable/5.15: [854c053c71459f8db7ef07db9cfa4eec5f5206f2]
stable/6.1: [965e21ea16acb394d5e5801998ca9b0adc669665]
stable/6.12: [d68c9287b3ca0d6faadc61fbcb18d1a6b5493321]
stable/6.18: [ec23855274a73906b02f0d124fefd9cb3c008b1d]
stable/6.6: [1cd246b214dc9acf4e2f11d58c035e1e672fe7d2]
stable/7.2: [6df536c5acbc0abd6f119d02e24f4a2ed97707f4]

CVE-2026-98549: tcp: prevent collapsing skbs across boundary in rtx queue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98549

Introduced by commit e8f6979 ("net/tls: Add generic NIC offload
infrastructure") in v4.18-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc6d80eb504458d6416b75a94188b268c95c6533]
stable/6.12: [1ae7aee395245874d797890380d9192bd858fb7e]
stable/6.18: [7ba87509c54cd519e7ed362e0c85e8431f066a18]
stable/6.6: [9e2a2f98e8c0197108c6d97a1fa43bfd89071c30]
stable/7.2: [08e835f5ec6e261c79d8c39f8618b3af29e3b0da]

CVE-2026-98550: tipc: reject invalid and unexpected GRP_ACK_MSG to
prevent bc_ackers underflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98550

Introduced by commit 48a5fe3 ("tipc: fix bc_ackers underflow on
duplicate GRP_ACK_MSG") in v7.0.
Introduced by commit 2f48771 ("tipc: guarantee that group broadcast
doesn't bypass group unicast") in v4.15-rc1.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.18 stable/6.6

Fixed status
mainline: [99cc2a62e07a44a22254d7beca9ef1f8ad886d0d]
stable/5.10: [edc6593c442278fceff0120e8cc58bc592168c35]
stable/5.15: [9b94a90651e1fa573c6ac6a5a6b269d5874df2c0]
stable/6.1: [507a27435b2bb1f22e3a3674f6a6553eb815021b]
stable/6.12: [478fb08d0c2a53002a721d22b8d6681ec971d90f]
stable/6.18: [12cc3a1eac5a2a06b67a7b85f0f48ff241a94d1b]
stable/6.6: [80a9ccfc24d3776ef6753a57315e726475fac7d7]
stable/7.2: [b0e517961f09b9f60d338d1ea4e17aacdbf206f0]

CVE-2026-98551: perf/core: Fill branch entries with a single assignment

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98551

Introduced by commit b190bc4 ("perf: Extend branch type
classification") in v6.1-rc1.
Introduced by commit 5402d25 ("perf: Capture branch privilege
information") in v6.1-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24b620729e53d978b3e425f55bc66efd3bab1f59]
stable/7.2: [c7de8521947a521b766979ff5c09f66fe905a5bd]

CVE-2026-98552: perf/core: Fix a refcount leak in attach_perf_ctx_data()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98552

Introduced by commit 506e64e ("perf: attach/detach PMU specific data")
in v6.15-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cca4980630b3c7a85f53cb43c6018184ce5d4e37]
stable/6.18: [23250517cd475367653f1e99396967f54c6f1b7c]
stable/7.2: [5286d4eb5cd7e10d7d93c3cc596e18bc8ad80f72]

CVE-2026-98553: autofs: fix sbi->pipe file reference leak in autofs_kill_sb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98553

Introduced by commit ebc921c ("autofs: copy autofs4 to autofs") in v4.18-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa5e44b29ffe4eaa08cc2237fd65bc2596bc023e]
stable/5.10: [3684e2273ba94553af3c5195a46a50214a1a96e3]
stable/5.15: [0662b1ff9b383d5a233d344e4dc518c27a17f7b8]
stable/6.1: [34fa4c1c6e10507dc60e35a82cc9655666946cfd]
stable/6.12: [f1c57f5b16bbc3571bd479c290996c4d4e1fb931]
stable/6.18: [4bcb371019097d0e357f097902587401c509bbc9]
stable/6.6: [a58593b501b7be5ad2bc5181bfa8cd4599be257c]
stable/7.2: [fc4fd0281ac80b5a3c5a2330f688f0f9d2a420b6]

CVE-2026-98554: vlan: ensure sufficient headroom in vlan_dev_hard_header()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98554

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd5dd68267c4238795fadaf02b3575ca3f8a6500]
stable/5.10: [55e007fc3b4d76fa4d6b4660f6904fe6ab045a1b]
stable/5.15: [5aca8e6a8ff6aeae358c1d9b65447aac416ace95]
stable/6.1: [4ba1f57313f36a3ce6f77d593548f0c511f34aa1]
stable/6.12: [cfba0f45553de2b803059e3d539a1e418df24da8]
stable/6.18: [c7ee4bea64f559ea8e03260014775b64c720cb5b]
stable/6.6: [ca797491f0ae4bfde9039f79f6f1ed7781c9110f]
stable/7.2: [90d51095371d96747f45bbd8504edf6513e039ef]

CVE-2026-98555: llc: fix skb UAF and leaks on llc_mac_hdr_init() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98555

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72f9dd522f8d6c5a00be9695c7bb74631eb5069e]
stable/5.10: [fec0fe6838a7f45175667701fb51abb23a6ffb1e]
stable/5.15: [b859ba18b5a1067f71db5618c6a4a70d55fa308b]
stable/6.1: [8b855b645841b5a04e20339a22bb6d593c9b790d]
stable/6.12: [060f827aa3dc47939ee306da715cd6700d129616]
stable/6.18: [41dcae82bece9f106b4dff0ee777bba8d157c8a8]
stable/6.6: [d360b31f1a3666579422872aa7d1a751e20b76f9]
stable/7.2: [cb3528ad8bb46fa6252f5d14ced7febddc18515d]

CVE-2026-98556: gve: DQO: reject TSO packets with an out of range MSS

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98556

Introduced by commit a57e5de ("gve: DQO: Add TX path") in v5.14-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [296c83b5ccc808c080865eb20fd7a477b0355bb7]
stable/6.18: [2dc3ae3942e151fef254b7bbb65c832192ad2069]
stable/7.2: [c517e8755960c8c6335ebf7dae6c95c43e5fb085]

CVE-2026-98557: gve: DQO: fix header length used by gve_can_send_tso()
for UDP GSO

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98557

Introduced by commit 014c607 ("gve: add support for UDP GSO for DQO
format") in v7.1-rc1.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [83769c23fb1879edc916a526ba424285033baf2d]
stable/6.18: [feab3880a72b43913d332c06b75bb80526fa47ba]
stable/7.2: [dc9e8964a21f20620dbfca4ef3e11eefa7be6451]

CVE-2026-98558: net: flush skb_defer_nodes in dev_cpu_dead()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98558

Introduced by commit 68822bd ("net: generalize skb freeing deferral to
per-cpu lists") in v5.19-rc1.
Introduced by commit 5628f3f ("net: add NUMA awareness to
skb_attempt_defer_free()") in v6.18-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06e3f54e8b22040ada01a28343badf1990b4dd7d]
stable/7.2: [c68f4157463448a76893223e117170be8374d773]

CVE-2026-98559: net/smc: fix UAF on lgr list traversal in smcr_port_err()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98559

Introduced by commit 541afa1 ("net/smc: add smcr_port_err() and
smcr_link_down() processing") in v5.8-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61cb282fe97b3b0ba32ca09417a693162bf4ae3f]
stable/5.15: [34bcf11cd2528ae00bb6d764d808083c66824277]
stable/6.1: [0edcc4284392b28826b5d37532b366b291e6e0fa]
stable/6.12: [3d35f069e1c119992000d51236dbe54da2d4e61e]
stable/6.18: [3d65a2eb4449fc9658fb860dea893025d028d90e]
stable/6.6: [00a59600ae72d24859d0ad1783a78bc921bc2599]
stable/7.2: [a9b968e42690d784c241a0761c10253271f7df5d]

CVE-2026-98560: net/rds: size a connection's path set by the transport
it ends up with

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98560

Introduced by commit 4716af3 ("net/rds: Give each connection path its
own workqueue") in v7.0-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba3d1f480c7a3fba963e7867ad6cc557c197acbc]
stable/7.2: [670f303169d2d36f315c40f6d3d18b5ee8498fea]

CVE-2026-98561: nfp: hold IPsec RX state under the XArray lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98561

Introduced by commit 57f273a ("nfp: add framework to support ipsec
offloading") in v6.2-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a983a4e14c635c40354be110cd9a1a5c94e01e6]
stable/6.12: [dd765023bb54f9650f8b9137906fb2c4a554dd1d]
stable/6.18: [8468d05aa08dc430b5675beadf6f6fb8943f170b]
stable/6.6: [c1b1639fb138db52fcfbd1747e92f2454076c6d5]
stable/7.2: [fe6c8ea8bfd5d1253bb0de682b1fcc2c4bb92488]

CVE-2026-98562: net: libwx: fix races in Tx timestamp handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98562

Introduced by commit 06e7516 ("net: wangxun: Add support for PTP
clock") in v6.15-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3173cba1170131816972ed2b6185cb970ba8b747]
stable/7.2: [e78b95cfd5df25d0c562aaef95d3c7fe6c7e0e66]

CVE-2026-98563: net: phylink: record the PHY only once bringup cannot fail

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98563

Introduced by commit 03abf2a ("net: phylink: add EEE management") in v6.14-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a940003f44e7e441c228151dd212642152700ec8]
stable/6.18: [4e7a4af364c2048bafb213bf0ef4a89dcbe1bfd4]
stable/7.2: [671a68654a9d319d7f0d53a6321db3d9b391bdef]

CVE-2026-98564: net: dsa: mt7530: leave the MDIO IRQ mappings to regmap-irq

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98564

Introduced by commit 254f6b2 ("dsa: mt7530: Utilize REGMAP_IRQ for
interrupt handling") in v6.15-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d80ba0a204c6a16bd7778b50de578dff107c0fe]
stable/6.18: [2357c682f6eaf639dec88c68b3c0c93a3b802635]
stable/7.2: [f306e465b5a2091cd3fe3dd0feb10cfc94cfb2f8]

CVE-2026-98565: net: dsa: mt7530: fix NULL dereference on unbind of
MT7531 and MT7621

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98565

Introduced by commit ddda1ac ("net: dsa: mt7530: support the 7530
switch on the Mediatek MT7621 SoC") in v5.1-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2cdef41e0b4d8ed23a5b41e6ad4e64594e055e4]
stable/6.12: [e9a5298532780ecdd05c3220f3e1e3067b3537c3]
stable/6.18: [62c0e38b2e5034184d4502ce77bd178b29e59b83]
stable/6.6: [bd172580e624bac00d83abd5c4320d2e14d853bc]
stable/7.2: [aae2a1f1e3a0ac5eeb439262a2328a2a392413ac]

CVE-2026-98566: drm/imagination: clamp freelist reconstruction requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98566

Introduced by commit 6eeddda ("drm/imagination: Implement free list
and HWRT create and destroy ioctls") in v6.8-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45585c3aa285854face65293acc95eff73063d6d]
stable/6.12: [b78f8f5532a077baa4aabccf657a4fb3b164659e]
stable/6.18: [e0560db0ea6e10c283ebe7c259a7af8d3b6e61a6]
stable/7.2: [eabd0ae3611769c826dbc118a1e240628731b348]

CVE-2026-98567: net: xps: reject an out of range traffic class

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98567

Introduced by commit 184c449 ("net: Add support for XPS with QoS via
traffic classes") in v4.10-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4da3b7b8b50f3e2fde54a4c18a82a8e3f6223910]
stable/5.10: [967e10f40a0c6732db299cbe001df0e859196055]
stable/5.15: [1cb8e40525a72c9f1e1cf94c68c172b3b9bbdc81]
stable/6.1: [6ea8f643053f33622f9116e4e1db58306ece45e3]
stable/6.12: [eff227a3cb4d0089fbb85c73480bf8abf2e5ae7f]
stable/6.18: [2cc1c3977acbffc417fb5b57699d1df3dcffb5fd]
stable/6.6: [9e841723ba482d41ecbf90241c756a16cdfea949]
stable/7.2: [930318290d8509e864c015fe6c9239470b3c579c]

CVE-2026-98568: vxlan: use one headroom snapshot for neighbour replies

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98568

Introduced by commit 4b29dba ("vxlan: fix nonfunctional
neigh_reduce()") in v3.14-rc8.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [481506a756dcd828ef42391cb08f38d8d96d38fc]
stable/6.12: [315d42ca39f69846662961c25dcf2bb07c350d14]
stable/6.18: [a3c5eb6e382dd426a5e7eb08608897ed57167ff7]
stable/6.6: [45a67662bf8ce3aa5643accf98d328dfbb47eaf6]
stable/7.2: [ff022fd9d0f0282c575e11778b96bd1b637503eb]

CVE-2026-98569: ip_gre: Reject enabling collect metadata through changelink

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98569

Introduced by commit 2e15ea3 ("ip_gre: Add support to collect tunnel
metadata.") in v4.3-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3f315be9d30eeb6938d11fa17fd4b32d52f7c42]
stable/5.10: [c80315da84998b69b8829785a174b0bf72a81992]
stable/5.15: [cff8b520312e750ad38967c30128e1534cbf9484]
stable/6.1: [1dc759571f3df14891175fc52527f7624ba01322]
stable/6.12: [2e54d53b65e296b4b4bdc2cdd3b2b58dfa8d8c5c]
stable/6.18: [bdd41b96e814300c66222cf4e47ecb8aef995656]
stable/6.6: [da2e0cfbb620b199927a1e5b93b7cfde32083c7d]
stable/7.2: [63c5e48d6f7f5722a48f63e13e961dc5302894ed]

CVE-2026-98570: net: ipv6: keep room for the mac header in dst_dev_overhead()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98570

Introduced by commit 40475b6 ("net: ipv6: seg6_iptunnel: mitigate
2-realloc issue") in v6.14-rc1.
Introduced by commit dce5251 ("net: ipv6: ioam6_iptunnel: mitigate
2-realloc issue") in v6.14-rc1.
Introduced by commit 985ec6f ("net: ipv6: rpl_iptunnel: mitigate
2-realloc issue") in v6.14-rc1.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [87cd6b717e4069dca34e0866e57eaeb44d3b173e]
stable/7.2: [36c07127924f11fc5741a780abcaaf808fe9ef13]

CVE-2026-98571: net: stmmac: clear stale buf->page after recycling on
skb build failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98571

Introduced by commit df542f6 ("net: stmmac: Switch to zero-copy in
non-XDP RX path") in v6.14-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a7822e34a0bfde31b194ac3da3253e5032b44cc]
stable/6.18: [501baaeca7d128fa0a2f6953cf5873c5b0d7cf89]
stable/7.2: [298673397ea3f6f5811b84f0d9f71eac71dda2e3]

CVE-2026-98572: bpf: Fix immediate JMP JEQ/JNE on MIPS32

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98572

Introduced by commit eb63cfc ("mips, bpf: Add eBPF JIT for 32-bit
MIPS") in v5.16-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db762fd96be225bd06161c9631160c755d891693]
stable/6.1: [1547e9f3a7d71971216e6dba30270cae13fe4e02]
stable/6.12: [6f939529ed6c580e9b6c5daa20be67fa0b3d4cf0]
stable/6.18: [876ef04c75c2751acfd355606fca3eced71dec65]
stable/6.6: [beeae92e70e705e90a0d6d9b3b8498ee3b92f495]
stable/7.2: [1bd91670966a7142ac94f2cebe2b5ae6bf5cb0c8]

CVE-2026-98573: net: skbuff: fix pull-bound underflow in
skb_checksum_setup_ipv6()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98573

Introduced by commit 1431fb3 ("xen-netback: fix fragment detection in
checksum setup") in v3.13-rc4.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b4e0b0c008a8c1b474730248cd5b873026c74bd]
stable/5.10: [9c4e432132a97b82edf28fa172c39f743e6bfb26]
stable/5.15: [718747afa5463d9cc5fd9a09f03b2a492edd9b78]
stable/6.1: [a0ad0473c09d2e947aecac5c82e637ec85924b12]
stable/6.12: [6c28c31f051dbf49c71ba7ab7bb9bc905fa1d14b]
stable/6.18: [cfa643f2ca36c6f913fe1a2ceb12412ebb0fd962]
stable/6.6: [b2da5ed3d8c75e1b729a21b6d3beaed415e263f6]
stable/7.2: [d7f474226809471dc7877435e9c492cc914df0bf]

CVE-2026-98574: net: bcmgenet: stop Tx NAPI before disabling the queues

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98574

Introduced by commit 254f323 ("net: bcmgenet: revise suspend/resume")
in v6.15-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e87508b5c4d81210d0a736ed01962e52f5c4c56]
stable/6.18: [63bcc2fee6419963e45e7c2cd698fa862409601d]
stable/7.2: [f329d42423089904758f2685cda295de9bf99441]

CVE-2026-98575: nfc: pn533: fix OOB read in pn533_acr122_is_rx_frame_valid()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98575

Introduced by commit 9815c7c ("NFC: pn533: Separate physical layer
from the core implementation") in v4.7-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b61732f47316d45f27706db7812950145d3327b5]
stable/5.10: [8db3b1e012a8b25078dfa1efabe3d0cd2916dcba]
stable/5.15: [74b3fbc60907ee97e3af3249091f57351b53a6d6]
stable/6.1: [8a0f1bb790d964893db7fc59febda9a534db07b3]
stable/6.12: [72b8b2126e854d6756a1aa4bdc66d7457b832294]
stable/6.18: [e72cbedc4596e808d22dd2b9fff666ece76f8dd6]
stable/6.6: [ea82b7576793219fa10a8b545f8338998b2a9ce2]
stable/7.2: [2450a388367231fb7dd798538f393af227c00c4d]

CVE-2026-98576: nfc: llcp: fix slab-out-of-bounds reads when logging
service names

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98576

Introduced by commit d9b8d8e ("NFC: llcp: Service Name Lookup netlink
interface") in v3.10-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7dcf371a35632f035baf77bcf2c129165f772ce4]
stable/5.10: [75f7c5a42fa1483f5912279a749417c284ad708f]
stable/5.15: [6d4ca872830e46fcca9c086bf19fa9bd2faf09d2]
stable/6.1: [a143f7835faa4fe0178448289feea4f84eeee8d6]
stable/6.12: [8afb6c194f5781798d3ab3edf243cf5a24a9d1f9]
stable/6.18: [8978dff632519712d1fa432991e1f2e857f90239]
stable/6.6: [75bfd9ef4da2fb49dac1f19880d2ac4ccd07b45b]
stable/7.2: [4262b12277a3e056c95fc49e9c4d7bd97035d16c]

CVE-2026-98577: nfc: llcp: fix WKS SAP hijacking via prefix match in
nfc_llcp_wks_sap()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98577

Introduced by commit d646960 ("NFC: Initial LLCP support") in v3.3-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [408cff6bd60636df201274d320edfdfde9ed41db]
stable/5.10: [0c83a8a45fed256ccc5fe7160b436b671fc79fb8]
stable/5.15: [aa555ed5ed0d15efbaf27e0e9f152a6df715278a]
stable/6.1: [32b5f0b338bf59391a1cff9a6190a72c4d2c1ba8]
stable/6.12: [bf41af8f910cbb5d776a1dfa0671d31a7e262e28]
stable/6.18: [f234197f3bda3aea5d4b1e591d6bcb3660a8b3fc]
stable/6.6: [6fad2c34d451d11a9f3f946cae1105fee91d96b8]
stable/7.2: [0a0412745c86acd089c6460da715ab966b1615e7]

CVE-2026-98578: nfc: st21nfca: validate ISO15693 inventory length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98578

Introduced by commit 7974728 ("NFC: st21nfca: Add ISO15693
Reader/Writer support") in v3.16-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f2ea5ed588c03d481f0301e6c3d4240132383fb]
stable/5.10: [e47b2a350bb0ff123434ec5484c6dc3333b0727c]
stable/5.15: [57d183764f3002f9625ee4deeeb20716c519534e]
stable/6.1: [3af2ea4035581a1607d9830779c187a0c7e225aa]
stable/6.12: [6353dae51bc9b3cad13c9d890b53311a46c96b4e]
stable/6.18: [fdd95e819d828c975aaeb258a3fed5dd7fd136d0]
stable/6.6: [9fa21b0f78adb514e3bd96a505ddb752e9727ff3]
stable/7.2: [a86987d03a4d39acdbe4533d83db4d656ea36c59]

CVE-2026-98579: nfc: llcp: fix sdreq TLV list leak on parse/alloc/send failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98579

Introduced by commit d9b8d8e ("NFC: llcp: Service Name Lookup netlink
interface") in v3.10-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66f4300206b82b0b143ef0d9be90cd8d29f23a47]
stable/5.10: [5b1eca82085134bd92cd3810b0ef003c91e3f668]
stable/5.15: [d3f60a7fc291d08cd9192a3b4cd5d3a223fa7d02]
stable/6.1: [755bfc409748d8f3df64eb0eb26926270de3dd77]
stable/6.12: [08d2c069239ab425fdd333784a6a3b3e034e4aa0]
stable/6.18: [cbde7f5d326172d6dbb55cca0df42fa7e1ed8115]
stable/6.6: [e43ec0191c1630f41e7043ac729ea6f1b8044a7f]
stable/7.2: [0b01a946b0f234f5badd25968610b585a4895f08]

CVE-2026-98580: nfc: llcp: Fix race condition in accept_queue lifecycle

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98580

Introduced by commit 50b78b2 ("NFC: Fix sleeping in atomic when
releasing socket") in v3.7-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3eef2f988a3db9690369d7cef9a3344dd9788d3]
stable/5.10: [54adcabb0f1deef1bdae5fc64779ed6d442721c9]
stable/5.15: [7c938aad5108382c6ad7453c4b5ee8ae3f3252ed]
stable/6.1: [d2093a0981138876212bc5f473bdbfba0786e064]
stable/6.12: [53867f6acb1af7f12d6485fa8a2819318f89083b]
stable/6.18: [da8a07757383614a8380a0f7dd54749d2687b82e]
stable/6.6: [41256821762a7114906b178826d17098e2fa5992]
stable/7.2: [d5e1c92d09caed19f2988739695ce611a86ba6f8]

CVE-2026-98581: nfc: llcp: Fix list corruption / refcount desync in
nfc_llcp_recv_dm()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98581

Introduced by commit a69f32a ("NFC: Socket linked list") in v3.6-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf1460acdf8cf5a07c819f59785d40f20d113099]
stable/5.10: [dd2d24add86b3b63cd87cf2feff98ae119ba19a6]
stable/5.15: [812731dd8511f5768f4ff279b3c18d85cd21da4b]
stable/6.1: [dba1d9c7134afcb4b1bfad8c1b1b3f0ab5189b08]
stable/6.12: [7fb2c0eeb79bfad64065f539a453138abd0edda6]
stable/6.18: [b94cf09720543cc34256c7aa88f8059cbe7c0419]
stable/6.6: [c1e9ed52a6697354366dddf190fbacee8ed2f7c5]
stable/7.2: [320a2ff49bdce3f9a437b9a9ff341ff27d3bdbf1]

CVE-2026-98582: nfc: st21nfca: validate received frame size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98582

Introduced by commit 3096e25 ("NFC: st21nfca: Fix incorrect byte
stuffing revocation") in v3.16-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a653c01ce447f10c36b901646888c0330363af4f]
stable/5.10: [8934d2889ae16a7c77520e002398d0689c1ecea5]
stable/5.15: [d0596ee6c4b928a5c288790522a7495ee867da72]
stable/6.1: [f526c218a149a30f110ce434ff17e033042404b8]
stable/6.12: [91be5161f37b0a2795ad6806d69be5fa74522e5c]
stable/6.18: [57919d0662d8856211b794140172e51ca389f23d]
stable/6.6: [d4008c3499dba7829bfe002edd99a8bff8ae3a7c]
stable/7.2: [7b996cc06dda54c02a5aa607bda01109f0ac51e6]

CVE-2026-98583: nfc: nfcmrvl: validate helper command length before pull

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98583

Introduced by commit 3194c68 ("NFC: nfcmrvl: add firmware download
support") in v4.4-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [686f942332b1667f13f3b8d6a2f50bcfbf42e277]
stable/5.10: [842c0603cfa49530ef081f181a2ddbba77a37231]
stable/5.15: [e4b012240c8aaf57cec192234c24e0db5f531ffa]
stable/6.1: [f15ad9d6e9173a037587dded77c904fdae8df380]
stable/6.12: [4d4601e182c8567329be7d919669ec4d847ddd93]
stable/6.18: [ed2e00bb22c73156bf8030b6204deabb25cf4eb5]
stable/6.6: [a4e56f57dd04d8f9bc6bc55f90f3d129da759ec9]
stable/7.2: [6a17a5806e9fcd99cf0dd30c3e6301f2aa1fac3c]

CVE-2026-98584: net/sched: fix potential stack infoleak in em_text_dump()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98584

Introduced by commit b04202d ("net/sched: replace strncpy with
strscpy") in v6.17-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c572a83037a7dcd653ba3a9cc468c16b857d0c9]
stable/6.18: [9923e1c537f91f3530b52d4efce85f3d9c131bf8]
stable/7.2: [0b160417826d22f24fc31a5b9cfae3b14aa70f76]

CVE-2026-98585: eth: fbnic: Avoid rounding zero ring sizes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98585

Introduced by commit 6cbf18a ("eth: fbnic: support ring size
configuration") in v6.15-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0160953d8eec75c3c55562158c46442ff1fd410b]
stable/6.18: [92c9f2ea634d92adff5403d231ebeda683c5685a]
stable/7.2: [491aa3167ae02f219cb2d2de6f4196d28dca03be]

CVE-2026-98586: sctp: hold asoc or transport before mod_timer() in
timer handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98586

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cae23ae3f7887a1cf8a75da38edcebeef695040f]
stable/5.15: [f7dea7eaea20fe9b80f8f77ba44d02b4a17f8050]
stable/6.1: [f9d929026d487a988bfa12c065f892e823e5b6ab]
stable/6.12: [27c51a9b55b227309161c903f9ecfbf022516bc2]
stable/6.18: [d18cb8fd1b6ba95c85de644203cfe1b071ff0c0f]
stable/6.6: [9d3d39da054476e7aa05cd877b93ca73a9a77434]
stable/7.2: [35bf3b23c9a871f44c1453d85f8332be4e088dda]

CVE-2026-98587: firewire: cdev: fix back-transition for
iso_resource_auto client resource

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98587

Introduced by commit fcabbf4 ("firewire: core: move
allocation/reallocation paths into specific branch after isoc resource
management in cdev") in v7.2-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c6b51091cafff9ce6c03c1416aa13864d17ab97c]
stable/7.2: [ee1df60a0d0e8ab4b00137135733bdadd6d33dab]

CVE-2026-98588: bpf, sockmap: Reject max_entries > INT_MAX in sock_map_alloc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98588

Introduced by commit 0d2c4f9 ("bpf: Eliminate rlimit-based memory
accounting for sockmap and sockhash maps") in v5.11-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [814a81c842bd88f6bd8a4ce550d560df071a5d03]
stable/5.15: [f4a73f49e256bd835368504462be3b57b03febff]
stable/6.1: [c56191af3a578b9cc265fa3bd5fc0752c59c1781]
stable/6.12: [cc70972ddbf0e3398f2f32624d31db78594d50d8]
stable/6.18: [cea597519b9ca6d691c98d92460ead8ece2a07af]
stable/6.6: [909f761868fda329dc69130ef9eb5b5795bcdf00]
stable/7.2: [ba7d627dbc67d62df2fa66d7b41e743c3ace0ec8]

CVE-2026-98589: bpf: Reject pkt arguments in mutating subprogs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98589

Introduced commit is not determined.Fixed in v7.3-rc5.
According to the commit log, this commit fixes 80f2816 ("bpf: Support
pointers in global func args"), but 80f2816 is not in mainline. This
should be e5069b9 ("bpf: Support pointers in global func args") in the
mainlne.

Fixed status
mainline: [a6c1edfbe240e4377038a0e1d233ad81fde9a21b]
stable/7.2: [0b6b2bb9b90ad1e2d94d18f626258a1dbbdee0ea]

CVE-2026-98590: bpf: Fix bpf_sock context code generation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98590

Introduced by commit c3c16f2 ("bpf: Add rx_queue_mapping to bpf_sock")
in v5.8-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a4852376e3a2727ea40e61143d6d7c22bb6dfad]
stable/5.10: [e3ddcf4aeb342d4de2e5761c7042270d454752de]
stable/5.15: [4a41d064facc3330e176ecbbf5b0026ed18a5c69]
stable/6.1: [70288599d1754e157df8326239316dbdf08ea33c]
stable/6.12: [b3f37afc7fd7c52bc2114310aff1eb24c7cd4d73]
stable/6.18: [d95dd5a6c6cd08d5ae466d3aed27b3cf59155a6c]
stable/6.6: [ea4dc96c902ccfa49dd3e4f23c443dab4a74b018]
stable/7.2: [84ebb991ae985149079ae9ab51b7e3ba25a9ff53]

CVE-2026-98591: bpf: Fix bounds check for skb-backed dynptrs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98591

Introduced by commit 6f5a630 ("bpf, net: Introduce
skb_pointer_if_linear().") in v6.6-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed6eec97b534979dcf28b40c389cee57bd6561d4]
stable/6.12: [37877a24758068742fef687a7cf5362360dde1d1]
stable/6.18: [1196903a27cac5c929c7517e987a8d159f20c5e5]
stable/6.6: [1b923538598be768e9f2f258a77a083d00e0c78b]
stable/7.2: [39ffceaddb10753eac12785dba6ac0673860b4ac]

CVE-2026-98592: net: spacemit: clear TX descriptor on fragment mapping failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98592

Introduced by commit bfec6d7 ("net: spacemit: Add K1 Ethernet MAC") in
v6.18-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d14720beb58870b15a52b236c3ab0be0e06e915]
stable/6.18: [ca9986cc824f2feb79b4a83e5f6f4c24c2140448]
stable/7.2: [3001a103a367c6051c43aff363b6979c10e65347]

CVE-2026-98593: s390/debug: Fix NULL pointer dereference in debug_info_copy()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98593

Introduced by commit d72541f ("s390/debug: add early tracing support")
in v5.15-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [012bfcd5a51082d5a65f096dfb9ca652b5267965]
stable/5.15: [13decd3b3b3a4d8a2e603fb8c9ffde0c6be3c225]
stable/6.1: [a19bede30f0da5ae56782edac62b5998a7434cba]
stable/6.12: [2de9c458cc49d8db6408a7c5fbf0c7c94fe4d52b]
stable/6.18: [9c6af88fbefbe77608b77409df23a1617e28398c]
stable/6.6: [33f706884821da9cb55b650b7b1d4f2bdf800137]
stable/7.2: [c593f38e1cdb92f87d01be4c4e5ac12417b1454b]

CVE-2026-98594: tg3: clean up PHYLIB resources on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98594

Introduced by commit 158d7ab ("tg3: Add mdio bus registration") in v2.6.27-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a92e1a412c53dc0d9ad639e7abf8b3fc70a5b6ad]
stable/5.10: [ce86d6929d03e6b0abcb781dfa50f9f0816bff78]
stable/5.15: [a449eedb3b1eb5b8b1f5ed116a1bfe85eaaf81df]
stable/6.1: [0844402326d4e48a28688f93ec6442e93bb442fa]
stable/6.12: [d2abb0013b933d59ee441185df0eca9e8c0b33eb]
stable/6.18: [6515c41503eef849abd2c7364f34e4bb25110f90]
stable/6.6: [e766321288b507afb70d2bfef6ba443213329f79]
stable/7.2: [b6c0c757c65893ad7bb17e8bcf33cdd8257d7b3d]

CVE-2026-98595: udp: remove a disconnected socket from the 4-tuple hash table

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98595

Introduced by commit 78c91ae ("ipv4/udp: Add 4-tuple hash for
connected socket") in v6.13-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9e95b1a94c9c49b4ba722251bbca2759b9c51737]
stable/6.18: [c21daf37d5ce9a4e234b7c42238ac1e6041e28e4]
stable/7.2: [d1b5fd969cc53f29d02b82b05a45135de4a6087a]

CVE-2026-98596: ipv6: Fix dst leak for uncached routes.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98596

Introduced by commit 98aa546 ("inet: remove (struct
uncached_list)->quarantine") in v6.11-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be31fe6333f534155e6b408f1ef6d77974bb41aa]
stable/6.12: [5045aa25f3790dcdb158a58ac60ccf8da42959aa]
stable/6.18: [ed902d5546fb9c142b3216d8eec914fa1bc0aa80]
stable/7.2: [f9722746df13a8a29103c847ef56b02c11ce0963]

CVE-2026-98597: net: usb: sr9700: include receive overhead in the length check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98597

Introduced by commit c9b3745 ("USB2NET : SR9700 : One chip USB 1.1
USB2NET SR9700Device Driver Support") in v3.12-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c06bde80ae7a7b595732f7cabcb92cf08db9d56a]
stable/5.10: [92d88c88390fc62444c00a1a22078f838e03891f]
stable/5.15: [baf07d5153d3af8f98e65e2d3566bc0d50c4e3ac]
stable/6.1: [8488779d9bddbdb33588c9fc2c0657a3da773f61]
stable/6.12: [9b59b00890c5dea355b4cc8795ab8eeafc044e48]
stable/6.18: [6ab6c9d120b30c94579192ef83a581a3dda6d79c]
stable/6.6: [e1f5b74edccf4c9b671b6bce4435a98746fe5167]
stable/7.2: [05b442709bd5256c6c0e11fe56b9a0cb2455c245]

CVE-2026-98598: ipv6: Prevent rt6_insert_exception() for dying fib6_info.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98598

Introduced by commit cc5c073 ("ipv6: Move exception bucket to
fib6_nh") in v5.3-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0346ec2f080b40d95ed05b853bb9226289e75212]
stable/6.18: [649ffc76ed5483b2caf35ed90d3787538efc4e53]
stable/7.2: [e03e77071e75ce726d877f0a4349a28b6e1f487a]

CVE-2026-98599: bpf: Reject non-negative offsets in stack_slot_obj_get_spi()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98599

Introduced by commit 06accc8 ("bpf: add support for open-coded
iterator loops") in v6.4-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79a9172f3ab4ad8392c5e5c8944b9b7710ade620]
stable/7.2: [89a7241fc7ecc1b5e47c3f071081e314523b8d9d]

CVE-2026-98600: Bluetooth: RFCOMM: Reject short EA=0 frames in
rfcomm_recv_frame()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98600

Introduced by commit b230e5b ("Bluetooth: RFCOMM: validate skb length
in rfcomm_recv_frame") in v7.2-rc6.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/6.1 cip/6.1-rt cip/6.12 stable/5.10 stable/5.15
stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [6d91041bb38b97e2feb625123cc0529d7b83a0e1]
stable/5.10: [76876fd26569302d26d91cbe8b75fa8e66cf8969]
stable/5.15: [97711b964877242933484989224a3c4c5d88a5ee]
stable/6.1: [7a1781a2f3a9667b3065d402d1f11986a2363e08]
stable/6.12: [71ccacde407b7d8f0ef48974a0d2524602fd5c44]
stable/6.18: [be00deee60044ffa820f9436415caeb665b2cda0]
stable/6.6: [c25587fa26761e623198b4f47151fe79d09ccde6]
stable/7.2: [9240fc1f2cde5331c61608da21b00394602ca762]

CVE-2026-98601: Bluetooth: btintel_pcie: validate device-supplied DMA indices

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98601

Introduced by commit c2b636b ("Bluetooth: btintel_pcie: Add support
for PCIe transport") in v6.10-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [37a11129345337efd6eef8e62b03b6348cd0dd8b]
stable/6.12: [f42cd95e679d5b78611cd2208cd1c41ad0045ffa]
stable/6.18: [8ec5838a35b03ac0cf3602452a369898051ffaf9]
stable/7.2: [b29b70bfa12133423924fcd0327c19a802f7e368]

CVE-2026-98602: Bluetooth: bnep: fix out-of-bounds reads on short
RX/TX frames and control fallthrough

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98602

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0ca020cbb9bb7f3f4ea8ba1dfcf30a282aec91e]
stable/5.10: [7af80ad2cebfe2f1879d6a39a1aaa061d9c4e1ca]
stable/5.15: [667aa703e11cdc237d169393bc6a5ea9acbb33c2]
stable/6.1: [3e605ff5932afe0970c2beca66f2f1ba2babe4dd]
stable/6.12: [1e7aebc188f889b56c3aaeb6133ef6d77022c887]
stable/6.18: [8f31031326994d1abfcc6ebb6927ef96e51fb9ff]
stable/6.6: [035f9b1809861967e58ce652680d70ea1502058f]
stable/7.2: [ad0d2d4ada51321db787262ef343193c712b76b5]

CVE-2026-98603: ovpn: replace bind when clearing stale local source

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98603

Introduced by commit 08857b5 ("ovpn: implement basic TX path (UDP)")
in v6.16-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d8104988f423572df1f3347ce578037b1043f34]
stable/6.18: [c44a04722f7dae9a45a101b8e100931ab59f1c18]
stable/7.2: [72bd1bea37ea2c8553938f086bf48ccd2147dfe1]

CVE-2026-98604: ovpn: replace bind when learning local endpoint

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98604

Introduced by commit f0281c1 ("ovpn: add support for updating local or
remote UDP endpoint") in v6.16-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aea934a221ec6a867221e5b765f65f1857befd53]
stable/6.18: [21dbc9f4d0bdd3b22f91beabc7840064bf11594f]
stable/7.2: [e283009151d3d131447c2edda500199c5fda5f72]

CVE-2026-98605: drm/bridge: samsung-dsim: fix TE GPIO lifetime for host attach

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98605

Introduced by commit e744712 ("drm: bridge: Generalize Exynos-DSI
driver into a Samsung DSIM bridge") in v6.4-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ada667890773e033d2f40dc94176e3beb930b516]
stable/6.12: [5759bbef951c39d264ac0f47daa4137d01403aea]
stable/6.18: [ebffd70e4877bb7554974cf975a27872f2bb225f]
stable/6.6: [77a43e00c57486a5212ef22d4665cafad62a5d4b]
stable/7.2: [9b796251c3cca45a33a5c859c6818c58aa982277]

CVE-2026-98606: drm/virtio: release the GEM object on
virtio_gpu_vram_create() errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98606

Introduced by commit 16845c5 ("drm/virtio: implement blob resources:
implement vram object") in v5.11-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [036d28db1818af2f9d80db771f5405da84d7732d]
stable/5.15: [977c2934064969503cabf98b1135d202ff62822e]
stable/6.1: [5118b5fdf1eb9922a0cdd2afd25252081e2d4302]
stable/6.12: [03bdbf182082694ab2add620d85f1a8b8f51bbbc]
stable/6.18: [5c2cb3dd1447752b73d4f44d6b7434bc5259bfec]
stable/6.6: [a9bb8f8fd5694185c2f71ff91869afb300aab392]
stable/7.2: [7c8deb77d05bcc8f79e255f669d82ec6ce91be12]

CVE-2026-98607: drm/virtio: fix object leaks in
virtio_gpu_resource_create_blob_ioctl()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98607

Introduced by commit 897b4d1 ("drm/virtio: implement blob resources:
resource create blob ioctl") in v5.11-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24b6d5c7641412c9ebef0d4c8b888d49a0e6b880]
stable/5.15: [73ea38a89b923fa08047885a0845d1cd89261ead]
stable/6.1: [eea473532a286cd1b13cddbec5c645989f43a3aa]
stable/6.12: [0455867bbd95ffa9d9db0a1c6dda500f8126232c]
stable/6.18: [81c6769e069d703154087377d1749af2f1b74e49]
stable/6.6: [88c60c06a2a5244f5dd32ec098e633add114890f]
stable/7.2: [02df4e24dc4c0bf5b0425a6acabc5201d7f04fc2]

CVE-2026-98608: drm/virtio: fix object leak in
virtio_gpu_resource_create_ioctl()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98608

Introduced by commit 62fb7a5 ("virtio-gpu: add 3d/virgl support") in v4.4-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [477bc3068fc3777b9d8ffd79e265b0dfdf2d3a6b]
stable/5.10: [d33d5ef8225538f76e4598c09e2074834667bb8d]
stable/5.15: [1586ee6107acab3b14510ac6af939f1253269df8]
stable/6.1: [83c899104496677068fbbd2e42f28fd625f9cd85]
stable/6.12: [574ae9fa5fd3658bee23cb544fe5a0d1d750016a]
stable/6.18: [b516446a25bf365cfffe3d7884ea6637f7f70862]
stable/6.6: [77dee8e9106d62bf4f51b646c801f51f8ee77339]
stable/7.2: [749d8bb964b3414ef967d5ec80f2f1b5b3a510d9]

CVE-2026-98609: drm/virtio: fix object leak when drm_gem_handle_create() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98609

Introduced by commit dc5698e ("Add virtio gpu driver.") in v4.2-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36570ef2244cc4d7563b1f0157bc0f032498638c]
stable/5.10: [13423a058187c2039aa8cb235c916be4477221b7]
stable/5.15: [687be2f8b5e0e0ca9a7028f8f6413d0ed3fbb9dc]
stable/6.1: [264ae8ac8fd625b6c118baf16c111adeee2ec632]
stable/6.12: [372e9c3d45f664a2c000427ccbf6cdc2f99b3170]
stable/6.18: [a93dce15dfef200c346b050a2acbed516cc62706]
stable/6.6: [e2edd2d78d2cf8446de017adec9598feefed3297]
stable/7.2: [f75066c79d1eec453c0d386ef8636873d1e11f2c]

CVE-2026-98610: net/sched: sch_hfsc: bound the classify inner-filter
walk with a drift budget

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98610

Introduced by commit a2f7922 ("net_sched: sch_hfsc: fix classification
loops") in v2.6.35-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a60ade2277e1f0e0d0578d565354e52292fa46d]
stable/5.10: [d4fd251e3311727c32af89344d3332f788c153a2]
stable/5.15: [30d7fea767e830bd81ac2f73d2e33c877cb2e679]
stable/6.1: [f476fb656ca2326d7b2eba98d03ced1cbcf5cd99]
stable/6.12: [2bd20245dd658789d8cccb37697967b4caba6ad8]
stable/6.18: [0fa25ba50a382d79c0cf060214c2095756836f5f]
stable/6.6: [e8f9979286f70dfbfe0552e2a63000950841bea6]
stable/7.2: [1301a1292c6742b4c96a18715d49f89c3caca0d7]

CVE-2026-98611: bpf: Check params size before reading reserved fields

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98611

Introduced by commit 3e1c6f3 ("bpf: make common crypto API for TC/XDP
programs") in v6.10-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a11212910cf09b2fe8db9afa41ef60c4f81879c5]
stable/6.12: [e03253f5d65ebcd2a6d479f140c3bd9c7e4fb84a]
stable/6.18: [cd12d3e08620257fbcaa262785d7f4b9473afc7a]
stable/7.2: [86a0e945fb645ea90233fde239cd2de79f01974c]

CVE-2026-98612: net: usb: catc: bound the RX packet length in catc_rx_done()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98612

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d565b6b72fe3f41fd43636e143072848105189f]
stable/5.10: [3942557938f846e7481f6ccb2b41ccbdee61baa1]
stable/5.15: [2f87bbd5a7bf6ee79d598f7e22cf77810d29ae87]
stable/6.1: [4cc0a8eb2f9336cfa3e4ac329bc5585ca970ced3]
stable/6.12: [801e21cf7dd6bcee31db907625d5045f21c9c1d9]
stable/6.18: [dd9c6f8f05170223edec2dac476606cd40d9acb7]
stable/6.6: [21e206dd88b3de6e36bb607dec3797c59bc3007b]
stable/7.2: [9d4be026bdff2c1da7b6c7e01c0a47f2df409e97]

CVE-2026-98613: bpf: Bound ownership depth through local kptrs and graph roots

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98613

Introduced by commit b0966c7 ("bpf: Support bpf_kptr_xchg into local
kptr") in v6.12-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bfc888f04588f591851e95c974954cfca58e6c19]
stable/6.12: [92aa0502c781d72bb9685245c3280efb3766a110]
stable/6.18: [9c11e543fec32e92b3aa3f693339ca3ee79ea9dd]
stable/7.2: [4105870a4b8afe852aeb24a6dd58e1836cc4ce58]

CVE-2026-98614: sctp: avoid livelock while updating retransmit path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98614

Introduced by commit 4c47af4 ("net: sctp: rework multihoming
retransmission path selection to rfc4960") in v3.14-rc6.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2c31b837406395e576afeb25958c98e9938f3f6]
stable/5.10: [3fe624c3843694ab096fdb198526ba0c659febbe]
stable/5.15: [43410c1f2db53516e95ddd7e5b4b02f495b78121]
stable/6.1: [d893a7cc1cb41dd510f338bb2bfd8f29b14eaf49]
stable/6.12: [173610fff55022a5ad1579fbcc7faa97467b58b7]
stable/6.18: [c9338057df1025f578fe7d0ff08bada87b8b838d]
stable/6.6: [83b1a7f9e718828ef364a7b004254ebb2d0035fe]
stable/7.2: [ddc34cc0834c873871e88b055ee6a260676efe97]

CVE-2026-98615: eth: fbnic: Set AW_FLUSH_MODE alongside AW_FLUSH when
flushing the mailbox

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98615

Introduced by commit 3b12f00 ("fbnic: Gate AXI read/write enabling on
FW mailbox") in v6.15-rc6.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [8947f13e436a4ff5eed9f8f019b2865a07af4bb2]
stable/6.12: [ed4163f6ba9b52bfd6216d5215ee7b8eb5072411]
stable/6.18: [8a052cd4b2caee1f90cf0e3874377066939c90e7]
stable/7.2: [a969db6548a1b046cd1423701f5f9c3f5794e90d]

CVE-2026-98616: eth: fbnic: reset num_napi when the napi vectors are freed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98616

Introduced by commit bc61077 ("eth: fbnic: Allocate a netdevice and
napi vectors with queues") in v6.11-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4bcc4a92c603fe7f062cea22e20da2e0ad6b12c3]
stable/6.18: [c5b5aee41b9f5ed0743344be1c7b544555fa3cb9]
stable/7.2: [4f4b767ffea7653a00904383908536e754f8ef5b]

CVE-2026-98617: eth: fbnic: use the Rx queue napi pointer to find the
napi vector

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98617

Introduced by commit da43127 ("eth: fbnic: support queue ops /
zero-copy Rx") in v6.18-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5d9e9d4d0c13bc8b60d8d97e7a07fb25fea639e]
stable/7.2: [1fb569cf3bf97e552f465b2c719e36b48ae7c18b]

CVE-2026-98618: eth: fbnic: Handle maximum standalone channels

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98618

Introduced by commit bc61077 ("eth: fbnic: Allocate a netdevice and
napi vectors with queues") in v6.11-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f4c73064a50f53d596c6f1d06d2d700f43c4b32]
stable/6.12: [9843e5fabd6ab296df9c025b1d0e5bf79a6b8a08]
stable/6.18: [6c903188b67617070017305a325fa326f270a43d]
stable/7.2: [16ff1023213cc39c1a7ce737205c2a1a53c3a716]

CVE-2026-98619: net: ethtool: keep rtnl_lock for the ioctl self test

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98619

Introduced by commit f994752 ("net: ethtool: optionally skip rtnl_lock
on IOCTL path") in v7.2-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b82958f3f035df5ccaab5430a2302f08a5d5351]
stable/7.2: [4ca1503491f1f25a954c13ac5775bf6775c5abc8]

CVE-2026-98620: net: ethernet: mtk_eth_soc: unregister net_devices in
case of probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98620

Introduced by commit 8a8a9e8 ("net: ethernet: mediatek: cleanup error
path inside mtk_hw_init") in v4.9-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [310d1ac61a4d5a2ca8356a3a48d263acf54503ce]
stable/6.12: [ab3bde3b3e56331b4f53a1f6cf4e5e9d1c14c1a0]
stable/6.18: [7254b702e556158e34b4d7c168b5d8e7da5978af]
stable/6.6: [245bea0c7ab278150c70366bdeb69b901327133c]
stable/7.2: [0fdb944d4df02223c67d5e65c4c134ecb57a5668]

CVE-2026-98621: net: gue: reject invalid REMCSUM offsets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98621

Introduced by commit fe881ef ("gue: Use checksum partial with remote
checksum offload") in v4.0-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2566866fc30965d915d0b52b5c3323b362619f0e]
stable/5.10: [4b9bc21b2396c396d88dd909caaf73d5be6ff593]
stable/5.15: [43efb1f997e976f386aa89716f55870cd2cff9ad]
stable/6.1: [1eeec0c51fd5598da44080ed96bbd9880021c28b]
stable/6.12: [97f907203321eee2cc9132d5c9eb47698fb41d35]
stable/6.18: [40aeafbcbc7bc4018e8f74bbbb4d29ed8846f57f]
stable/6.6: [1d664be4ca49d1696e85239236f4988dfc4653c3]
stable/7.2: [c20f755338ca234e523dfc943719f194dfc1f903]

CVE-2026-98622: net/sched: act_ct: don't WARN on benign
flow_offload_alloc() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98622

Introduced by commit 64ff70b ("net/sched: act_ct: Offload established
connections to flow table") in v5.7-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47abe7a5c4eb53269aca3506446f851572a059a3]
stable/5.10: [e8fcf3f08834e939b797311742ee72b1e2a08096]
stable/5.15: [af475f599270e59313552e6c6f3af8507da672b8]
stable/6.1: [424ba52c0058deeb940d02cba52eb0aeb288db33]
stable/6.12: [d805560ad69cb266d669341ca01e26bffb0d2c67]
stable/6.18: [00734f3684fcec42c319bedfe68a5d357c720b53]
stable/6.6: [d512c484bd93a5f2794aa03c9faeb7bcb82dbd4a]
stable/7.2: [650787233c2fd6e515a7c5f371019a9fa080ccd2]

CVE-2026-98623: drm/nouveau/clk: fix list cursor use after loop in
nvkm_clk_ustate_update

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98623

Introduced by commit 7c85652 ("drm/nouveau/clk: implement power state
and engine clock control in core") in v3.13-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aff09d9e37e02dc60bde79035ac15b136d602259]
stable/5.10: [db5dd9f47b4df1be322f498d846e9a82940a7390]
stable/5.15: [9d550924961f61a491dd95359c63494fa8a23d9f]
stable/6.1: [492e9cfa12f35f7946ea1b78a19f1f9337d62248]
stable/6.12: [5315c7bacfe274ddfe649d9556e9a341ffa812da]
stable/6.18: [0d096a7f7d79207490858dde731b16da5337e90c]
stable/6.6: [a867abcfa85ab487066c3d3008a1ba905da04113]
stable/7.2: [391517da7fd54ae40e4a7fe1cc696217343b0061]

CVE-2026-98624: netfilter: nfnetlink_queue: hold nfnl mutex in event notifier

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98624

Introduced by commit 7af4cc3 ("[NETFILTER]: Add "nfnetlink_queue"
netfilter queue handler over nfnetlink") in v2.6.20.16.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9461613afc59acef44a0071b0dd5075f6e993ffe]
stable/5.10: [46432f2e76f7c385d82506304a2928e7d293289f]
stable/5.15: [597320337c3da06c92a9e95cfc755da66fedc476]
stable/6.1: [2e9be1302f25c9be51c2fb8c907bc6d8a1050e33]
stable/6.12: [1d1184411599a7c2217560bab3bbe641c6d03b95]
stable/6.18: [07a3ec8fdc5a1267c00cd6fd1cf8bbb5cda913c1]
stable/6.6: [d559e06a5ab7c064100aafd5c826eadd0f1c6216]
stable/7.2: [8137a39e08e838ced234044384740ceeb99ed388]

CVE-2026-98625: netfilter: flowtable: publish HW_DEAD after worker is done

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98625

Introduced by commit 2c88979 ("netfilter: flowtable: Add pending bit
for offload work") in v5.7-rc6.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d644b23afe1ef509c9961a6d84a093c2587edf02]
stable/5.10: [f92e8f39726ba68a7c42c6b7566be687c8161579]
stable/5.15: [00e452a7ca9fda135ea3d04a11128d5088e354a8]
stable/6.1: [56f39c7d139bb76072efe2fb3dcafc13ba915ad8]
stable/6.12: [b4f0f05dfbe836a171bff261f17d098a4d5461ea]
stable/6.18: [b0ef9450e93f2adeb77593db14c2ac7c6c8f5060]
stable/6.6: [e20701843032c438f879066a77ea85e361c6b999]
stable/7.2: [f26652e99f519e6bd34f8a9b48fbb33c603585f2]

CVE-2026-98626: bpf: Restrict CO-RE poisoning to relocatable instructions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98626

Introduced by commit d7a2527 ("libbpf: Improve handling of failed
CO-RE relocations") in v5.6-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [394ae398337c5f87e567f6cd63b937fc2b2f6ddc]
stable/5.15: [a8c47e62d9aea2d47a09e06c1682c59c21b92449]
stable/6.1: [d3219c229d16900cef936adad28633c98946e432]
stable/6.12: [f2a24101e89dd0804e717da7c1bd6af513698aa2]
stable/6.18: [2d7d04357c41aa49a5ac658fcc207439f2ad6456]
stable/6.6: [a0b79cdfcf34b53c85bac2d3cf022fc1342eeca0]
stable/7.2: [8e4cbcca1e0a2fc5e6c8edb68e0cf5f2587f9319]

CVE-2026-98627: bpf: Preserve packet pointer class displacement in regsafe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98627

Introduced by commit 022ac07 ("bpf: use reg->var_off instead of
reg->off for pointers") in v7.1-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd16449a9b3b31a8f18944c2f0e29e4e218ca2cf]
stable/7.2: [091b40845bd3cf96791171ca95113e9184ccb596]

CVE-2026-98628: bpf: Make post-verification instruction rewrites killable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98628

Introduced by commit 52875a0 ("bpf: verifier: remove dead code") in v5.1-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [261b61d3735b042ae25634f795c4540be0fc140c]
stable/7.2: [56dc616d7a1f7d134d3e101c455e62b0a24d0cfd]

CVE-2026-98629: net/sched: cls_u32: fix manual hash table handle IDR aliasing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98629

Introduced by commit 73af53d ("net: sched: cls_u32: Fix u32's
systematic failure to free IDR entries for hnodes.") in v6.12.
Fixed in v7.3-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [0a5f5d9e94dead312d32c366b917c64e552b72f7]
stable/6.1: [21fc07924e996e1e661268ca269c86b8d59d25b3]
stable/6.12: [54a454c5e41f5e2cb70c8163140ce095c5d5eefd]
stable/6.18: [f6696481eedfd5752b4b56eed715d0b0fe48b9c5]
stable/6.6: [0fac292d93fdb313099e98cce928b3a524c92c94]
stable/7.2: [2f898f9ec7c73c5697ee462681e7ea6984ee1f3d]

CVE-2026-98630: eth: fbnic: Fix payload page pool error cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98630

Introduced by commit 8a11010 ("eth: fbnic: allocate unreadable page
pool for the payloads") in v6.18-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e0b235bd918d06f54ba8fddd2c3ddc36ca59c15]
stable/6.18: [f4277b19edbc6abc9e1db7d6f6148608e8cb3c34]
stable/7.2: [4bab07f7b74e59bb26032fa5ff6969d63e1c52ef]

CVE-2026-98631: xsk: Use a 32-bit compare in xsk_map_gen_lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98631

Introduced by commit e65650f ("bpf: Implement map_gen_lookup()
callback for XSKMAP") in v5.5-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70504de0bb627848667207bec7ccfd647deb8814]
stable/5.10: [c6d5c582d55a8f229d75e98d62eaa065b0deb18d]
stable/5.15: [227ec890559e922e235eb543646e3bf0bd8269b0]
stable/6.1: [11d9be35c1f4233798e99be98bc474f83a254c6c]
stable/6.12: [36461e58f88a1b723f86693f437ac12e60ff4363]
stable/6.18: [b5c0cff0c5331582ab01c4c423731453a8381acc]
stable/6.6: [123f90f394ca404ab8796a7c8072ff7fa5b65a9c]
stable/7.2: [3c1e0a4bc156b8d5c5772dbc76b9ea74dce5ca24]

CVE-2026-98632: Bluetooth: mgmt: Dequeue pending mesh_send_sync
entries on cancel

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98632

Introduced by commit b338d91 ("Bluetooth: Implement support for Mesh")
in v6.1-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [71af682ba4692c2ed9ace4c3d4ca462ae368c029]
stable/6.1: [f84e52829021d00bca8e067302f597c71af1f71a]
stable/6.12: [084be90948632a5a358821e687b11a14445aae76]
stable/6.18: [2189a219397d8e73808a67c4aade837b635705da]
stable/6.6: [718a8ffa180d469f99ad4f746f00cafd39456415]
stable/7.2: [03ced4687fb79286be7fdee0fc58d2c74de3e7bb]

CVE-2026-98633: Bluetooth: btnxpuart: Fix skb leak in nxp_process_fw_dump()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98633

Introduced by commit 998e447 ("Bluetooth: btnxpuart: Add support for
HCI coredump feature") in v6.15-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2bbb36426581045a8bf7793da5419b9375e4348]
stable/6.18: [8a36598050cd1e5abb1d5ed42cc224cfcb538c4f]
stable/7.2: [edcb84ee607a9ddfc6f2771a7f399115f0b0f19d]

CVE-2026-98634: scsi: sd_zbc: Reject disks with too many zones

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98634

Introduced by commit 89d9475 ("sd: Implement support for ZBC devices")
in v4.10-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6ec0f79745967c751c85df373062c8d15e45fc4]
stable/6.12: [d8791ae55d85dfaeafa20ea48365482a0cc5a107]
stable/6.18: [0af16d8be3ec7ff28bb56a0da79c9aed66ac2c3b]
stable/7.2: [3ddf8383b54456f19fd73d3cebed81bd250c7388]

CVE-2026-98635: scsi: block: Fix zones_cond out-of-bounds write on zone report

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98635

Introduced by commit 6e945ff ("block: use zone condition to determine
conventional zones") in v6.19-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c431d61b69a3fd0784c20aa4cd0b8fb501b5653]
stable/7.2: [ca688bb207957cffa5a8cad207329b0dcac1f2c0]

CVE-2026-98636: squashfs: Add dictionary size range check to prevent
shift-out-of-bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98636

Introduced by commit ff75031 ("Squashfs: add compression options
support to xz decompressor") in v2.6.39-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f7745fb3580152ca902ef181b605f33cabfb1d0]
stable/5.10: [b02948a23455f8190a53887b2d2c13ae1d360cea]
stable/5.15: [9d9c5c218ea356a1d88765214ad2919605280ab1]
stable/6.1: [7a1c293e7aa17f1afaee0684e0e931fe23a5a6b1]
stable/6.12: [88c673a0bd233df44ca0020da82f4fd3876de27a]
stable/6.18: [0cb85377daaefb4ce5ce72975f2deb27ee0e0cad]
stable/6.6: [c68e0068a236f9a7dfc19720bdf11e5d80a85089]
stable/7.2: [e1ca4e3a380ef3e8f46ce006f1146392e3f32c98]

CVE-2026-98637: KVM: arm64: Do not clear VM-wide SVE feature on vCPU
init failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98637

Introduced by commit 5db1bef ("KVM: arm64: Track SVE state in the
hypervisor vcpu structure") in v6.16-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1b3c788ad31837e348075e93dbba3f447492776]
stable/6.18: [bd46b41f412fb81c50bac1a0929ec31320f3a807]
stable/7.2: [f0cd8ffae092cc1b9d7cfa9188ed5a88a374adcb]

CVE-2026-98638: KVM: arm64: Validate the SVE vector length in
pkvm_vcpu_init_sve()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98638

Introduced by commit 5db1bef ("KVM: arm64: Track SVE state in the
hypervisor vcpu structure") in v6.16-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a2eb10795a1e495aebc7f829ccecb72c05b4fd9]
stable/6.18: [faf66e55e87498ab4bf88cdf9a629e61b3f2d3bc]
stable/7.2: [bae3e4493046de4fefa15f809d9b8dc114e84a3d]

CVE-2026-98639: KVM: riscv: Fix NACL hfence entry update order

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98639

Introduced by commit d466c19 ("RISC-V: KVM: Add common nested
acceleration support") in v6.13-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3d346838ec65fac7fd83f5dbcedd13cadfffddb]
stable/6.18: [d6de766d8d26d71b714f548192099112def50a9c]
stable/7.2: [6da466502621381fa88a6684290923d25c559266]

CVE-2026-98640: HID: amd_sfh: Validate PCI BAR size before mapping

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98640

Introduced by commit 4f567b9 ("SFH: PCIe driver to add support of AMD
sensor fusion hub") in v5.11-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [65bcc5f89704efe5b9d69d4ea2c1002d90c31382]
stable/5.15: [92bf2883da0306ab9d1eb794acd1058fc5088ebc]
stable/6.1: [7b3747d77767f066ccf4a9e8e3a8381643ab5368]
stable/6.12: [dc687489131559ee52f447592f6d039a5a013061]
stable/6.18: [5f9e2ecb725adced013fbf5f94b9f185fad2e7d9]
stable/6.6: [5ff24aa7af0bca0780fe4e6effce902065f2c0a7]
stable/7.2: [ee25833f037fa22d23ffdbfeebabe3579e8a0346]

CVE-2026-98641: bpf, arm64: set up the frame pointer for the exception callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98641

Introduced by commit 5d4fa9e ("bpf, arm64: Avoid blindly
saving/restoring all callee-saved registers") in v6.12-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef1fb82f12186dd26153b14d9fbcf4ec98db81b3]
stable/6.12: [ecdd770a9fc3eaf6c3127c5991312b84774a7b0f]
stable/6.18: [b67b4c763f211e7a6391c356fef552e2ea63f08a]
stable/7.2: [d7cd5ebe13989f265015910faa25e5d50faa4c22]

CVE-2026-98642: bpf: Fix UAF due to concurrent consumption of ttrace
lists in alloc_bulk

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98642

Introduced by commit 04fabf0 ("bpf: Allow reuse from
waiting_for_gp_ttrace list.") in v6.6-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c21452d02eec2f008e2c5535820f85adbd7587a]
stable/6.12: [a0e150a118025a05c8662c536ba2a865da86419c]
stable/6.18: [1d6581b544a88cf4348c2fb60dcb50ad63f012da]
stable/7.2: [f101602415fb39a58941bec444df65634d5a6844]

CVE-2026-98643: bpf: Fix out-of-bounds read of rtt_min in sock_ops

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98643

Introduced by commit 44f0e43 ("bpf: Add support for reading sk_state
and more") in v4.16-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75f8cf22463d82bb1fb0239a3d485fc8f4c8ef03]
stable/5.10: [0c796efa919f52f788c22c79d1f1b70321696b3d]
stable/5.15: [fc9d0e6e9d86fbefe7b8fe6ee49f4cf102add79d]
stable/6.1: [fd6bf2721933d8c90bc4ce57f3e204c9295e7e3f]
stable/6.12: [3a46f14e6cf375f3ca38f8f6e6524749e24ea0a8]
stable/6.18: [6785313d4fac96afb21ef193610c1fa88b1a9e64]
stable/6.6: [a8a9becbac93a9f54f4d565f1f3005eb08a7912f]
stable/7.2: [cba54d142c43ec96d8c4d566f66439e8c0afded7]

CVE-2026-98644: bpf: Avoid soft lockup in __htab_map_lookup_and_delete_batch()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98644

Introduced by commit 0579963 ("bpf: Add batch ops to all htab bpf
map") in v5.6-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85136bf22404474a815fc0ed26ec0d1cbc1bc3f9]
stable/5.15: [5c8b1869cb99a32a962388848cd19604fb41263e]
stable/6.1: [ca5bd55fc508fbb5c08c62206d02237a5b6fc7e8]
stable/6.12: [f0c09de08ec077098b7e1563f2285f1c136cd816]
stable/6.18: [44f9bcb5ab2b268bc763ed3ebec83308b4972936]
stable/6.6: [77a3b52b4455e6377e549539e757bc55eedefb51]
stable/7.2: [4e48fe9b1c77966bede0a73feb3059d7595f642d]

CVE-2026-98645: HID: winwing: fix use-after-free in force feedback teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98645

Introduced by commit 42d020b ("HID: winwing: Enable rumble effects")
in v7.1-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1a5ad37e50ceb192c07ac7e2d7143638cd4d110]
stable/7.2: [2b25f11ec52ea0a82334d5b83ee321f6b0a35923]

CVE-2026-98646: tcp: Skip cond_resched() in inet_csk_listen_stop()
under BPF context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98646

Introduced by commit 4ddbcb8 ("bpf: Add bpf_sock_destroy kfunc") in v6.5-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eaab8cab451b9502ce224cd202550375b894a467]
stable/6.12: [5b52417c6196e05618a3b5d9753dbed9adef0166]
stable/6.18: [55bbebf2829c3f47c5a48fc261740301d0f25f48]
stable/6.6: [23da88d1597ee7fdda373e1530284b763710911f]
stable/7.2: [ee7246bccb9da66076dd8094daa48bdc761d6b76]

CVE-2026-98647: bpf: Fix divide-by-zero in btf_struct_walk()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98647

Introduced by commit 9c5f8a1 ("bpf: Support variable length array in
tracing programs") in v5.8-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0b3dc66529676228cb938cbcad66920f735c223]
stable/5.15: [1ea3820937f8022e044c41c6e95c84b02741b45f]
stable/6.1: [172756f02663ad45c889c001c1a8cb4082a01a05]
stable/6.12: [63af086cb5fa6f72fd924f86bea4c2194da663a2]
stable/6.18: [8eb4cd72daad3a9ee63d2281bbdd16ce6d9406b1]
stable/6.6: [934e9ba9f8d05656a48624710be67ca4dc8482e6]
stable/7.2: [b8fa56722e9c43bcd59c51fe4c7edd5f4158a11b]

CVE-2026-98648: s390/uv: Prevent potential out-of-bounds read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98648

Introduced by commit 7c9137a ("s390/uv: Retrieve UV secrets support")
in v6.13-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f47190b08b71e8482072978373ee88cb2dfbdaf4]
stable/6.18: [04bb5b2eb9f1d56110f14d3a4e31fa2c65fb026f]
stable/7.2: [116bba758533a139bbede8d717a1371bd6d890f6]

CVE-2026-98649: KVM: s390: Fix race in _destroy_pages_crste()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98649

Introduced by commit a2c17f9 ("KVM: s390: New gmap code") in v7.0-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ca00a9154f998116fba9a32cce5bd938d228065]
stable/7.2: [90bd832b2bc367991d424d847003ce345b454ffc]

CVE-2026-98650: KVM: s390: Fix potential races in dat skey functions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98650

Introduced by commit 8e03e83 ("KVM: s390: KVM page table management
functions: storage keys") in v7.0-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27554b9505ddfc0aeab466aeb60929dfa17284c7]
stable/7.2: [c958f0498891203fddf2764b28f8b102c6bfd719]

CVE-2026-98651: KVM: s390: Properly handle NULL pointer in
dat_cond_set_storage_key()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98651

Introduced by commit 8e03e83 ("KVM: s390: KVM page table management
functions: storage keys") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88e22ffd1e46b95e40a6afabe486deb1d31a3ae1]
stable/7.2: [75867536746ab2d034488a6a93ee6cde83553342]

CVE-2026-98652: KVM: s390: Add missing srcu in kvm_s390_set_irq_state()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98652

Introduced by commit ba5c1e9 ("KVM: s390: interrupt subsystem, cpu
timer, waitpsw") in v2.6.26-rc1.
Introduced by commit 062e44a ("KVM: s390: Use srcu in
kvm_arch_vcpu_unlocked_ioctl()") in v7.3-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3a557067d57ce6ae98d485c8009b223e16f5f36]
stable/7.2: [7a33007b95c8908ae3980eb2b4c508f8936766df]

CVE-2026-98653: KVM: s390: Fix _gaccess_shadow_fault()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98653

Introduced by commit e38c884 ("KVM: s390: Switch to new gmap") in v7.0-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [faff4c8ff3dbec6d71b89dd281a0d17c4478fa44]
stable/7.2: [94c43c7df46433ed4d1e18f13770b019ba977bd8]

CVE-2026-98654: [REJECTED]: drm/amd/display: Atomize IRQ register
read/modify/write ops

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98654

This CVE was rejected. Introduced by commit c87e663 ("drm/amd/display:
consolidate DCN vblank/flip handling onto vupdate_no_lock") in
v7.3-rc1.
Fixed in v7.3-rc4.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [63e19ef3ddab806c472748c825f4dc88dcd994e8]
stable/6.18: [2945d3eb73d614c974a653a79e9a7a7e909db5ef]
stable/7.2: [d55c308af33f92c1377fe82ccc4ced09957b4843]

CVE-2026-98655: perf: Require kernel access for text poke events

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98655

Introduced by commit e17d43b ("perf: Add perf text poke event") in v5.9-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [357e8a77a501d96c9517f01f4a211eed5e9c9184]
stable/6.12: [8473f44db9f710ea6f8cafb22f2e3ba6cb8ca9a7]
stable/6.18: [e506333d1b9f42f1e402acebf1283af3c44a3809]
stable/6.6: [8c38cb055f6a9651198780e4e4d5283de4039f79]
stable/7.2: [677d0b51ac1a0db55d768c4c6399210b3de0795b]

CVE-2026-98656: iio: trigger: cancel reenable_work before freeing trigger

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98656

Introduced by commit 9020ef6 ("iio: trigger: Fix a scheduling whilst
atomic issue seen on tsc2046") in v5.17-rc1.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [2a57b9246cecd5dd797a42eb310d6c8816f26d9e]
stable/6.12: [cf513df1a2c75566cdc802d9da47f62e8d6cfd18]
stable/6.18: [e64703280ce7a23a43c27efebeb7da457c88bf5c]
stable/6.6: [ac5d26a46c90ff61fd574eff4e8f0d71c905828a]
stable/7.2: [882d0011c59ff8ac15188ec9ce071399ecfa10ad]

CVE-2026-98657: iio: proximity: pulsedlight: fix iio_device left
registered on PM setup failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98657

Introduced by commit 4ac4e08 ("iio: pulsedlight-lidar-lite: add
runtime PM") in v4.5-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4daa9ca557b4b98ae1ad38a6d1deaa3e31eb8edf]
stable/6.12: [06fa13c53442257b94ea1519555ceddaaea57e0d]
stable/6.18: [20ebd7f4e35c0a737f011bc83aeb0cdd37507648]
stable/6.6: [2c8211eef98929c5188f8c2224e83b9a63b41bd1]
stable/7.2: [e462b47b9637b8c0285f4a38b5af9a322847d164]

CVE-2026-98658: iio: proximity: aw96103: validate firmware data length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98658

Introduced by commit 07b2412 ("iio: proximity: aw96103: Add support
for aw96103/aw96105 proximity sensor") in v6.12-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a7c522a35477d70320bd64aba8e9de0c1058c6f]
stable/6.12: [4a9b9f2d4e26589afd0ac099c8e5593170dd5ac7]
stable/6.18: [6501b032be217ecf47e793b78a05078cf0b604ad]
stable/7.2: [815ae0b73b69ace207b6bbf7ef428b06491c3ddb]

CVE-2026-98659: iio: pressure: rohm-bm1390: Return error when read fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98659

Introduced by commit 5346744 ("iio: bm1390: simplify using
guard(mutex)") in v6.14-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0e951ffc5a28141a106562997ca136ec6a0e1a3]
stable/6.18: [493e743ea1b5930bfa0c6c25b46add6c5d5323db]
stable/7.2: [6280d15f08603230855cf667d1cf67e7e94f693c]

CVE-2026-98660: iio: pressure: bmp280: fix out-of-bounds access in
sampling frequency lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98660

Introduced by commit 10b40ff ("iio: pressure: bmp280: Add more tunable
config parameters for BMP380") in v6.1-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56c423b233b214182c58c99861899327b45b0d6c]
stable/6.12: [9db6684fab228edd3b8861a172ccbce3236f027a]
stable/6.18: [4fd5a61e61d6899cbd45728a5fceba49a53c222d]
stable/6.6: [05ef1af381a0f4556c7e3c0dc6bc2428d16c707e]
stable/7.2: [7dbb518f3328ebd9d5c6e970b4befad6deb5c7f1]

CVE-2026-98661: iio: light: rohm-bu27034: Fix infinite delay on error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98661

Introduced by commit e52afbd ("iio: light: ROHM BU27034 Ambient Light
Sensor") in v6.4-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8065a6c02f629187131f3136bedb26f9080e3cca]
stable/6.12: [050482f958521d80603e88d5c3a59872528ec13c]
stable/6.18: [10a958e76c737c19576e1097c49f210eb99b94bf]
stable/7.2: [6a27402a8ff1f63464557c5274a4115b60ea1f2f]

CVE-2026-98662: iio: light: gp2ap020a00f: drain irq_work after free_irq

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98662

Introduced by commit bf29fbe ("iio: gp2ap020a00f: Add a driver for the
device") in v3.13-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63213927b141085b6c8719b8037dab3074b7e0fe]
stable/6.12: [a36814b9fe00970116d30c3143d81e7425c4d334]
stable/6.18: [cc71400bc965c0d3894a38ead3d71243400c2d5e]
stable/6.6: [85c20d1cf3f01a506605a16c2f9ce23b9c8b114f]
stable/7.2: [a1769877ff52a4f1bfb9ca535d1b5113808bd602]

CVE-2026-98663: iio: imu: adis16480: fix unprotected debugfs reads

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98663

Introduced by commit 9bf94f8 ("imu:adis16480: fix
debugfs_simple_attr.cocci warnings") in v4.16-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e1dea54496f90a62318cf4eeaa1e9ef8316e92b6]
stable/6.12: [b7e507c6da8875da93b4130c8185e82a9dfd565c]
stable/6.18: [ce308ce18dedc18e9eeff8473892975e6fdd7aef]
stable/6.6: [8a782244972715c76bdaf8b662e9b22e260c5296]
stable/7.2: [396b83106f5e7d16467049f0caabd10533c01a0e]

CVE-2026-98664: iio: imu: adis16400: fix unprotected debugfs reads

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98664

Introduced by commit ae1d37a ("iio: imu: adis16400: use
DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE") in
v5.8-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d94787287a113a1326211647d5e0deed1e9de105]
stable/6.12: [e9b4c00f775a915b759b08bfe2c5e806a8301a59]
stable/6.18: [50e8d70ba0743f88afd7e49f9cebd1841ee677f5]
stable/6.6: [d3078aaef8af4648f94eeafde4b7b36efd9838d1]
stable/7.2: [f501302ebb9e1504162351b951fe3ae331c852ab]

CVE-2026-98665: iio: health: max30102: fix NULL dereference in interrupt handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98665

Introduced by commit 90579b6 ("iio: health: max30102: Add MAX30105
support") in v4.16-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0ea4824deebf21dacfbe397c4b0a5fd3e745a8d]
stable/6.12: [eeb23ba97bd8016e815ef70300b8d34a0a316b90]
stable/6.18: [60699102827fdb51f9591414165359c8e867f302]
stable/6.6: [2a74f30a7bb305cdc5c3e3e9239b32bb84f3529f]
stable/7.2: [8d6f98972fe2bd6f73f39d982af0c85d766a1503]

CVE-2026-98666: iio: gyro: adis16136: fix unprotected debugfs reads

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98666

Introduced by commit 9aaea09 ("gyro:adis16136: fix
debugfs_simple_attr.cocci warnings") in v4.16-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b498df75d6c29aa3e760127ae0f0003df598b53]
stable/6.12: [d5b0b62e26d7d30e0e16e2d695f2161f7e92a5a5]
stable/6.18: [b53dc6e15aead039bc6a5e08060c96786240c81d]
stable/6.6: [b62c3944c006cff85dad881ba2948b2f3ef5a626]
stable/7.2: [b05e768420352d9051f86c1a1f20f44fa046ba45]

CVE-2026-98667: iio: frequency: adf4377: Fully initialize
clk_init_data and clk_parent_data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98667

Introduced by commit 60e5448 ("iio: frequency: adf4377: add clk
provider support") in v7.0-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e787fd23d5063c61582c3c27522240b6e6703fde]
stable/7.2: [6564f394a4a95fad534643a6ca0f1d36ff081799]

CVE-2026-98668: iio: buffer: Ensure bounce buffer used for unaligned
case is zeroed.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98668

Introduced by commit 95ec3fd ("iio: core: Introduce
iio_push_to_buffers_with_ts_unaligned()") in v5.16-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5330036bc68d23672bfcc16c60c54701ae123083]
stable/6.12: [b5c2f21f645e40c70fda2a4283e6f2a81e5cb9f2]
stable/6.18: [b134ef820610bd873c9d59999d9824710964ce82]
stable/6.6: [b4f53cec8cc94b37601ce0bb2b272b6753beed98]
stable/7.2: [3a87212b1a09a1fdd730ce5520f7b1fc0b488511]

CVE-2026-98669: iio: buffer: serialize buffer teardown with mode claims

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98669

Introduced by commit 0a85654 ("iio: core: introduce
iio_device_{claim|release}_buffer_mode() APIs") in v6.2-rc1.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [84bb0fc46ccf6a545b8fdf57cda83770186ed8dd]
stable/6.12: [89f3852a28fcf7bab599280cb082baa0675536db]
stable/6.18: [b466db9e68b4741af85f6c017e2bb0a2f025053f]
stable/6.6: [6a728408ff522b749c2a3c7e68f44e861fa0dbfb]
stable/7.2: [e63188d77e10c0951bf67da6c295f768fd1abf4b]

CVE-2026-98670: iio: adc: xilinx-xadc: free IRQ before cancelling the
unmask worker on unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98670

Introduced by commit 2a9685d ("iio: adc: xilinx: use more devres
helpers and remove remove()") in v5.12-rc1.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [0f3f427076240e75ff265e61645627a71ca4918c]
stable/6.12: [a29d385ad7b340c952a3935af2b33488db1eb3a6]
stable/6.18: [a5fe2d1b55faba6d00fd87ad491b6cb603046304]
stable/6.6: [012451d72c12293918617ff98cc737bedad21910]
stable/7.2: [49ea8a359e362bfbb32a647c8eb7962fbb37234e]

CVE-2026-98671: iio: adc: sun4i-gpadc-iio: clean up on thermal zone
registration failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98671

Introduced by commit b0a2428 ("iio: adc: sun4i-gpadc-iio: register in
the thermal after registering in pm") in v4.15-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2cdc7ef31827db4fbc6283750420639569e1f0e9]
stable/6.12: [1bad19e598cd77884d812fd2f88b05c635b5e7ad]
stable/6.18: [d74c2489acc5f0a281e7ad00b94912235729a911]
stable/6.6: [53473b0556296d0eb6a82a8d6769d3f0fc28b940]
stable/7.2: [feae7e0f40d607dda57d476da65beaae76a45142]

CVE-2026-98672: iio: adc: stm32-adc: fix possible division by zero in
processed channel

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98672

Introduced by commit 0e346b2 ("iio: adc: stm32-adc: add vrefint
calibration support") in v5.16-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5de6a6f855fdcf1e0ea549fb227a316db51c405]
stable/6.12: [30d27899cbba5b080954b5d3741bd535806c3101]
stable/6.18: [6dd3bf785d0307d1cf8f4a97c2240b0af14bef50]
stable/6.6: [55f1cebee909c9a0d5c2e494bcfaabed54750eb5]
stable/7.2: [ab4e57adead252dd7f947baed6178f32ede88d38]

CVE-2026-98673: iio: adc: pac1934: check ACPI label duplication

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98673

Introduced by commit 0fb528c ("iio: adc: adding support for PAC193x")
in v6.9-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [64c82e7bd9c82b0c9276297df34a3579e8658f55]
stable/6.12: [b7ac07d0b1a44bf644733298e80fd1f22e2f0cc1]
stable/6.18: [2eb7f097e15dc8935b49402456d01f3ab68f3ddd]
stable/7.2: [7996557c6b7d3b136668060057a790e058161dfe]

CVE-2026-98674: iio: adc: adi-axi-adc: Initialize state mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98674

Introduced by commit 7ecb8ee ("iio: adc: adi-axi-adc: support digital
interface calibration") in v6.10-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [549b71ce050637dd32678371ad76c445a2f8c9aa]
stable/6.18: [b473ee29aa0d39e7a7568b9675b15db2b0ae6057]
stable/7.2: [dec6193cef07e5915da0d6dd17725292d469e4aa]

CVE-2026-98675: iio: adc: ade9000: handle Phase C dip events in IRQ1 handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98675

Introduced by commit 81de7b4 ("iio: adc: add ade9000 support") in v6.18-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fafefa925ed7ec10383d9bf0378abf878b7f13cb]
stable/6.18: [f73b94acc7ec81f9c49feb87f649ba5a80a0905c]
stable/7.2: [d338af069f08658f53231adb445ddb10048730ac]

CVE-2026-98676: iio: adc: ade9000: fix NULL pointer dereference in
clkout registration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98676

Introduced by commit 81de7b4 ("iio: adc: add ade9000 support") in v6.18-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49ee1c6a3ebda6b7de06b2961b0e09c1c3fe536a]
stable/6.18: [d2400175228fbc10b29c49a7b5f70a7e80d144dd]
stable/7.2: [134aa31a8d4e71f6ab1d155ad7b4502508832f72]

CVE-2026-98677: iio: adc: ad_sigma_delta: fix use-after-free on unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98677

Introduced by commit 8bea9af ("iio: adc: ad_sigma_delta: Add sequencer
support") in v5.19-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ee8306121495d2a25aa5d1bfd519f2748786b83]
stable/6.12: [84500ae0d976995a6870cb1dca2d124b6b2d6e5a]
stable/6.18: [f20b94a7dc1ff9ade191ce839c984210fdbdc653]
stable/6.6: [975b09bc680acc60903777b766cdb53b0bf9c9f6]
stable/7.2: [5663c72bf400231e90777982216797191887a6b9]

CVE-2026-98678: iio: adc: ad4030: fix invalid oversampling_ratio validation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98678

Introduced by commit 949abd1 ("iio: adc: ad4030: add averaging
support") in v6.15-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d615210564205993e8f0e7ccb57cc2e66b7d5706]
stable/6.18: [6b0cc4e32599f59c994a60743f53fc72cb2979f4]
stable/7.2: [6ca6dcbaa68c5e6dc4df171a32c5822e1a4c66c1]

CVE-2026-98679: iio: accel: kxcjk-1013: reject duplicate event disable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98679

Introduced by commit b4b491c ("iio: accel: kxcjk-1013: Support
thresholds") in v3.18-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd30c10ff60d2b30386c23bb7c61cc97f2385c97]
stable/6.12: [ad690c0c1b9131725619e352cb7c970488cbf436]
stable/6.18: [3365209e758c845a197211645731f0e393a86012]
stable/6.6: [137c35cff4d4d69f73cbfc0bf7870bf379a7a364]
stable/7.2: [aa94a37b5a3e560c277dac6f9e5d0d75549a6583]

CVE-2026-98680: iio: accel: kionix-kx022a: Prevent memory leak and fix state

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98680

Introduced by commit e7123a4 ("iio: accel: kionix-kx022a: Refactor
driver and add chip_info structure") in v6.7-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e65e128b51a37dd1a9056ac3d1705d805a5c8bb0]
stable/6.12: [e3bc345d08639e62b629e0ec0799f7fb45e21372]
stable/6.18: [5c7ca8fe72064c1c3c7a7418031f692bb2bff260]
stable/7.2: [2ef953f7b54e1460718116b4c0a4c63b106348fc]

CVE-2026-98681: smb: client: split cifsFileInfo bitfields to avoid
shared-byte RMW races

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98681

Introduced by commit 3bc303c ("cifs: convert oplock breaks to use
slow_work facility (try #4)") in v2.6.32-rc1.
Introduced by commit 4e8aea3 ("smb3: enable swap on SMB3 mounts") in v5.7-rc1.
Introduced by commit ffceb76 ("smb: client: do not defer close open
handles to deleted files") in v6.9-rc1.
Introduced by commit 173217b ("smb3: retrying on failed server close")
in v6.9-rc3.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [19465a9aeb664f1d710d0d22c07c31bfb7c85446]
stable/6.12: [3786ee67658a2c80fef2544e7de2cd329e043cf9]
stable/6.18: [4165641d06ef44f3a31b77a28048b6c737e885e7]
stable/6.6: [3b8e7928cf1928555dc05d172dd02fb0e7692ec4]
stable/7.2: [d9d23d115610e0342e768f6cb525d91c7b154027]

CVE-2026-98682: smb: client: drain and invalidate before server-side copy/clone

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98682

Introduced by commit 8101d6e ("cifs: Fix copy offload to flush
destination region") in v6.11-rc6.
Introduced by commit c54fc3a ("cifs: Fix flushing, invalidation and
file size with FICLONE") in v6.7-rc5.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9b1194e8ec99d95db25db45edd2fbf690f043ab]
stable/7.2: [dc71660f11ef2fecc0695a41e49cd496a9d255ab]

CVE-2026-98683: smb: client: flush dirty data before zeroing a range

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98683

Introduced by commit 91d1dfa ("cifs: Fix FALLOC_FL_ZERO_RANGE to
preflush buffered part of target region") in v6.11-rc6.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [8f8d32c1044f70e46e87550e039a15ff20a4b21c]
stable/6.18: [cecf4114069fc19629d284710fd783d56bbca862]
stable/7.2: [e8ba21c7e6ef3d4cb617858760673877b2e4a2bb]

CVE-2026-98684: smb: client: flush and commit data before querying
allocated ranges

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98684

Introduced by commit 966a3cb ("cifs: improve fallocate emulation") in v5.14-rc1.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [aa994489bd835547c191827acc460192e147032d]
stable/6.18: [f82242fe3109a3ef72f429540b5bdde08fbfb0e4]
stable/7.2: [bf84e44ff0ed802778eafd7ecb623635379cb506]

CVE-2026-98685: smb: client: discard post-EOF pagecache when extending
a file via clone range

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98685

Introduced by commit c54fc3a ("cifs: Fix flushing, invalidation and
file size with FICLONE") in v6.7-rc5.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [4721587f96cb8de8164f3fd203093a0875560999]
stable/7.2: [15bb9f1d3e967e328649e92a1451e60a0dc66118]

CVE-2026-98686: smb: client: discard post-EOF pagecache when extending
a file via zero range

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98686

Introduced by commit 72c419d ("cifs: fix smb3_zero_range so it can
expand the file-size when required") in v5.1-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da4fe97fb6c730d9c94a115c7bfa6f98e0d578d0]
stable/6.12: [94949b6b2f2bf0dba2e8786aed0b08cc6bc3a183]
stable/6.18: [b75dadb50a25eed525264bf6fea44fad94e7626f]
stable/6.6: [3df27277f8f95345d4a6c57367824bf1aefdbf66]
stable/7.2: [6a8279c98ad289b27c0bdb11adb3f0c0b7fd456d]

CVE-2026-98687: thunderbolt: Reject oversized XDomain properties responses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98687

Introduced by commit d1ff702 ("thunderbolt: Add support for XDomain
discovery protocol") in v4.15-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [80756e263846ab694984e749e8c626897331438f]
stable/6.12: [a766a86ff48acee76aeb8e2575771040749e509d]
stable/6.18: [2f97f929dad9eb3e1f63b721d2dd49bf9bc68efa]
stable/6.6: [b270c1074860de74da0d6b5250fb06b359b9d509]
stable/7.2: [737a1d2e9642d5f718bd29aa4a98b9eef3832f0a]

CVE-2026-98688: thunderbolt: Fix NULL dereference in tb_remove_work()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98688

Introduced by commit a8937f3 ("thunderbolt: Remove XDomain from the
bus without holding tb->lock") in v7.2-rc1.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [4310c6b8e75d6a47f7548e5948fbe6318aa4440a]
stable/7.2: [2f4cd43faa9d6470b30a9fbcbac6584db8108c1f]

CVE-2026-98689: thunderbolt: Don't access a DP tunnel after its DPRX
read was canceled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98689

Introduced by commit d6d458d ("thunderbolt: Handle DisplayPort tunnel
activation asynchronously") in v6.14-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [419fa32fa5bc2d7fb9d0d15d5630b1c1090808b3]
stable/6.18: [405a969c0b3356639116db89ab367be1d64b77c0]
stable/7.2: [2c2fd6a7fd5e1218db7e17336fc1a0393b6949e6]

CVE-2026-98690: thunderbolt: Fix domain reference leak when DPRX read
is canceled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98690

Introduced by commit d6d458d ("thunderbolt: Handle DisplayPort tunnel
activation asynchronously") in v6.14-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1fd1f67c94d30889377bba774f032ec15e8b9299]
stable/6.18: [2f5893172fc6153f5f1ef34014ddbfcbf1f47f29]
stable/7.2: [7739b02129b2248f9a8054cfda924fa253f66a88]

CVE-2026-98691: thunderbolt: Tear down inactive DP tunnels when the
domain is stopped

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98691

Introduced by commit d6d458d ("thunderbolt: Handle DisplayPort tunnel
activation asynchronously") in v6.14-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b457c6733f73421a3fb03786f13d67c618b5119]
stable/6.18: [34a6e27c954e5bfc29fead17867c7155d54b6481]
stable/7.2: [cbd2abb85ea32cafdcbaba218e13b18d8ed79bfa]

CVE-2026-98692: thunderbolt: Make the DP tunnel activation callback mandatory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98692

Introduced by commit d6d458d ("thunderbolt: Handle DisplayPort tunnel
activation asynchronously") in v6.14-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12f5d8b85a66a0ac08d082517d92ce136f8c0d42]
stable/7.2: [47d60ea801fc333a10c576691eca2e7840b02d3d]

CVE-2026-98693: thunderbolt: Hold a router reference for each allocated HopID

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98693

Introduced by commit d6d458d ("thunderbolt: Handle DisplayPort tunnel
activation asynchronously") in v6.14-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [032c59c7681c661b63123231824170c025afb7e7]
stable/6.18: [c444d2c17dc236680324fd989232199680a6c419]
stable/7.2: [2b5f976119d8f099a03cbf700df3d9c8690fe33d]

CVE-2026-98694: thunderbolt: Fix KASAN reported use-after-free when
request is canceled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98694

Introduced by commit d7f781b ("thunderbolt: Rework control channel to
be more reliable") in v4.13-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a02188ddc24b7872f0c5e0c5873f827318717803]
stable/6.12: [71b3c517e02af2c46ad58d4b3706b7c3cb24936d]
stable/6.18: [f18faa3d3b810d60a3005ae1b1d1866faa67d343]
stable/6.6: [b70b9c41f240c42bf6e728034537c0fe60c16ef4]
stable/7.2: [08287212b622039212c972806f896f078dfd28e2]

CVE-2026-98695: USB: serial: fix ioctl hangup race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98695

Introduced by commit f34d7a5 ("tty: The big operations rework") in v2.6.26-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae0e61d95677efa778379853e495d748e6efbf95]
stable/6.12: [ae0da9a5c1ca95c20cc5feffd511ce6eae75924e]
stable/6.18: [4597ddd6168ae2a4123404e5f0871f1070dc7773]
stable/6.6: [24d6edb6bd7f7a9e6cee2f8fe435781daab8aa0f]
stable/7.2: [7912a95d1345c77d8d63b530b00c118700b78abd]

CVE-2026-98696: USB: serial: fix driver deregistration order

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98696

Introduced by commit 765e0ba ("usb-serial: new API for driver
registration") in v3.4-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [646e5b28b4fdbc1b828a2398d6ced2c1dd308a46]
stable/6.12: [9b085a06a0a411b0bcdf18b61c3ebf1be1c72ffe]
stable/6.18: [a1aa474768f69ea3a70da523f00f74c264cfa10e]
stable/6.6: [e7ad832b1144df19cbbaaa655625c6f984e85b9f]
stable/7.2: [428d479a0d31460fbf5969ab262ccd673f1fac01]

CVE-2026-98697: USB: serial: fix dynamic id driver deregistration race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98697

Introduced by commit 93bacef ("USB serial: add dynamic id support to
usb-serial core") in v2.6.21-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63594e8ffe097bc0b7639936f33799a7653dded2]
stable/6.12: [ebd8fcaaacb66c15ae7e19d14619abe3762e0701]
stable/6.18: [4d6da6867b4ac6468d634a0dd3c35dfc0dc8af81]
stable/6.6: [29172161236154f362e35694864cacbdeb07d060]
stable/7.2: [380f57cd58e26e0f3687451196ec446c473c52d9]

CVE-2026-98698: wifi: mac80211: handle empty FILS association request payload

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98698

Introduced by commit 39404fe ("mac80211: FILS AEAD protection for
station mode association frames") in v4.10-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5bfd4b0b40b79781d900cb2f7da0685070f53c67]
stable/6.12: [2f5b62f6534d336a62fdb9e88b186dd70b4323ef]
stable/6.18: [452f1c9b76f7a122bbc4630b9691bda4809677c4]
stable/6.6: [0b1e4a7eeb6a301ee33bd318982927cbdbae9f36]
stable/7.2: [20f939b0c151d1d28e6b62a76b2454fa6fe877f2]

CVE-2026-98699: wifi: mac80211: fix mesh fast xmit path deletion UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98699

Introduced by commit d5edb9a ("wifi: mac80211: mesh fast xmit
support") in v6.4-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee3aadc43ea69d98f666431e787137ac0badbb85]
stable/6.12: [0117f1aa189495e6f1ff608681678817995aee39]
stable/6.18: [128e800a41270ab197b1cc8043637a2924865608]
stable/6.6: [ebb7cba623d38733d33d79a8c7442f5ea04c0fb0]
stable/7.2: [93da3ec938bfdcfb3899428f04c6d0c56fe32952]

CVE-2026-98700: wifi: mac80211: set info->band for 802.3 encap offload frames

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98700

Introduced by commit 50ff477 ("mac80211: add 802.11 encapsulation
offloading support") in v5.7-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4febc02cd02f021f2b6d0768332be643ef14a12d]
stable/6.12: [93c1b247224a32f546b616a8fe87b9bab20f0a7f]
stable/6.18: [9cedbfde1450028f530e9af950f53491fcaebfeb]
stable/6.6: [6535f7084d95873785a7a93cdca05e8ee83b5601]
stable/7.2: [2d9c5525bbc1a548cdc9c4def3cd7fbfc7c66b5b]

CVE-2026-98701: wifi: mac80211: release mesh path quota on failed additions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98701

Introduced by commit ae76eef ("mac80211: return new mpath from
mesh_path_add()") in v3.10-rc1.
Introduced by commit 60854fd ("mac80211: mesh: convert path table to
rhashtable") in v4.7-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7325a44474f20c1393a1c114c6811abce6ddfaf4]
stable/6.12: [56691ed9ef792f180e008a43294a4dc059fbeca2]
stable/6.18: [a613c891906b558c10a4fa98ca29747b98e857cb]
stable/6.6: [57bfaa8b2853425ab1b83114d823a62fe63f859f]
stable/7.2: [a59eca4557c7462aad1b160011013290a92de97d]

CVE-2026-98702: wifi: mac80211: reject invalid 320 MHz CSA bandwidth

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98702

Introduced by commit 21c3f8f ("wifi: mac80211: refactor STA CSA
parsing flows") in v6.9-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56e236759f0a8dc910c2ae7cd3c161f298ee5794]
stable/6.12: [cf0ddacce173890407ed3fa50c8ea9b3c0cc0e16]
stable/6.18: [1892e71aa2e5ee667d87c6e49e3661f5e290303b]
stable/7.2: [79b3ce0d881cd6e5d4d3496b19f5cc5e7089a56c]

CVE-2026-98703: wifi: mac80211: minstrel_ht: validate fixed rate index

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98703

Introduced by commit 24f7580 ("minstrel_ht: fixed rate mode through
debugfs") in v3.1-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15fb9e3cea55fbc378261ce35a32b0f8828f0000]
stable/6.12: [f8ab6ae1fa360b0191252677f41e781dcb0ffe6e]
stable/6.18: [42aa9feb27b600809414a3c6b0c650bafba542a9]
stable/6.6: [eebc70f132041b35da9ec74d5d395083125289b2]
stable/7.2: [43082d604a9937b94ceb2e484403956d0f363324]

CVE-2026-98704: wifi: mac80211: keep fallback association elements alive

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98704

Introduced by commit 5023b14 ("mac80211: support profile split between
elements") in v5.2-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a10a2f80476d166fd81c361ec0319493671b694e]
stable/6.12: [1d9644753d46c86b4e5c05bd6d9d35339ea27331]
stable/6.18: [d0183cd1f6a2dba9e63be20af2f65093c9c8d121]
stable/6.6: [de77b0f68142147e74fac1c497dbe1f93daeeed9]
stable/7.2: [0878594c5806dd29fa5e16cc026ce19158afdad2]

CVE-2026-98705: wifi: mac80211: account proxy paths against the mesh path limit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98705

Introduced by commit ece1a2e ("mac80211: Remove mesh paths when an
interface is removed") in v3.2-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a5f35d4b112af1415ff06bd501c8cc26cc08aa8b]
stable/6.12: [df072db65fdaa34ad15e1d66fc06a53e3e97f778]
stable/6.18: [3b75831ceee76d32bb8e7ddd241904f92f9b5407]
stable/6.6: [c66ab4b94bb04c162485759196555e08c0965320]
stable/7.2: [5a32409ed34a1868830899a5d2437f0b3bf3532c]

CVE-2026-98706: wifi: mac80211: drain PS delivery work during station teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98706

Introduced by commit d34ba21 ("mac80211: don't delay station
destruction") in v3.14-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67a9e80c3ca20c9044cd6ee72cd6278dd19b5023]
stable/6.12: [843d3a1e6f25027ac85f88f67b95d82c67306dee]
stable/6.18: [772bd89304ecf057cc51ce4ce24a1a96ac9c8de3]
stable/6.6: [cbff71fe689f359ebd6a3eaded035ef75226afce]
stable/7.2: [097460fcdd8ab9ef6f6018b2fdc29ba0ea499298]

CVE-2026-98707: wifi: mac80211: shut down RX BA session timer on teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98707

Introduced by commit a87f736 ("mac80211: use RCU for RX aggregation")
in v2.6.36-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e588e83e5c7a0f6d7a77dbbb58927c8c8cfd598e]
stable/6.12: [7bb2a5bd4f07192fca35644fab7d49a17bfbc861]
stable/6.18: [481f9230284c27052b59c587069f232c5d84779e]
stable/6.6: [d0da6ab1fc53a68025929baf0947519c6c1684dc]
stable/7.2: [09b7d5e4f88504e62ddf4ff31ebeebb3b87578ba]

CVE-2026-98708: wifi: mac80211: keep paired old chanctx alive

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98708

Introduced by commit 5bcae31 ("mac80211: implement multi-vif in-place
reservations") in v3.17-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3412e9a800786d1dec4a58367db1cba275e7ef11]
stable/6.12: [21a688cbeae0e682f03e91f1e7a7eedd60d9d4f2]
stable/6.18: [1c82d0c5d509179ba2a4edfa096f516aebf960b0]
stable/6.6: [47864a9092fd6f6b3f312d1e5b233ecdc68b1bd8]
stable/7.2: [afd1cdd16a25c7185b812a612ab7d5f2cbd1e086]

CVE-2026-98709: wifi: mac80211: count only matching reservations in
reserved switch

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98709

Introduced by commit 5bcae31 ("mac80211: implement multi-vif in-place
reservations") in v3.17-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [437f3727b4fd715266c296435c116288f82666fd]
stable/6.12: [d31f655e44631891788ca67018ec5e1ed1c7de86]
stable/6.18: [03525b632908b049f4d04cc8a71cdff2329589cf]
stable/6.6: [4ae6ed5b6074df5f3da05fd74c40bb24c5c9b41d]
stable/7.2: [5cc54a000960bc88f8c58940164dca0e601ab39c]

CVE-2026-98710: wifi: iwlegacy: 3945: free EEPROM data on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98710

Introduced by commit 073d3f5 ("iwlwifi: changing EEPROM layout
handling") in v2.6.27-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8ebe286394c0bbb4a6dbacb182a34ab6376922d]
stable/6.12: [ab7bee2cd55f665cb29fa0ace2ec14020e0a452e]
stable/6.18: [cd8f8f45d81aac384311701d7ffe26567af2e783]
stable/6.6: [3ebc529726c0c038f49e513a7a6f1893552ee803]
stable/7.2: [89f9d6186dc7429f38132635526e28549c913c0b]

CVE-2026-98711: wifi: cw1200: fix TX padding OOB read leaking heap
data to device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98711

Introduced by commit a910e4a ("cw1200: add driver for the ST-E CW1100
& CW1200 WLAN chipsets") in v3.11-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c1611780823b76219cb1478db53dfd890c4a9a2]
stable/6.12: [71f693a0ecccf36532dd2790f7969da6c71d5d23]
stable/6.18: [b0e97bd40e0c2cb1a3530ef8f6250aacf3224515]
stable/6.6: [b66539a4dab128fafaad736b53ce15c19d14d561]
stable/7.2: [678c8f4ba285649d5418a858d5d4f30c728a54ad]

CVE-2026-98712: KVM: arm64: vgic: Take a refcount on IRQs referenced
by last_lr_irq

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98712

Introduced by commit 6da5e53 ("KVM: arm64: vgic: Pick EOIcount
deactivations from AP-list tail") in v7.0-rc4.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19bc5d79ece613f242b5ec03921a3b465321bfed]
stable/7.2: [8b25393d16a5ca8df907bd7ee1ff2e9d85678b3c]

CVE-2026-98713: KVM: arm64: Apply the fine-grained UNDEFs without FEAT_FGT

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98713

Introduced by commit f5a5a40 ("KVM: arm64: Propagate and handle
Fine-Grained UNDEF bits") in v6.9-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4bdd2b3a708c1feb701cb8b62feb8ad2fd77bb07]
stable/6.12: [2f4a15c52a552c5244ec27f4ca8bda855594f918]
stable/6.18: [1113374a17d7f7d16b02ee0bbd9b1e7a60cbb087]
stable/7.2: [af3300b3a6bace925a496f3520e171c07b999c72]

CVE-2026-98714: KVM: SVM: Update control fields on #VMEXIT if and only
if VMRUN succeeded

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98714

Introduced commit is not determined.Fixed in v7.3-rc6.


Fixed status
mainline: [e27fc915c8f575ab5630e27d97465c2077d4b9d1]
stable/7.2: [8676b29d186fcb5c1251d8152fc91d19421e5600]

CVE-2026-98715: KVM: SVM: Preserve TLB control (i.e. pending TLB
flush) on failed VMRUN

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98715

Introduced by commit 38e5e92 ("KVM: SVM: Implement Flush-By-Asid
feature") in v2.6.38-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60d93c27859fb3ec5b5a689e24de303f166477d0]
stable/7.2: [fd873c3d1b5240e80365f09e758e8c96b88a7cdb]

CVE-2026-98716: KVM: SVM: Use the active VMCB's MSR bitmap when
checking if MSR is intercepted

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98716

Introduced by commit b2ac58f ("KVM/SVM: Allow direct access to
MSR_IA32_SPEC_CTRL") in v4.16-rc1.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [9e06bbb9ade7cdf28d4a3b5b14e5812881c8df85]
stable/6.12: [74836ae4785b9754bb36d0b18fcc1dec4e5e98d2]
stable/6.18: [318ef696fa3c712e46bb62a1a828c3cd62f390c3]
stable/6.6: [84da7a0e92207444d9cbfe69965e17db29008f27]
stable/7.2: [55865b3ae03705aa39198783b9cb1f8b96eb44e4]

CVE-2026-98717: KVM: x86/mmu: Bail from shadow walks if the root is
invalid or a dummy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98717

Introduced by commit 0e3223d ("KVM: x86/mmu: Use dummy root, backed by
zero page, for !visible guest roots") in v6.6-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6249c1d5665098c8bf12f8d3e4712bf04c775bc]
stable/6.12: [e1bcabc07efd029ab414894127411129ffdb8b48]
stable/6.18: [97c1dcce17ef27853860c781f9912257e6adbf7c]
stable/6.6: [951fce1510645ba5df38da6fb85ece5726ec347d]
stable/7.2: [681e31f03ec9219099a66a0f6e1bc48e1b5aa914]

CVE-2026-98718: KVM: SEV: Do cache maintenance on the source VM
*before* clearing SEV state

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98718

Introduced by commit 93de2a6 ("KVM: SEV: Do cache maintenance on the
source VM during intra-host migration") in v7.3-rc5.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
stable/6.18 stable/7.2

Fixed status
mainline: [973ea70393e885e540f714904e51bc6cac80e3d7]
stable/6.18: [8b7d4f68fef96cebe0b6dbb6e5607772337f7369]
stable/7.2: [de83ff6a4d8f3618473bedb3c4400020c22e8a8a]

CVE-2026-98719: KVM: SEV: Nullify "have run CPUs" mask pointer when freeing it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98719

Introduced by commit 12c1f6e ("KVM: SEV: Free have_run_cpus during VM
destruction even if VM is no longer SEV") in v7.3-rc5.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
stable/6.18 stable/7.2

Fixed status
mainline: [8abbc76120a74bfba1851bd97528099d715e45c6]
stable/6.18: [b1de3ebf59507e0edacaa5cfa2225bc1869e1b63]
stable/7.2: [0fbc7fec2242de6c3dcea6de55573c428e820173]

CVE-2026-98720: KVM: nVMX: Force MSR bitmap refresh if runtime eVMCS
controls are modified

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98720

Introduced by commit 502d2bf ("KVM: nVMX: Implement Enlightened MSR
Bitmap feature") in v5.17-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2abb25273c82061dd4670690c81c319c03740bf6]
stable/6.12: [2db11598b59f16ddb6420693f9a4ac4efc3d4789]
stable/6.18: [f6189e26d0237e47e2f04f9cb1e43fd19a9b2f3a]
stable/7.2: [1e497e3bdab6983deb68a1d26b488027deb4527f]

CVE-2026-98721: mtd: rawnand: cadence: Initialize IRQ state before
requesting IRQ

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98721

Introduced by commit ec4ba01 ("mtd: rawnand: Add new Cadence NAND
driver to MTD subsystem") in v5.5-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [21f027016b1290d13c30b198ae7a00e6b3d1d5a5]
stable/6.12: [24319f25b641e55f84e55455092a39a2485c78d4]
stable/6.18: [1ed0ccd5649154bfc00ab11c59262d4f42515252]
stable/6.6: [c69d8aceda362c95bbc4e2182f5829275a7db0c8]
stable/7.2: [bbd87eca5407288f2b63ff9357c611cd57e7e640]

CVE-2026-98722: mtd: block2mtd: Fix divide error when erase_size is zero

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98722

Introduced by commit ea6d833 ("mtd: block2mtd: check device size") in v3.15-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5965c4221165045e19736794ca5f48ae3d67142]
stable/6.12: [826170a49ca1315af6b293a02200585b1e2186d9]
stable/6.18: [a991c28066e7ba4da7450bb04478849f7ac6a14a]
stable/6.6: [bff83b723e93acc788bd690dc4bc1f6f4356c35b]
stable/7.2: [21d0f05989bf0d5cef57b467a7fa4feefbd7236a]

CVE-2026-98723: nvmet: copy the hostid into the ctrl before creating PR pc_refs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98723

Introduced by commit 7b65815 ("nvmet: Remove duplicate uuid_copy") in v6.15-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5211fed41d7ec90e9ab7239dc4bffffe4d0b2b62]
stable/6.18: [d3d6d7efdacc08616d23b3ac42272a494951dc0f]
stable/7.2: [23194531595c5d1d4454e3a607b0c8fc0c4e8695]

CVE-2026-98724: nvmet: pci-epf: reject too-short SGL segments

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98724

Introduced by commit 0faa0fe ("nvmet: New NVMe PCI endpoint function
target driver") in v6.14-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d5fbfbbacd1efb13a9bf91317d4fde859ede4b9]
stable/6.18: [2423a05dd0f21330c47ce0ae1cb54a8b0be821e2]
stable/7.2: [472df1d103dbe3e9d09156f0667e36180e912c46]

CVE-2026-98725: nvmet-auth: fix out-of-bounds write in nvmet_auth_challenge()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98725

Introduced by commit db1312d ("nvmet: implement basic In-Band
Authentication") in v6.0-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa6778e030bed9841ddcdf96bc7018da9ac03562]
stable/6.12: [9d61131acd742cf97ee64e453383e41b46568513]
stable/6.18: [7fd3c363eba4f2aceb4b3f31cd1cf65e0dcbaee4]
stable/6.6: [ef4dfad231a787aded76e5b03788ddb18c8aebab]
stable/7.2: [8a9b4c0eef19c207663c1ee888257307c869ca86]

CVE-2026-98726: nvme-multipath: fix underflow in ANA log bounds checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98726

Introduced by commit 0d0b660 ("nvme: add ANA support") in v4.19-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63fa2d9c9c37020bd2703fe2a6a38027b5abeb15]
stable/6.12: [03a0c21f0fd7a872953aae5714303d8f38d1e567]
stable/6.18: [49e8a3224c91fd5fbf22f4adcca6c8209cfdd6fe]
stable/6.6: [3045128294d347fd38542ad6e174b1b34d9c0751]
stable/7.2: [e5cdb0c0a51e8ff49914ae16ef5360010c40cc85]

CVE-2026-98727: nvme-multipath: set BLK_FEAT_ZONED only after the zone
info is known

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98727

Introduced by commit 28982ad ("nvme: set BLK_FEAT_ZONED for ZNS
multipath disks") in v6.11-rc7.
Introduced by commit 3838e80 ("nvme: skip the zoned limits update if
the zone info query failed") in v7.3-rc2.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/7.2

Fixed status
mainline: [4a5e49ba0abb8b4328d6318c9aef0c0121f95507]
stable/6.12: [44dc998c38fb5e153c3ed5665f1112661841c3f5]
stable/6.18: [2d86abd28071481a1abd87204a47325975dc821c]
stable/7.2: [8b85838c1fdba5ba90152693ca158aa9660c628f]

CVE-2026-98728: tpm: fix off-by-four bounds check in tpm2_get_random()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98728

Introduced by commit 1b6d7f9 ("tpm: add session encryption protection
to tpm2_get_random()") in v6.10-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b522400bf5c082feb9a0037a053ea822a2c7e4d]
stable/6.12: [be54101992c2c5218be0e0a87827ccc96e3089af]
stable/6.18: [e30a2406408d2df6d9cd48c2e59e913cf266a05a]
stable/7.2: [42bb6216b861e892512128219ff23010d656ba14]

CVE-2026-98729: x86/mm: Don't apply va_align to hugetlb mappings on AMD F15h

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98729

Introduced by commit 1317a5e ("arch/x86: teach
arch_get_unmapped_area_vmflags to handle hugetlb mappings") in
v6.13-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2457a7e2727dc747a61a50d65c2f259afce8c45]
stable/6.18: [fe23680e6f1d52b8cc45d77bf7c54249508a81c7]
stable/7.2: [b46b2e2de47ca9449532b0a7110ed99f79061d6e]

CVE-2026-98730: Bluetooth: btintel_pcie: reject oversized TX packets
in send_frame()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98730

Introduced by commit 6e65a09 ("Bluetooth: btintel_pcie: Add *setup*
function to download firmware") in v6.10-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f771f96557a4d953a7e4d045870547271e36e819]
stable/6.12: [3d6ba6be9bef13edcd4ad74f7cfdd0c34db4d2bc]
stable/6.18: [84df222de86eabed543361025ed54ce838c0b573]
stable/7.2: [9806a748f9ab223b733624367b6ddda77fb9450e]

CVE-2026-98731: Bluetooth: btintel_pcie: fix plen overflow in
btintel_pcie_recv_frame()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98731

Introduced by commit c2b636b ("Bluetooth: btintel_pcie: Add support
for PCIe transport") in v6.10-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7dbeb6935ac331b0cba6c41cabd8e9d02d5f64ea]
stable/6.12: [c3a3842c109ac130c6db3aa0014cc8cd344928ad]
stable/6.18: [c3b5e6da4ba6485bffda9753d8339c28855207aa]
stable/7.2: [b2cb5ea1dc8cf829816370fc1399e6a1d2d1bca9]

CVE-2026-98732: Bluetooth: btintel: fix buffer over-read in btintel_hw_error()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98732

Introduced by commit 973bb97 ("Bluetooth: btintel: Add generic
function for handling hardware errors") in v4.3-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40eb4b18ad167b63644c27fa67a7400ba050379a]
stable/6.12: [bbc7de352f3f3864369c904aac944c7de84c6e7b]
stable/6.18: [c42ce5373405ca93946311652c51ccfeb1c2d913]
stable/6.6: [be58b239d2be5da7a7fac11d3eb8bf75dce6511b]
stable/7.2: [673f707518e8ef03306f84c512cb160971f175fe]

CVE-2026-98733: Bluetooth: hci_core: Serialize fragmented ISO packet queueing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98733

Introduced by commit 26afbd8 ("Bluetooth: Add initial implementation
of CIS connections") in v6.0-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a572db43c057566771b485598ad2e66cb390821]
stable/6.12: [d6d709981208567868c5c01ebd1bec5e5e7fdab0]
stable/6.18: [708cdd203d0bbcf9255fffb2e4c308d5b28851a7]
stable/6.6: [545fa70f730eb648a610a2f4b2d270865f77b619]
stable/7.2: [a7161730a3ab3f0a3896000db7ab0284683936e6]

CVE-2026-98734: Bluetooth: hci_core: Serialize SCO and ISO scheduling
with teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98734

Introduced by commit bf4c632 ("Bluetooth: convert conn hash to RCU")
in v3.3-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [848a7a91c7f03675d3bd8db6f7721cbf9cb50e21]
stable/6.12: [101825c09ad6b7daa6cf4c9e6b1720b13de15596]
stable/6.18: [1681f97afdf92e8557f2f3118ddc898471b5d299]
stable/6.6: [f997e03e2ef58aa7114828c9d924e515a9a1db9c]
stable/7.2: [ecdb1c66d8e14e63731c52d6fbcfa604064913c4]

CVE-2026-98735: Bluetooth: hci_core: Serialize ACL scheduling with
channel deletion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98735

Introduced by commit 3eff45e ("Bluetooth: convert tx_task to
workqueue") in v3.3-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f4845ab191a4f686a5da481fbba90ed73bb693b0]
stable/6.12: [51f95ea451f25d7e3f048c0f438f04fa74688aae]
stable/6.18: [86e9708f9d19a7f1bd5dc9c1652d07707f79f5bd]
stable/6.6: [780affacd92977fd9b819bdc4f26a6832cb27fda]
stable/7.2: [4fda8f0abeea9929036446d89a476fb8298abcb0]

CVE-2026-98736: Bluetooth: hci_conn: Lock parent access during
enhanced SCO setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98736

Introduced by commit e07a06b ("Bluetooth: Convert SCO
configure_datapath to hci_sync") in v6.1-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [024e05f73a4c1263d031614bc36700ec135eecb4]
stable/6.12: [1239ef0fa809b5952fca679db3faa3e1c00e1dac]
stable/6.18: [cabd58d9bb66d49d481f762ce986173db397435d]
stable/6.6: [70b55855eecb428d446344d827bda8725ce8b312]
stable/7.2: [93a737e4e042f59673cd580d35214f278d7b757d]

CVE-2026-98737: Bluetooth: hci_sync: Fix inquiry cache use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98737

Introduced by commit cf75ad8 ("Bluetooth: hci_sync: Convert
MGMT_SET_POWERED") in v5.17-rc1.
Introduced by commit 4534009 ("Bluetooth: hci_conn: Only do ACL
connections sequentially") in v6.9-rc1.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [8ed67535fdff40ca652bcd4ac7da68d11d01bd34]
stable/6.12: [52edf1c0e59dea37b8368c4a2559dca96b2fdfea]
stable/6.18: [333257e6e4a7bcaaea82fd357121d0f1e6b76c7b]
stable/6.6: [ddc9edb244cc8b5266595e8fc220e7813f2b603a]
stable/7.2: [a642f498f0b08f2aa9f4a69468db92f57a72349d]

CVE-2026-98738: Bluetooth: Serialize SMP remote OOB data access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98738

Introduced by commit 02b05bd ("Bluetooth: Set SMP OOB flag if OOB data
is available") in v3.19-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81a2345f1984f0b36d3226571bc196316a01b648]
stable/6.12: [1e11412a1b9854a89d044576d616675b16141d87]
stable/6.18: [889c61e3d0f1091a958e4b2a24b20bab23d915c4]
stable/6.6: [94afa17d6bfd5c1d367c56c8b63df5f695380861]
stable/7.2: [df5162eeb10e69fe0c2349503882c4a09077f001]

CVE-2026-98739: Bluetooth: RFCOMM: Fix initial port reference race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98739

Introduced by commit 80ea733 ("Bluetooth: Fix unreleased rfcomm_dev
reference") in v3.15-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d696c1ed3468dcb62578a3911e687110d463520]
stable/6.12: [a03ccf1ab77380d4c4a3c56552e12de4a83efa21]
stable/6.18: [0a554901bd227537f79220443b2b36d585d62893]
stable/6.6: [55d162aa00d1ee33c3e6fa88b71f1e2d6e1441e9]
stable/7.2: [e5aa7fbf7a4446bb89f0b8394b2dfc1a6b6aba5b]

CVE-2026-98740: EDAC/altera: Drop __init from ECC setup paths for
re-probe safety

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98740

Introduced by commit 788586e ("EDAC/altera: Initialize peripheral
FIFOs in probe()") in v5.2-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b62a264163ca51bee04785c581344751812395df]
stable/6.18: [9846b85c2eb8b749c3f14bdcc31b1070f6aabba8]
stable/7.2: [4ec26cb7984740941892ad21fa974963c198bfaa]

CVE-2026-98741: ALSA: ua101: reject mismatched capture/playback packet sizes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98741

Introduced by commit 63978ab ("sound: add Edirol UA-101 support") in
v2.6.34-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86f86e6fdedc33c5b8d38b9208b350f8accf57ee]
stable/6.12: [fd3a7bf0d988b0878a1957df150edb35f81db87e]
stable/6.18: [eb0c7fda59cf650076f8ed5b949a6c8441aa3606]
stable/6.6: [ada5ded765f059a6e3036e69ca350449442af0fc]
stable/7.2: [4294fe57048594a9e158b61c967bb7f943cda477]

CVE-2026-98742: ALSA: seq: Serialize compat port-info ioctls

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98742

Introduced by commit b3defb7 ("ALSA: seq: Make ioctls race-free") in v4.15-rc9.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [95b2e0361c88753afa030c10698be0a1a5b67650]
stable/6.12: [413211dd31cb2ef2fc99fb0aa1a037a97509502c]
stable/6.18: [fc5c52848e405b6efb073db5035bb9ebaed11ec4]
stable/6.6: [2db234e163f0d211b69a4eebbec8aacc5a54a80e]
stable/7.2: [702d92f361f65d9698c473c7599d471395dc4341]

CVE-2026-98743: ASoC: codecs: rt1017-sdca-sdw: fix uninitialized
stream_config->type

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98743

Introduced by commit 2b7aecd ("ASoC: rt1017: Add RT1017 SDCA amplifier
driver") in v6.6-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [174d160884199cad97413f33fe1b56027dc0d3e1]
stable/6.12: [4e337c24c0a97fcdb394f954208971de5d372066]
stable/6.18: [d195c8c763fdd0a7f74a34973f8946215a708f1e]
stable/6.6: [30a60e74ee71de027bf1387ac20d73e863bbf77b]
stable/7.2: [7791ebf56eb4ab6b7a20252757a3029bc8068715]

CVE-2026-98744: ASoC: codecs: max98363: fix uninitialized stream_config->type

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98744

Introduced by commit 18c0af9 ("ASoC: max98363: add soundwire amplifier
driver") in v6.4-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bcd61aa247c28b721ac21dda6e4135f75a2de29f]
stable/6.12: [1c251426bb67de5cbfd3b5550bd5983736e8b9c7]
stable/6.18: [7df8c39a50f364c04d68881e61ba1ecad29d4b72]
stable/6.6: [a756c93fae312cc2bcdf157a0992e505573c530f]
stable/7.2: [f44ba04c7a32bd13dbdcd814385b8629d0ee95e3]

CVE-2026-98745: arm64/fpsimd: signal: Forbid non-streaming SVE payload
on SME-only systems

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98745

Introduced by commit 7dde62f ("arm64/signal: Always accept SVE signal
frames on SME only systems") in v6.2-rc4.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [e060d9069b49fe55f38057dfe592068014652671]
stable/6.12: [f2338929c7663859c0c74dd6fef2c0245066f845]
stable/6.18: [2bce6f006cfe0b60e8249fd8d51396d99355cba3]
stable/6.6: [052acee9880114879b5c221fc8dad69b786d0938]
stable/7.2: [88c1c611552b24658eb61244086691c02be2013b]

CVE-2026-98746: serial: ma35d1: Fix clock reference leak in ma35d1serial_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98746

Introduced by commit 930cbf9 ("tty: serial: Add Nuvoton ma35d1 serial
driver support") in v6.5-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98401cf912fe8a081ef8e500c421b6d957b55a99]
stable/6.12: [547c742f3b4acd4634eec47e9bff8731b55059a0]
stable/6.18: [d8233d6b391b4cd87df6e89056c21496df7a3012]
stable/6.6: [3cdad0c541f899bd9a109b7dc43a1bc76123bc84]
stable/7.2: [1b303d383089aae7f20ad19fee15690486b935cb]

CVE-2026-98747: serial: core: fix NULL pointer dereference in
serial_core_unregister_port()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98747

Introduced by commit 84a9582 ("serial: core: Start managing serial
controllers to enable runtime PM") in v6.5-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [499485a67fbacf4d9afbdb43522388c64f853428]
stable/7.2: [54abbb862366dcaf1f22f1e968358147b7d0547d]

CVE-2026-98748: serial: 8250_bcm7271: fix use-after-free in brcmuart_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98748

Introduced by commit 41a4694 ("serial: 8250: Add new 8250-core based
Broadcom STB driver") in v5.13-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [189b9dc8c96ec9486482f27c1372b04a7152175e]
stable/6.12: [f5ce06e648d775cc1ccf66f4f594bb8b559a7d8e]
stable/6.18: [e32440fa536af96bdbc61d933a7c3a920b965edc]
stable/6.6: [dd81650bec58ac70e5dfde2ec390acc1f0d1ed76]
stable/7.2: [0794ba5332754866b2f1c0cca668775be3ffcf0a]

CVE-2026-98749: tty: serial: max3100: shut down timer before freeing port

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98749

Introduced by commit 7831d56 ("tty: MAX3100") in v2.6.30-rc2.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db0949bbd06db0a75b4b1076f1e25194be7d956a]
stable/6.12: [fb668620e3b163962dabe1a674725a07aa44ff4a]
stable/6.18: [2c8614981d3e6e000427de0ab2426ab68274d850]
stable/6.6: [158a07da2da720f2f98b4bea129212c6805d8ee0]
stable/7.2: [247b8f680876313586aed4d267bfcceddc2b4901]

CVE-2026-98750: tty: fix saved termios reset race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98750

Introduced by commit 93857ed ("tty: reset termios state on device
registration") in v4.12-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8df07fe93573e9e548d6645273e9bcb6eb74059e]
stable/6.12: [1572d86bcf0bcb848d20fc5e5de7ed6963034c2b]
stable/6.18: [08bf919f041af9de372428bb0c938157ea144164]
stable/6.6: [6b4e15cccfbe03b7c6ae60ff570c401bfb1e51d6]
stable/7.2: [dcaf0251f847a45861e94c6617024a9455687d2f]

CVE-2026-98751: tty: abort break signalling on hangup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98751

Introduced by commit f34d7a5 ("tty: The big operations rework") in v2.6.26-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [845a2737e0f5ffe5ca8d38de556012b0c9472cdd]
stable/6.12: [3bc82999fb85cecc7eb6ec1755ee7d698aa1e783]
stable/6.18: [94af6cd832e9b4ce39a8fb59144a8f09ab56fd35]
stable/6.6: [6c9c9367351a461d62e5c0a39bffdcfbb40f068b]
stable/7.2: [c8ccd3b2013daaf77b98f8a6724fcf4d2c5c52d6]

CVE-2026-98752: tty: port: fix tty_port_tty_vhangup() race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98752

Introduced by commit 7ca0ff9 ("tty: Add a full port_close function")
in v2.6.32-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b48820de8c1a596c5b99775524dfce73c6576c5d]
stable/6.12: [6d1a984afc3ca477dab3e51ec806671d443ad524]
stable/6.18: [6b7be3b9b857947e9c1338d4919d4ebd3b75e907]
stable/6.6: [ce220b4cdf62f73db0c1940f968eb33b9899fdd0]
stable/7.2: [017b18addbe8dcace1a569a00d40ed1ba1e03f4c]

CVE-2026-98753: tty: tty_port: restore TTY_IO_ERROR on activation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98753

Introduced by commit a9a37ec ("tty: tty_port: Move the IO_ERROR
clear") in v2.6.33-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56964f6a31238fb41d5830bb42520c5b10ff7d8f]
stable/6.12: [34d4f67472ef7a744970b772a8565ddc727788e2]
stable/6.18: [7021acc84c2e0add77a1a33152e3a1e428fdbfdb]
stable/6.6: [16032c980d8f71642fcdc99309c571df3fcf3328]
stable/7.2: [6388409b711eb91b14fa075a4d861ccc4df1cfe7]

CVE-2026-98754: tty: vcc: hold port lock when clearing tty pointer in
vcc_cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98754

Introduced commit is not determined.Fixed in v7.3-rc6.
Affected file was added by 55bd2133fc3c ("sparc64: vcc: Enable VCC
module in linux") in v4.14-rc1.
This driver is depends on SUN_LDOMS and SPARC64. The sparc64 is not
supported by CIP.

Fixed status
mainline: [03b49c991abb8d021ca6fe51cd173447236b0552]
stable/6.12: [88f6ecb058801e9ce7b9aabc966530118d7cd53c]
stable/6.18: [821050631750e982007c0856c119346edba51cae]
stable/6.6: [57753441ef84bee3bf0e9ee1e3778d119c44aa32]
stable/7.2: [1a9fb9eaeb69b1f6c00bed09289a33d9fe1e7ae4]

CVE-2026-98755: tty: vcc: zero-initialize control packet in vcc_send_ctl()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98755

Introduced commit is not determined.Fixed in v7.3-rc6.
Affected file was added by 55bd2133fc3c ("sparc64: vcc: Enable VCC
module in linux") in v4.14-rc1.
This driver is depends on SUN_LDOMS and SPARC64. The sparc64 is not
supported by CIP.

Fixed status
mainline: [1f71f565e3585da1098ff19ca3c24687dab59185]
stable/6.12: [6f1a08ef02825b440126c406ea63ef6128888e15]
stable/6.18: [4335278d0e75395cbfaf71c84b521df56d69e936]
stable/6.6: [4b59afc8af3143ae03e4f9b81ca66aa5a1c1ebed]
stable/7.2: [399aa38af1d78001612e3130b2056ea392a355ca]

CVE-2026-98756: usb: cdns3: Fix NULL pointer dereference in cdns3_pci_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98756

Introduced by commit 7733f6c ("usb: cdns3: Add Cadence USB3 DRD
Driver") in v5.4-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5052f2c5c73c1dcca42bafc0bc737af2b2af059]
stable/6.12: [549c04df02f1bb5a10342f32e2c87f5d27c97279]
stable/6.18: [d16046f1ace2691b6a946f022fe6dc215936880b]
stable/6.6: [dbdd0ca9a7eac140697a366f698a0e2bb02a06a1]
stable/7.2: [45b606418bae73c7cde9f0e57e5b0977c816a7c0]

CVE-2026-98757: usb: cdns3: fix use-after-free in cdns3_gadget_exit()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98757

Introduced by commit 7733f6c ("usb: cdns3: Add Cadence USB3 DRD
Driver") in v5.4-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ebe9b68c396792c15d0ac690d592e449e74ed804]
stable/6.12: [cc448700db656cceb4b411bf99a2e7132144d035]
stable/6.18: [95160fe606e685ff18de1e6ddcbc08289476004e]
stable/6.6: [efdf0ddaed01161dc1c1f25382856f2fd1c1f44f]
stable/7.2: [159dada48ee2d53eff46e66a8011d67b2c209bbc]

CVE-2026-98758: usb: typec: ucsi: glink: fix use-after-free of ucsi on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98758

Introduced by commit 62b5412 ("usb: typec: ucsi: add PMIC Glink UCSI
driver") in v6.4-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63b269ec537dc0fd26d0bd64872c26860d108c9d]
stable/6.12: [432b58cd959e594909a581b4974396cdbc9d4ca1]
stable/6.18: [41934f92e7a54d4080ac0b17aacc83224946785c]
stable/7.2: [ee8577de01c6b6c7dd1d76b52242c54d37a989f4]

CVE-2026-98759: usb: typec: tipd: fix uninitialized typec_partner_desc
in cd321x_update_work()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98759

Introduced by commit 82432bb ("usb: typec: tipd: Handle mode
transitions for CD321x") in v6.18-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88c7e458af53ff781a3f1051708395892b325576]
stable/6.18: [75dc6cb377efd2f4428b7f76d3a590a0bbc10399]
stable/7.2: [5414144e202a32437e3eb436cd3f5f00d79ad86e]

CVE-2026-98760: usb: typec: tipd: fix uninitialized typec_partner_desc
in tps6598x_connect()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98760

Introduced by commit 0a4c005 ("usb: typec: driver for TI TPS6598x USB
Power Delivery controllers") in v4.15-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4b27b3605788bbf9e4251f3cd4ab94645ab036f]
stable/6.12: [4b6823ce0e548491cb9663303cba28e18d351096]
stable/6.18: [282be6ae8be791762740107c79cecf5121f66063]
stable/6.6: [a39d53f70e637ff3970046c32106a0e64fca62cd]
stable/7.2: [dac0c073c6ad5f1bbb5e9fea9023fc1b4dab5e14]

CVE-2026-98761: usb: typec: tcpm: recover after failure to start the frs ams

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98761

Introduced by commit 0908c5a ("usb: typec: tcpm: AMS and Collision
Avoidance") in v5.12-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90156585765b29304f07b0e4a1c56a969876fcfc]
stable/6.12: [184d842121e7d1fbc3a81895f36f72fa27444163]
stable/6.18: [b2ed8643face247e513fad12e193378ba67a61a1]
stable/6.6: [ae8aae45a39fcf2c64813652fcb062eace220712]
stable/7.2: [d6b0cce612636f79f2cf0652fce40a0cbff7f0ed]

CVE-2026-98762: USB: dwc2: shut down wakeup timer before freeing HCD state

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98762

Introduced by commit 7359d48 ("staging: HCD files for the DWC2
driver") in v3.10-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd772af9512cdecb83de34a461801533828e77fd]
stable/6.12: [441be312fce927443eae2821f502344d953c38bb]
stable/6.18: [4333174ea52c863a50bb3e0a4726bf9f7cdf7524]
stable/6.6: [82cc242da6d621752718929e6a2fa6f9554ebffe]
stable/7.2: [79ba37dd38a321cb32a79332a3e3c68dd334dca9]

CVE-2026-98763: usb: core: clear both ep_in and ep_out for non-ep0
control endpoints

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98763

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e8baa78d872f2db440d8b9ded946ab8dceb89eb]
stable/6.12: [7a9f61476b0e8002092a52ee8295edeeb0a28d1e]
stable/6.18: [1da16c46b8d7101b74bc2d72a04e23cf5c7ddea1]
stable/6.6: [198d74dcfa129523125f46a89479d3b446b17dbe]
stable/7.2: [c50413ecb662ea43c7f487632c8114721743a277]

CVE-2026-98764: usb: gadget: f_fs: Fix NULL pointer dereference in
FUNCTIONFS_ENDPOINT_DESC

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98764

Introduced by commit c559a35 ("usb: gadget: f_fs: add ioctl returning
ep descriptor") in v3.18-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9cd072788c76595529eb38f42bf94d23852f8534]
stable/6.12: [9d8761b3c133f6c6a6d3486839dac60e2cf4bfe3]
stable/6.18: [7811d8e26c77f8eea79e22d0d14c67ec0658b348]
stable/6.6: [06ac8609d6d185ac18c1d6a6a8a9b99e398bd124]
stable/7.2: [35ab269602e1f7c4c0fe6ea3477264bea77eced3]

CVE-2026-98765: USB: gadget: dummy-hcd: Fix wait for outstanding
request completions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98765

Introduced by commit 7dbd8f4 ("USB: dummy-hcd: Fix erroneous
synchronization change") in v4.14-rc4.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [b263ff9b0fc5c1f371d65c4eb196b31263d039ff]
stable/6.12: [7ce4dca0d53b1c3cb2b7e7bb2e42bf5db860caf2]
stable/6.18: [5298c96bf0068f3160969f7ddad81976d01a9b66]
stable/6.6: [6849e51b89de5b6fc7447dc8e612b58df19c7dea]
stable/7.2: [3070806a7bc7bb36ed04a21022c09dafcc5619f4]

CVE-2026-98766: usb: gadget: aspeed-vhub: cancel wake work on device removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98766

Introduced by commit 7ecca2a ("usb/gadget: Add driver for Aspeed SoC
virtual hub") in v4.18-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [20388c8d1d74c203fec8194c45cd31afdfab934e]
stable/6.12: [f343bfa3fc9f6255602d66f4a7dbe7ddef13ba41]
stable/6.18: [474e9e1852fb5ba0bfb26f123dd0cb361d0f4f4d]
stable/6.6: [0d39ac4f65f9357469518c70e42940e0d8b0e497]
stable/7.2: [c81504dfd2d93e345c98e7a012c2f2e74ce5b6a1]

CVE-2026-98767: usb: dwc3: gadget: fix IRQ storm on invalid event buffer count

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98767

Introduced by commit 63ccd26 ("usb: dwc3: gadget: check that event
count does not exceed event buffer length") in v6.15-rc4.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [1ff77cbefe5a653ea12874c213ea4bd0d72c1067]
stable/6.12: [96918ca25ff467c25675478fc79393df4ae9d74c]
stable/6.18: [ba927133b301894e7d24099afbb701887c8cd2f1]
stable/6.6: [6cd82563bb270e03fe2f91324660ea14e3ce5d1a]
stable/7.2: [f51cadb02b439850ab411df0a2cf4288a66d42e2]

CVE-2026-98768: usb: typec: anx7411 - stop the IRQ before destroying
the workqueue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98768

Introduced by commit fe6d8a9 ("usb: typec: anx7411: Add Analogix PD
ANX7411 support") in v6.0-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [469600d5d292b1482c90dd6853555821d11b8c5f]
stable/6.12: [675056e0edb49c0002ebfbc289e6c777bbf315a2]
stable/6.18: [50a92c02551c10e308caa55f7045f31abcef511f]
stable/6.6: [a789838675afa3aa174e744f3cef508cd27e7bb1]
stable/7.2: [cb6bf2c707805211f606fb1e06fe28d9affe5ea7]

CVE-2026-98769: usb: gadget: f_uac1_legacy: validate bRequest index in
generic_{set,get}_cmd

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98769

Introduced by commit c47d7b0 ("USB: audio: add USB audio class
definitions") in v2.6.31-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9062d50e75c24dc7911be05c9b1719b3b256af15]
stable/6.12: [36f3f009049bc91e14dc856007932473318d12f8]
stable/6.18: [8c611876c002d712ae5f246af5188432c708f79d]
stable/6.6: [da841c1511a6160b8bc6bb7b7c6d4c9fb76fb51e]
stable/7.2: [697cfe6e53b66cda196d6f8833b0ee97fefd0a8a]

CVE-2026-98770: usb: gadget: midi2: Fix the jack descriptor array sizes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98770

Introduced by commit 856fa44 ("usb: gadget: midi2: Dynamically create
MIDI 1.0 altset descriptors") in v6.6-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [310c2d4608d8c1a2baa57db1dfd319c5c40cf4a1]
stable/6.12: [8294ff75a9de23f7cc641e5e5ca31fa6ea72a574]
stable/6.18: [87f2185423e01f113811301878f2f67eccec960d]
stable/6.6: [18138d9f19cf6944ff09f5c8c0930545036fe3d0]
stable/7.2: [223c3bd02a582776d8ee47dae7b69d3258420694]

CVE-2026-98771: usb: storage: sierra_ms: reject short SWoC info transfers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98771

Introduced by commit 32fe5e3 ("USB Storage Sierra: TRU-Install feature
update") in v2.6.27-rc4.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a0200d14acd9db388b85cd016e68a4e60d900ec]
stable/6.12: [c85e8331d298b8f1dee8fe63718e76435cec7133]
stable/6.18: [e2d62928f2666a2964a23b1d39e6e762f0628d7b]
stable/6.6: [4faaad69f18332246bbd4ca41718beb2a305bb72]
stable/7.2: [db9d3be156baca6ef80ae5d93acfeb85c61a74dd]

CVE-2026-98772: USB: serial: fix port tear down use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98772

Introduced by commit 2d93148 ("USB: serial: fix lifetime and locking
problems") in v2.6.30-rc4.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33c920f7c5952dfc42d1b8ea6efe16b1f0bb0c5b]
stable/6.12: [60cc9379c3e650d1ebfba4de63f1242537a62a32]
stable/6.18: [5e8980a81af195c49084be5b4c031085b56c7443]
stable/6.6: [e4a6883ad9b4686a5f4bd90ff55a44d7ab65bd3c]
stable/7.2: [e80ee74206f260eb1282e7d1339ff146a4a410d0]

CVE-2026-98773: USB: cdc-acm: skip URB restart in port_shutdown if disconnected

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98773

Introduced by commit f58752e ("USB: cdc-acm: Add quirks for Yoga Book
9 14IAH10 INGENIC touchscreen") in v7.1-rc1.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [dc614d6bc991740d41d5a99ac7765c4b675dda88]
stable/6.12: [9742905d9ed5bf23ebe4c100dec80b6bc50fb522]
stable/6.18: [a0ed07b5bbb2d8fcef86810453216070691816e7]
stable/6.6: [d86775e79838d7d2e38ccf506a7d0f8e2dd4d5d0]
stable/7.2: [420ca35af891d33522cc08504768ccd60a4c450a]

CVE-2026-98774: rust_binder: cancel deferred work items in thread exit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98774

Introduced by commit eafedbc ("rust_binder: add Rust Binder driver")
in v6.18-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62479b6e5df82cbdf3c4145130928f233fae78fb]
stable/6.18: [d54df2de22f9ac5b660d0ec898986f805e97c096]
stable/7.2: [98dc9fababd1b7fb1a88b8362183baa5779c2394]

CVE-2026-98775: nitro_enclaves: fix use-after-free on SLOT_ALLOC failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98775

Introduced by commit 9c8eb50 ("nitro_enclaves: Add logic for
terminating an enclave") in v5.10-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9bc184a2eda8b773c88ecbff934001ad649b9cc1]
stable/6.12: [466041d14f26dc2babd606a2e85dce08774112a6]
stable/6.18: [f7fb6c2835ede1b8ad84cf7e78a528a9d0159b84]
stable/6.6: [8bde6f643ab6fe5e3e3f4c312f84ce327ecf39b2]
stable/7.2: [43f78b328f3907ca2f7424e15b7e45ffbf9fe21c]

CVE-2026-98776: binderfs: fix UAF write in binder_add_device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98776

Introduced by commit b89aa54 ("convert binderfs") in v6.19-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [30d15f44a9e513ec2f257fdf192d9d1fa5af0799]
stable/7.2: [885bbbe52d31856768de439e9720f1ffa474a93a]

CVE-2026-98777: binder: fix leaked fd fixups on TF_UPDATE_TXN supersede

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98777

Introduced by commit 9864bb4 ("Binder: add TF_UPDATE_TXN to replace
outdated txn") in v6.0-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4c02084d6687d5cd5edccaf52cc45e5160f1184]
stable/6.12: [7fd609fb0e9dcbc4d7a1e4da1af5368c0555ff55]
stable/6.18: [1299cb3fb061598496086fc87ff291057831148e]
stable/6.6: [a7329ea53d04f0c6135d02905810cd6f42acdf45]
stable/7.2: [6673f4f21e2fddfed0abe1eb9045cc958e6db130]

CVE-2026-98778: binder: fix is_failure flag for superseded transaction cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98778

Introduced by commit 9864bb4 ("Binder: add TF_UPDATE_TXN to replace
outdated txn") in v6.0-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22c135635fdd9816c0ef140d6de7b2e4fdf73e89]
stable/6.12: [60a9f7323ae7318a7cce0d387c318da24f1e8726]
stable/6.18: [86cdcc87d4ba60aebf94ba3346b3c900c5cd79ff]
stable/6.6: [e9b364e46d594c2ec663c9c49f10c1ca541ecc0f]
stable/7.2: [1ab671b50714ad8e359cf37eb041d8044319ccdc]

CVE-2026-98779: drm/amdgpu: fix ACP MFD device leak on init failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98779

Introduced by commit 2503032 ("drm/amd: add pm domain for ACP IP sub
blocks") in v4.6-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f0013046151b7467e62c471c1c83d63ea255799c]
stable/6.12: [2b9a53940a2bc063ea4cd09ee49220a503a0170c]
stable/6.18: [587469076e4ffb617f7ad1a0c4a13072a3e87113]
stable/6.6: [d700c26ed64bd3c26e4aa7679b9d5f3333c3747a]
stable/7.2: [abf854513bc19e6e24d45353ac99ec5627ee0acc]

CVE-2026-98780: drm/amdgpu: fix IP instance memory leak on kobject add failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98780

Introduced by commit a6c40b1 ("drm/amdgpu: Show IP discovery in
sysfs") in v5.18-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5a5add3605935163dd0f75749b6a7869e9765af]
stable/6.12: [0563b26c1437fe7e25ea42c334eb85c0a703f8ff]
stable/6.18: [7ca44cb14d0249992a8f1425ba004d6e2d16d255]
stable/6.6: [f6364e7284a131556f5d763d867147bece2843a8]
stable/7.2: [c05bbcc263d67b8b158e2a52be7e3005895969d1]

CVE-2026-98781: drm/mediatek: Fix pdev reference leak in mtk_drm_bind()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98781

Introduced by commit 1ef7ed4 ("drm/mediatek: Modify mediatek-drm for
mt8195 multi mmsys support") in v6.4-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3753e34b73fcbe2a2edbe984614a008a261697ef]
stable/6.12: [4a8f9cad0fced77b36b297c67c42730c9cb32ec6]
stable/6.18: [b84f1386d84b3a73f73ebb416a3f97c5d64a8ab3]
stable/6.6: [4a0ae61067671f556eeaf5ea4e59a1db63163d70]
stable/7.2: [cb3e0244514d13507c6048777e1d0277e611cf6c]

CVE-2026-98782: drm/mediatek: Fix ovl adaptor platform device leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98782

Introduced by commit 0d9eee9 ("drm/mediatek: Add drm ovl_adaptor sub
driver for MT8195") in v6.4-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [048739be3e9cacae5301b68245668002fe6f0ce5]
stable/6.12: [3d85bd738aba61df14dfaf8fe638e2172d8427bf]
stable/6.18: [629458b7e49559593823e351535294db17331be7]
stable/6.6: [03fb1c657028cb9f189b400f3adb46e3ba676aa5]
stable/7.2: [8e3a350075b556f2fed4517705935bfee4529fb6]

CVE-2026-98783: drm/mediatek: Add missing IS_ERR check for ovl_adaptor
platform device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98783

Introduced by commit 0d9eee9 ("drm/mediatek: Add drm ovl_adaptor sub
driver for MT8195") in v6.4-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bce7698e2e6565bb765bd0522337f29f5f312624]
stable/6.12: [4acac370aad2d4895a82f40b2f03e9ef70eecaa6]
stable/6.18: [88f8a92dcb0cb154774595dee7226458de4cbd38]
stable/6.6: [f0ffb09cf1bf2a0f301f51fb45371c09dc78fcd0]
stable/7.2: [aeef8a8537bcfb26689edb36ed905b8b2873001c]

CVE-2026-98784: drm/amdgpu/gfx6: fix firmware leak on teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98784

Introduced commit is not determined.Fixed in v7.3-rc6.
Affected file was added by 2cd46ad ("drm/amdgpu: add graphic pipeline
implementation for si v8") v4.9-rc1.

Fixed status
mainline: [cc172e177795c5f87bc2d71768d077e1c10633e8]
stable/6.12: [3a86ebf6aa8b0a845e6188daaa6f530fe67ff00e]
stable/6.18: [652f631e2e3a8d3b11ad72dd0b8e59b5183de0d9]
stable/6.6: [2aee72150b0ea92804f0f2799efb129f10e46e8d]
stable/7.2: [4b70c6b34912ca0b4066f56fd627d785dfbfe1fa]

CVE-2026-98785: drm/amd/display: check dc_state_create_copy() for NULL
in dm_suspend

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98785

Introduced by commit 8092aa3 ("drm/amd/display: Add null checker
before passing variables") in v6.11-rc1.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [015e72cde567d2450e282c2790773463156b2d0a]
stable/6.12: [686baa1f4ec43b33e39e3d4b4a4539a91d17e883]
stable/6.18: [197946faa1b7968046ba475ae2f266847c6f51ed]
stable/6.6: [29302964ef583f3a57efc3c990bc0a71337bd3a4]
stable/7.2: [7283b78ca07ce491984a63f6288f3f8de5bdcb22]

CVE-2026-98786: drm/amd/display: guard dc_sink dereferences in MST
mode validation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98786

Introduced by commit f04d275 ("drm/amd/display: add mst port output bw
check") in v6.0-rc1.
Introduced by commit 5c9b8b2 ("drm/amd/display: Tie FRL support into
amdgpu_dm") in v7.2-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [217f64f348c90cba62164e7ff38e0ccf78a5ca09]
stable/7.2: [daa0437fe5e451856aaf8fda602a9fc2105bbd54]

CVE-2026-98787: bpf: Fix missing migration protection in
__rhtab_map_lookup_and_delete_batch()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98787

Introduced by commit 818e008 ("bpf: Implement iteration ops for
resizable hashtab") in v7.2-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de020dc8049bfb2b22e3b6d99c031feb2e22d112]
stable/7.2: [94f41ec5fa578765b74ad5736c2f029e7aabc46d]

CVE-2026-98788: futex: Fix private hash use-after-free on resize

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98788

Introduced by commit 56180dd ("futex: Use RCU-based per-CPU reference
counting instead of rcuref_t") in v6.17-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f35e3b5784221654f9cdbd6222275a7fa203f6c3]
stable/7.2: [5d5dc18b3a9ac011619b7d3af4514bf9e9b6a6af]

CVE-2026-98789: bpf: Fix objects stuck in free_by_rcu_ttrace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98789

Introduced by commit 8d5a801 ("bpf: Batch call_rcu callbacks instead
of SLAB_TYPESAFE_BY_RCU.") in v6.1-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fbd97dd1d3ce32d32fb7be86acc3fdb7c04fa043]
stable/7.2: [33d0a5d2fee06a51f2f056dd901296515912e954]

CVE-2026-98790: perf: Fix race between perf_event_exit_task() and
perf_pending_task()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98790

Introduced by commit 97ba62b ("perf: Add support for SIGTRAP on perf
events") in v5.13-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ffb684f2aa141eeb0caa6308422e7e05d1ded7c4]
stable/6.12: [672b8a9ce8f51b991481dfde26fba5cc4340a91a]
stable/6.18: [524063fea29f8a841e49927ea7a8085194ad3ec2]
stable/6.6: [655acfa713bce9ae9c81a654459890c2f58cb4e8]
stable/7.2: [81e61e3f8befa1bae3ec8e779d8ada5e5e362c21]

CVE-2026-98791: net/mlx5e: Fix AF_XDP TX timestamp teardown NULL dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98791

Introduced by commit ec706a8 ("net/mlx5e: Implement AF_XDP TX
timestamp and checksum offload") in v6.8-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b97273cbebe9dd4fddc457f0c4f2a124d0e3996]
stable/6.12: [fce70b6bf9f3261e887419a4e7caa25b80fa9d55]
stable/6.18: [f81d40e2eb69552334f510114f3e6edd0d43178b]
stable/7.2: [63df0ef4c6e3105589e6bb2e758ce611b0ada86c]

CVE-2026-98792: netfilter: flowtable: generalize pending status bit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98792

Introduced by commit 2c88979 ("netfilter: flowtable: Add pending bit
for offload work") in v5.7-rc6.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c549fb7eecd01fdba7c0d12c01da876ef8a3214]
stable/6.12: [4d52b72f3aa68ad0536444e36530bda75070194c]
stable/6.18: [4033e1a9262c57dfbfc594a591a50fcba63c531a]
stable/6.6: [f7e292f3c8c853f27a1af7eaf3428a0e76fe5fcc]
stable/7.2: [a2cac45848d1cf31ed190db30f90ba8211e9a8ca]

CVE-2026-98793: netfilter: bpf: reject invalid NAT manipulation types

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98793

Introduced by commit 0fabd2a ("net: netfilter: add bpf_ct_set_nat_info
kfunc helper") in v6.1-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16d464013ec2267b00a83f4bfbb97b3ecc63bfa7]
stable/6.12: [ea777dc90ab37e64fa4b92f6fcf3b5edcef5e058]
stable/6.18: [f6143ae109df56d51d5536e813deb19eee7a6205]
stable/6.6: [752492947be3123ea6c689e2f93ae04ecd675d42]
stable/7.2: [58108f05b0502448f6bb612ee2eccc63bd6449cb]

CVE-2026-98794: ipvs: filter some flags received in the backup server

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98794

Introduced by commit 87375ab ("[IPVS]: ip_vs_ftp breaks connections
using persistence") in v2.6.20.16.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f96e91748f6304668fe647e686d199d7207d36f1]
stable/6.12: [f4cd1db7d421e82945713a36084bb0c35b75b27e]
stable/6.18: [55d033324f67a15ff56be6d38d6e87f644e0ed62]
stable/6.6: [d7d33c9efa9d1a2f244a1a64ec9b540b0f8975a0]
stable/7.2: [45a93111835ccfea7d969ec73588e33745fd9834]

CVE-2026-98795: net: sparx5: skip ptp deinit if init was skipped

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98795

Introduced by commit 0933bd0 ("net: sparx5: Add support for ptp
clocks") in v5.18-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d2c49915bc3aea4521cda5e4d42f24f63b94585]
stable/6.18: [35c706d6eb1963735814c5f5bb2674a96eacf3cc]
stable/7.2: [2879b65bfa548e10d59c5fba91d17f8a00cd7029]

CVE-2026-98796: net: ethernet: mtk_eth_soc: allocate dummy netdev sooner

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98796

Introduced by commit 656e705 ("net-next: mediatek: add support for
MT7623 ethernet") in v4.6-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f0c2c4f5e7143eba75153ecc8af3a03f7b6a98b]
stable/6.12: [42001839e425b2564b7297be579073a13a8fddf6]
stable/6.18: [82be3d08de9e14d5aed72377f051adb4f09fd540]
stable/6.6: [efc91ab1d97bd991faf50baa0ead35029f341eb9]
stable/7.2: [17eafd74de5a31e30361420a2e3ebf64186b77e5]

CVE-2026-98797: net: cap skb->queue_mapping when the tx queue is picked

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98797

Introduced by commit 2f1e85b ("net: sched: use queue_mapping to pick
tx queue") in v5.19-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea4d4b5dddb5121e64f56fd8e0720bd8b447b63d]
stable/6.12: [c6ec35c8267c84c2094cb485db20c06384fc2bcc]
stable/6.18: [2f581814e4e3ea6a5e98f49813dc4c68444a0c4a]
stable/7.2: [f99de42f5c6f8d088063817dad82c3334e87c570]

CVE-2026-98798: net: bcmgenet: fix NULL dereference in set_coalesce
before first open

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98798

Introduced by commit 9f4ca05 ("net: bcmgenet: Add support for adaptive
RX coalescing") in v4.17-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19419faf58dfe5bcc8a9e60e622976c5f8e3ddc1]
stable/6.12: [0d867b91598b6ed2f75998c34f4e2869631da31e]
stable/6.18: [2294b62eaec6fd3c76a261d287f66641eeafd5f0]
stable/6.6: [213ff02ab26a4543ef02b4db393bbdd5fa5679a7]
stable/7.2: [d870102b5425390cab42eebbf3d19ec6a43c6734]

CVE-2026-98799: bpf: Skip detached progs in trampoline images that are
still in use

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98799

Introduced by commit e21aa34 ("bpf: Fix fexit trampoline.") in v5.12-rc5.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [17637e1a581a22466ac3620a91e099683ff9cc6f]
stable/7.2: [967566ad325b42150483e81acb09ea9d800c00b8]

CVE-2026-98800: bpf: Wait for an RCU tasks grace period before freeing
trampoline progs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98800

Introduced by commit e21aa34 ("bpf: Fix fexit trampoline.") in v5.12-rc5.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [0fb5751a6e411b1b466c06e50021818d9391df98]
stable/7.2: [40955f6512a03f0e046f5256b0706b26ba191018]

CVE-2026-98801: net: restrict SO_RESERVE_MEM to TCP sockets and cap max value

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98801

Introduced by commit 2bb2f5f ("net: add new socket option
SO_RESERVE_MEM") in v5.16-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [37e02c42a00be692c06343e11779aadc45f45971]
stable/6.12: [492e04f9a00f3cc88a1f6899417b10f3019a624e]
stable/6.18: [5069ce898148bd799395c5a464e006cbb840f188]
stable/7.2: [a467b05b201b5c26be52ed3081992fa9c0387648]

CVE-2026-98802: seg6: ensure packet data is writable before modifying
SRH and IPv6 DA

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98802

Introduced by commit 140f04c ("ipv6: sr: implement several seg6local
actions") in v4.14-rc1.
Introduced by commit 848f3c0 ("seg6: add NEXT-C-SID support for SRv6
End behavior") in v6.1-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ae3f4067ba4ae3a15581392f6dac422e3d3def0]
stable/7.2: [e9141fdb7a2ead48cfcd60c681aba91d3014255b]

CVE-2026-98803: net: stmmac: fix rx Scatter-Gather support

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98803

Introduced by commit 88ebe2c ("net: stmmac: Rework stmmac_rx()") in v5.5-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88095728511e0df9c89528944f5a1762ad298983]
stable/6.18: [358d5ac5a5d57ce21c3814c4e3e8f3fbcb7304b4]
stable/7.2: [a7cff44543f66f3a19151060cb549691d191d44c]

CVE-2026-98804: net: page_pool: fix use-after-free in
page_pool_recycle_ring_bulk()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98804

Introduced by commit fcc680a ("page_pool: allow mixing PPs within one
bulk") in v6.14-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bdea4980182e3badac74f04df6c07492b91c569e]
stable/6.18: [f78d45d5f1ac4141a03f033141368671da4293e4]
stable/7.2: [0b105f4eb78e5ee39e5a74c47c9efd69b6ac849c]

CVE-2026-98805: tipc: prevent GCM nonce reuse on peer key changes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98805

Introduced by commit fc1b6d6 ("tipc: introduce TIPC encryption &
authentication") in v5.5-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [512ccd3d0e91e791fb37442aa0a2599aca19783d]
stable/6.12: [5c8ce13c792e28d56f9ec3cd6728d8225bc0e3a2]
stable/6.18: [f74f100e49588c1dbdc6ab3ba9e2c67b36d015d0]
stable/6.6: [a85a3dce4b6c73ddaa1e9725b906249744bf7cf2]
stable/7.2: [60e0c2aeaa605ff19ca4e65126a35643d4d7ee1c]

CVE-2026-98806: octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB
is enabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98806

Introduced by commit 184fb40 ("octeontx2-pf: Avoid adding dcbnl_ops
for LBK and SDP vf") in v6.15.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [056994563935e049093f100efaad7e63ad113814]
stable/7.2: [59fbbded05e559675930fd521b8d62b72828b52d]

CVE-2026-98807: net/mlx5: Fix slab-out-of-bounds when handling team
device events

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98807

Introduced by commit 54493a0 ("net/mlx5: Lag, record inactive state of
bond device") in v5.18-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04c824940d52871c49866a4ac67b504146f7cf35]
stable/6.12: [16ca0e79f31ea810346a79dda545ba344ede1d47]
stable/6.18: [3a6e67ff267af2053a793825c3b7844741fed461]
stable/7.2: [8117cbc504cb01980258d8a8c9be8f57cf0aaceb]

CVE-2026-98808: net: systemport: Fix buffer overflow in bcm_sysport_get_stats()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98808

Introduced by commit 10377ba ("net: systemport: Support 64bit
statistics") in v4.14-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb7b84af0ec5c71b4920e999611b466b3784496c]
stable/6.12: [29d1d35ad5ad379a904263ea1cd4ba1d71cd965f]
stable/6.18: [96d8b26be5bc451188acdcee055948da45adbde0]
stable/6.6: [96a2b042051553df0d9f03b518dd3b7105b36935]
stable/7.2: [faba9fdde480356f4a1d3b1a5713b7b354858a1c]

CVE-2026-98809: Bluetooth: hci_sync: don't drain cmd_sync backlog on unregister

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98809

Introduced by commit 008ee9e ("Bluetooth: hci_sync: Fix not processing
all entries on cmd_sync_work") in v5.17-rc8.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1f24c1ab52345e810c42a1a81286cb5a7c92252]
stable/6.12: [143bde97c4101ae68eb656c87e620c45b07a3090]
stable/6.18: [7f16443a30f4e86d84ae4faf057d333b41ddb757]
stable/6.6: [b11acfcb5925ed27fae692b27931a1ac732677fb]
stable/7.2: [e8ba8c9c74d1035042cdf6cb5adf8f59b9b1271c]

CVE-2026-98810: wifi: mac80211: fix slab-out-of-bounds read in
ieee80211_monitor_select_queue()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98810

Introduced by commit cf0277e ("mac80211: fix skb buffering issue") in
v2.6.33-rc5.
Introduced by commit 9b8a74e ("[MAC80211]: Improve sanity checks on
injected packets") in v2.6.24-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f63e919fe1e335b8abcb3a28bfd4804a98d875a]
stable/7.2: [63e7064b4c1c4b540bf2f0cba47384f92ab95307]

CVE-2026-98811: net/sched: cls_api: reclaim an empty proto on the error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98811

Introduced by commit 8b64678 ("net: sched: refactor tp insert/delete
for concurrent execution") in v5.1-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0bb8eab29b55045281a4963d4557f2776cdf8cfa]
stable/6.12: [315e4fe65cf02ef052de5e6298c3088e448b7517]
stable/6.18: [ebc9611ab154c0cd9f1320e2a73f5e936d7535a9]
stable/6.6: [0fc74e7d97d232095ce64cb45d25f0919df7ad4a]
stable/7.2: [570141625d212fbbcffb9665cb45c0f04610e61a]

CVE-2026-98812: net/mctp: publish the mctp_dev only after it is initialised

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98812

Introduced by commit 583be98 ("mctp: Add device handling and netlink
interface") in v5.15-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aadf655e8ea9a8ffa24bb8d69f504572e8d18181]
stable/6.12: [af6e4f931afc2d670d133aa2bedc8b6e3753c618]
stable/6.18: [63120572edde85bb2b70b0ed4d4817ed52247613]
stable/6.6: [288ef37e0c463192dbb6436e61cdc07ce666dcb9]
stable/7.2: [f37f42e6e039a48c2dcf6c079b9f7fbc864ab7ef]

CVE-2026-98813: bpf: Hold map BTF for the memory allocator destructor record

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98813

Introduced by commit 1df97a7 ("bpf: Register dtor for freeing special
fields") in v7.0-rc2.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [ab39974240a0cff765f3bb9cce81d8001ffdb144]
stable/7.2: [b506f5699e145196ee29d76cf1ca1cbb2202c055]

CVE-2026-98814: nvme: fix command effects log lifetime for multipath heads

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98814

Introduced by commit be93e87 ("nvme: support for multiple Command Sets
Supported and Effects log pages") in v5.9-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72ece656abd4de8645a421fb482d7a11e6533a45]
stable/7.2: [351d1c47e45b2b35780d0548b1012d7242ba298d]

CVE-2026-98815: nvme: fix cdev lifetime

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98815

Introduced commit is not determined.Fixed in v7.3-rc1.
drivers/nvme/host/core.c was added by 21d34711e1b5 ("nvme: split
command submission helpers out of pci.c") in v4.5-rc1.
drivers/nvme/host/multipath.c was added by 0d0b660f214d ("nvme: add
ANA support") in v4.19-rc1.

Fixed status
mainline: [9952f3882ecba709092379b71e02b09762b26f96]
stable/7.2: [98b09ad7934482e64db4b4477d91e3bbf43adf4c]

CVE-2026-98816: bpf: Fix overflow of jump offset in constant blinding

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98816

Introduced by commit 4f3446b ("bpf: add generic constant blinding for
use in jits") in v4.7-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad139384ecddb6f3e7e3c3c12765aafae0e39670]
stable/7.2: [443328237113ee0ea515e506497334d871dbc2aa]

CVE-2026-98817: ASoC: SDCA: Add better pm_runtime error handling in func probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98817

Introduced by commit 3af1815 ("ASoC: SDCA: Add basic SDCA function
driver") in v6.19-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [91094f9c86216898ce92141c26c8fec7e97544c0]
stable/7.2: [1f90c62a2412b3b9af27e0d23e346efcf88d83bd]

CVE-2026-98818: mm/slab: do not wake up kswapd in __kfree_rcu_sheaf()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98818

Introduced by commit ec66e0d ("slab: add sheaf support for batching
kfree_rcu() operations") in v6.18-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af2fb3ee6679b517e2fdbd3ba16ec276a8b74312]
stable/7.2: [46545c86b54ffb969b6e3662942b4a6191619eaa]

CVE-2026-98819: Bluetooth: btintel: validate DDC record lengths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98819

Introduced by commit 145f236 ("Bluetooth: btintel: Add Device
Configuration support") in v4.4-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9c15d4d8956df8c564f7c210e4dc5b9b820d97a]
stable/6.12: [069031f569f1681f17e863f48c221a6091b47850]
stable/6.18: [b0fce76873a5e6a6820354409b26693ac5f8b251]
stable/6.6: [7df748aa9f9ecab514e5989ed89c9ba35b6e5574]
stable/7.2: [f3617369fbb30a4d2e54841ab8e92ca4fa211e56]

CVE-2026-98820: blk-mq: set RQF_USE_SCHED when the operation is known

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98820

Introduced by commit 4b6a5d9 ("block: enable batched allocation for
blk_mq_alloc_request()") in v6.1-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab6c756f28c741d704a7c3e04814bfc3adf6f818]
stable/6.18: [790730e4d95de8356a573d4b4864486bba731863]
stable/7.2: [2c47ebc27fa72078e26177cd458cdaf3006a9685]

CVE-2026-98821: block: reject polled dio with user integrity metadata

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98821

Introduced by commit 2729a60 ("block: don't silently ignore metadata
for sync read/write") in v6.17-rc6.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a42e6fe1293f2e2d579c9fe5bbab056dd8b880e]
stable/6.18: [c97ef13ad96be0e08af38dfa2ed40cded0b53e1b]
stable/7.2: [dd33c03cefccdfcb223e9e6262643d64f8c1ae20]

CVE-2026-98822: wifi: mac80211: prevent AP VLAN tx from other interfaces

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98822

Introduced by commit 97ffe75 ("mac80211: factor out station lookup
from ieee80211_build_hdr()") in v4.1-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f93ca31f7fd9b42e7d692f59514436d448ac908]
stable/6.12: [fd875e24e8f2b202e3636b3ef8e6060874eca0e5]
stable/6.18: [88e96d902efeefbffc34450969f40dc61a0c8a42]
stable/6.6: [2fe08c8ff26841430a3c98ab755337325b5d47b5]
stable/7.2: [ad61b9a5febb42e4b96df8d30ad76ddc36dda9d0]

CVE-2026-98823: wifi: cfg80211: preserve hidden-group beacon IE ownership

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98823

Introduced by commit 0afd425 ("cfg80211: fix duplicated scan entries
after channel switch") in v5.4-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc45f313d85533d647ce619326302aad6f797c14]
stable/6.12: [49b66110a08e4f926f6393e938f226de2750a08b]
stable/6.18: [dd7973a4130b0862be38d7e08cc0e874b3d99967]
stable/6.6: [5617d5328839003c91007ce906b4f100b43926e9]
stable/7.2: [5f27581c176f84b52ec0ab9be7b500c10667ef60]

CVE-2026-98824: wifi: mac80211: validate TX status rate metadata

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98824

Introduced by commit a5f69d9 ("mac80211: Get rid of search loop for
rate group index") in v3.3-rc1.
Introduced by commit 9208247 ("mac80211: minstrel_ht: add basic
support for VHT rates <= 3SS@80MHz") in v3.19-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6bdcdb31318c10e6369cff8e5b32c37397e98091]
stable/7.2: [b1961a61ab6fbe11f16f7f9b64c57a9908c6c3a8]

CVE-2026-98825: rtc: mpfs: fix unchecked devm_clk_get() error pointer in probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98825

Introduced by commit 0b31d70 ("rtc: Add driver for Microchip PolarFire
SoC") in v6.0-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac41b05d15db3134e839148290d67415ee0bdb58]
stable/6.12: [74dc7c52946e3d47c40edd0875adb7cc15937066]
stable/6.18: [cfd70c9b19846c524f2b6195a7484bdf22071ccf]
stable/6.6: [ab741d1b714b4acc605f3d14cdc4120f87341ed1]
stable/7.2: [8a03f8422fa08eed335c51bccb612a3d81739ff2]

CVE-2026-98826: rtc: ac100: Fix clock provider use-after-free on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98826

Introduced by commit d00a18a ("rtc: ac100: Add RTC driver for X-Powers
AC100") in v4.9-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fcf0b58e976e83adf246b014518e49c662b96f5e]
stable/6.12: [12bcd20d76703ee2baf52224d287b7fea096b12f]
stable/6.18: [9cff19ddd7f90c1f572a0f83cfc41de8f8dcbcd8]
stable/7.2: [55ca60ba336632349f7c4585d22ba74ae355b7ce]

CVE-2026-98827: wifi: ath9k_htc: bound TX aggregation to MAX_TX_BUF_SIZE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98827

Introduced by commit fb9987d ("ath9k_htc: Support for AR9271
chipset.") in v2.6.35-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aeaca27c1db3106967ffbb2b517d98c835f6d500]
stable/6.12: [c18882768a0fe253c70986c5fe66d9241570fbc4]
stable/6.18: [345ce265cf604e84b5b560c21beaf4c6f269ab14]
stable/7.2: [e73a619f91b6cfec47bc1a94aea28df6849e5be3]

CVE-2026-98828: wifi: ath9k: reject short WMI command responses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98828

Introduced by commit fb9987d ("ath9k_htc: Support for AR9271
chipset.") in v2.6.35-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [93ce8ea70451e800601bc9444aa33043de15d67b]
stable/6.12: [03ef61d05aa26022327f971b790f07e6bf6e35d6]
stable/6.18: [e0c21130c1c7791ba73b19a3a9ea767c8cd43745]
stable/7.2: [a3b0137c855a61371d9cf9993b8bcc33c9798202]

CVE-2026-98829: wifi: mac80211: drop oversized fragments to avoid
extra_len overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98829

Introduced by commit 69f1322 ("mac80211: shrink struct
ieee80211_fragment_entry") in v4.3-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e4f3509793b4db2c0835340224743db680e861f]
stable/6.18: [9338b2dea74cb0fc80a4c958b68e687610ba2261]
stable/7.2: [870b8cb9baa9bd859deceb33ae158011e6ba2360]

CVE-2026-98830: wifi: wfx: validate MIB read length before copying to caller

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98830

Introduced by commit f95a29d ("staging: wfx: add HIF commands
helpers") in v5.5-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce67ebe9d8629776ce38e6995ae72fb903c828db]
stable/6.12: [02886c18a340da59df57365f29009e1258bfe333]
stable/6.18: [71d140099165de03128c00dd129f1eab21c6a3c4]
stable/6.6: [819d4c1323e2a9b7329021d5367aa01add22b5dc]
stable/7.2: [7acb36fd60a3e7b858f12e69a919c3609b281408]

CVE-2026-98831: of/overlay: don't leak fragment references when
changeset init fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98831

Introduced by commit 61b4de4 ("of: overlay: minor restructuring") in v4.15-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d62f0f2bc7edb12ed09f71203df0e47fa4efca4]
stable/6.12: [894573e2fdaeb1b15030b7eebc22615edf28a6cd]
stable/6.18: [7a46f1917b320cc8762183b802301da02a191b6a]
stable/6.6: [702b5db6e7b3865be70675d57d6fd7dde80d02b6]
stable/7.2: [3a23fb158ba517b77a2e5258263bdfdaa480f758]

CVE-2026-98832: blk-cgroup: save IRQ state in blkg_tryget_closest()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98832

Introduced by commit 9327a86 ("blk-cgroup: don't nest queue_lock under
rcu in blkg_lookup_create()") in v7.2-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [327c428ba79b13e4cc5253333a9d5c0aa5579bdf]
stable/7.2: [9fcf4317384ce6758c3127a6e8914c54cbb9c8cc]

CVE-2026-98833: mtd: core: call _get_device() with the master MTD

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98833

Introduced by commit 46b5889 ("mtd: implement proper partition
handling") in v5.7-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12b31d1acd20b3185bb5f0748db0cf6874c8e9d1]
stable/6.12: [95c8f36293c22d450c371167ad4f9a5bbadc7539]
stable/6.18: [f971f1c63cf71579258360a12bd185bc1cd1a043]
stable/6.6: [d94731cafa57e2c986ff391122d1494e5a3f3c3f]
stable/7.2: [dc482a281a19a7d7e91ad1b2d551bb301c54d0e6]

CVE-2026-98834: mtd: core: avoid double-free of OTP NVMEM device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98834

Introduced by commit e0489f6 ("mtd: core: fix error path for nvmem
provider") in v6.4-rc1.
Introduced by commit fe0b821 ("mtd: core: Don't fail
mtd_otp_nvmem_add() if OTP is unsupported") in v6.10-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26300879cd8e4612dce66bb8f6ff7cd35fcf3e59]
stable/7.2: [cecf007418b93a2cbc94269e07fe2fb28f54d8fb]

CVE-2026-98835: iio: accel: kionix-kx022a: Fix array boundary check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98835

Introduced by commit 7c1d167 ("iio: accel: Support Kionix/ROHM KX022A
accelerometer") in v6.2-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e65412aee4f651d2c9785f542a13e4b44002a75]
stable/6.12: [87746be179dca4d94d73d5a323a39a87bb2e90fc]
stable/6.18: [4c73c1859fa64509aae7e23a6dbd2d5c8a64c05d]
stable/6.6: [714d8f0b1c616a6a82be87ccb72271b6092773d1]
stable/7.2: [22d377178de281d21ddf908d03a8e9fde3339d9f]

CVE-2026-98836: ALSA: line6: reject oversized playback packets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98836

Introduced by commit 7a0f55a ("ALSA: line6: Support assymetrical
in/out configurations") in v4.9-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61b0a5a114fa4552892da5c0ff2f42e63bf08c6b]
stable/6.12: [a84371be89c39ccc46c7af8b9eb15c448df9265f]
stable/6.18: [3f75da1e4ee699f6650d23d6897cf443b01856c7]
stable/6.6: [933d8ac23388eb208ea195231d682dce0bec86ca]
stable/7.2: [b78748424f29f07d310484b2b36afdececa74389]

CVE-2026-98837: ALSA: caiaq: unregister the input device when probe fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98837

Introduced by commit 28abd22 ("ALSA: caiaq: Handle probe errors
properly") in v7.1-rc1.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [0b7bd20f6379bc5e431fd74d866390f5b5b63f3c]
stable/6.12: [850810c12686f80cdf7530f4f21e0157d904f739]
stable/6.18: [84727facd8506140cd04f2b0a8b1c4ddeac41cea]
stable/6.6: [df2787819bd137111b56b8631dd581b0cce7144d]
stable/7.2: [2e5a413cc2a489c9427ecd3d73ad764bfb0c7103]

CVE-2026-98838: vt: skip screen update for DEC alignment test on
backgroup consoles

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98838

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0928ed9bd7946baee911efa401088697836e3b1e]
stable/6.12: [985c000b046ca4ee11ee34ef85db500c569ef6e8]
stable/6.18: [ad06f7312d3f615dd466483ce81a9b9619166686]
stable/6.6: [2fc4e71aefab57c80ccc9775aad2af503fc90810]
stable/7.2: [0ee53081425a1a31ce15089012cd96b8353eb44e]

CVE-2026-98839: vt: selection: Fix unsigned underflow and
slab-out-of-bounds read in paste_selection()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98839

Introduced by commit e8c75a3 ("vt: selection, push sel_lock up") in v5.6-rc5.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [39495ef5d6f8019e62d65807f217a7ca8232727a]
stable/6.18: [037d7e3ca5c593092f4b0d471eb869a85cbddde0]
stable/7.2: [619c6d7dd76fff15a9714fbf02ce299b737f01a2]

CVE-2026-98840: vc_screen: reload vc pointer before if (ret) in
vcs_write() to avoid UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98840

Introduced by commit a287620 ("vc_screen: fix null-ptr-deref in
vcs_notifier() during concurrent vcs_write") in v7.2-rc1.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [226bd5603371cd9f6642cbb9e9a677f445de3530]
stable/6.12: [1485a3dd97ab1af2605243cabe6b604546d46dd1]
stable/6.18: [233a2e190b12884d186027d0b86d43a48799b69c]
stable/6.6: [c073d01f6f5367c3a4f07efd507274ed0d03acd0]
stable/7.2: [9dfcadc5e003fb250dd471db90144bd5366140e9]

CVE-2026-98841: virt: vmgenid: set driver_data before registering
notification handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98841

Introduced by commit 7b1bcd6 ("virt: vmgenid: add support for
devicetree bindings") in v6.10-rc1.
Introduced by commit e076067 ("virt: vmgenid: change implementation to
use a platform driver") in v6.10-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f8139c6145cf17d690d6c414d43b4c0bef632fb]
stable/6.12: [538fe5efaa9704ad820ba34b4f9df135ca873d79]
stable/6.18: [7a1e8daeaa466c6aaffa223e1afe9cfeece0dd47]
stable/7.2: [8f42954ad8bf9bdbf574f2c437ad30cb2601f401]

CVE-2026-98842: module: fix lost error code from codetag_load_module()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98842

Introduced by commit 044d2ae ("alloc_tag: handle module codetag load
errors as module load failures") in v6.16-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c79cf15eb35a4c703bf18f8c33c47e80dd660f8e]
stable/6.18: [258310d59a82ea4854bfd9138682bbaac1153b19]
stable/7.2: [bfc721eef5c13704efe6864c7da2ad4b0d75f60a]

CVE-2026-98843: netfs: zero gaps in read-gaps folio to avoid writing
back stale data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98843

Introduced by commit ee4cdf7 ("netfs: Speed up buffered reading") in v6.12-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8db55c5cd831a786a1a2a2d391aa80354535a353]
stable/6.18: [512eaf01ffabf4258e945016b50df5aed940b705]
stable/7.2: [2a62fe628a877c249c8286b157ee99d82840d9dc]

CVE-2026-98844: netfs: clear post-EOF pagecache when extending a file via write

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98844

Introduced by commit 938e13a ("netfs: Implement buffered write API")
in v6.8-rc1.
Introduced by commit 153a996 ("netfs: Implement unbuffered/DIO write
support") in v6.8-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69bf14300b50631e7c2271289d347bbd1b19a06c]
stable/6.12: [f8f7d86b3537e885ee620898a38b749fba8a8456]
stable/6.18: [98f6a4589e0f5f6cf819b8dd45605efc481c06ce]
stable/7.2: [a7036a73671fc83d299bc770710fe996d9fef9ca]

CVE-2026-98845: tpm: Disable TPM on null key name mismatch

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98845

Introduced by commit cc7d859 ("tpm: Rollback tpm2_load_null()") in v6.12-rc6.
Introduced by commit 423893f ("tpm: Disable TPM on
tpm2_create_primary() failure") in v6.12.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [015fb29a748342a186f37b602ac70017098c8251]
stable/6.12: [a03d0c64cd827a622578623a78defd66b6593b82]
stable/6.18: [96c46c75b0d470b4204f9fe1bdb075cd2ebaebfa]
stable/7.2: [f6599d8830fe7ddab7334cc17846fd9ac9a7fa50]

CVE-2026-98846: sctp: check RCV_SHUTDOWN after the sendmsg connect wait

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98846

Introduced by commit 668c9be ("sctp: implement assign_number for
sctp_stream_interleave") in v4.16-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f1da630d13de0370e2f6361f961f1c8b384af1c]
stable/6.12: [e8f972b1759d26bbefe4c524caae1ed7c8a593bd]
stable/6.18: [e701345d886e831fb593a0870d69c8c5de6fc938]
stable/6.6: [1bef1944ef15a40797305bf916827b04df6307ca]
stable/7.2: [222c41e0f50f1d5028be9baf0e1dcfc0bfa7f669]

CVE-2026-98847: rtc: spear: initialize IRQ state before requesting alarm IRQ

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98847

Introduced by commit 0942a71 ("rtc: add support for spear rtc") in v3.0-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [055ef5ce9f67a6a3a1363fa663007f8196cc0fb8]
stable/6.12: [c02aa67ea34a826c2cb1aa65d77cf32fafb7eec3]
stable/6.18: [e0cabda9b6f4dd276c55c40bdbb251e8507ae60e]
stable/6.6: [aeda50d645bbb55241be840602e338b3a16c24ca]
stable/7.2: [cb6d6a7fbff0414b9eed505d17687b4b7e38fee8]

CVE-2026-98848: rtc: ac100: Assign .num before accessing .hws

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98848

Introduced by commit f316cdf ("clk: Annotate struct
clk_hw_onecell_data with __counted_by") in v6.6-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a4117eee82dd85f11bf898bf66026764011eeb6]
stable/6.12: [6bb55381daf1a1bed0657189a1396e7467712525]
stable/6.18: [160619b38707241e22569f9c983a4b3d0890996a]
stable/6.6: [e77c5fc1f39fdb06ecd1f55b101eea1e1db2ffef]
stable/7.2: [ad1bf77039cba83373bf1eff3784655e3e3ed2ab]

CVE-2026-98849: pfcp: fix socket lifetime on netdevice registration failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98849

Introduced by commit 76c8764 ("pfcp: add PFCP module") in v6.10-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f17d2e3dd9cda3ee6d94033d5e5489af168920d]
stable/6.12: [dcb8f6a79c3360a440c399d85df465a6e59351f1]
stable/6.18: [4b8ce1686dea1a10805a0807bf492409b0300ee1]
stable/7.2: [2cee3603ec1d9b5ec7f2121ea3efe9488e906f46]

CVE-2026-98850: net/packet: prevent TX_RING byte count overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98850

Introduced by commit 69e3c75 ("net: TX_RING and packet mmap") in v2.6.31-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2cf81fc9505b148b1b70068303ea6ea4b1212403]
stable/6.12: [be12b221c0301111eeb023be04add3c6ad7c21fe]
stable/6.18: [69ca64bbb528898916f309552053c32a04a36ebc]
stable/6.6: [ae169d318d5d23bac76ece90a7e2b5cb760ed043]
stable/7.2: [9fd63d284e251332f4874ef9023cde472f315f86]

CVE-2026-98851: netfilter: nft_flow_offload: drop flowtable reference
on init error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98851

Introduced by commit a3c90f7 ("netfilter: nf_tables: flow offload
expression") in v4.16-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [747928b5d4ff8c8de55138a54c13980e4bb88578]
stable/6.12: [64ac0cb574c740bf723affb79b646eeba920db6b]
stable/6.18: [c5f91098edee98c015f78488460a0609e62582a5]
stable/6.6: [1d27214fd9a4d2c0c6d998fc9d4fb61448a3438e]
stable/7.2: [4cd378423a33194a773c267fc58606d28fce95cf]

CVE-2026-98852: net: extend IPv6 exthdr detection of tunneled packets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98852

Introduced by commit c4336a0 ("net: correctly handle tunneled traffic
on IPV6_CSUM GSO fallback") in v7.0-rc6.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [5f0764cb1c81a9712bce605d38efe6d844a70b29]
stable/6.12: [44ba9dc568c878b699d05e7cf699572dc9df4b59]
stable/6.18: [aa480f05aed7a9eee87d4a6fc90647fe9679c670]
stable/6.6: [fdbd83c2d929ec968b37d2f75149a79440e328ff]
stable/7.2: [cabacdf98e09eb74599c4d97d7bd7fd659598fb7]

CVE-2026-98853: net: gso: limit recursive IP-in-IP segmentation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98853

Introduced by commit 3347c96 ("ipv4: gso: make inet_gso_segment()
stackable") in v3.13-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [006c8b834aed8b02bd8fb9fb05e9e7ead37d1763]
stable/7.2: [c949646c900e879afce47df1b607fa320eb63bf2]

CVE-2026-98854: of/overlay: only treat a positive changeset id as registered

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98854

Introduced by commit 61b4de4 ("of: overlay: minor restructuring") in v4.15-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44081d708b5b885487bac792db78324b7b4c267d]
stable/6.12: [c08a54df9d33dcd6ff089adc9434b2c008af3a39]
stable/6.18: [0d1525fdcd3355672b7485d61e55df6824ab5ad1]
stable/6.6: [cc688475c56d34a2b584141f9544cbe23360080d]
stable/7.2: [c875407c34dadaef0599834ad9c815f4c9f50d15]

CVE-2026-98855: of/overlay: put property on deadprops only after
changeset add succeeds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98855

Introduced by commit f962788 ("of: overlay: set node fields from
properties when add new overlay node") in v5.0-rc1.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [814f2da6995772c07a7c9c2cc6028b6e3f3ecc9c]
stable/6.12: [d5151496a0a2b19c9c0c7b0ebf86b3de55a8fa3a]
stable/6.18: [7dc6a769153c0457077a0da4888a00f61e66de15]
stable/6.6: [936f1ffcb87a1c50938a21176a6463af162cf4b5]
stable/7.2: [5857035a3b53a4e7b5a0d5a740189901ece0b079]

CVE-2026-98856: kprobes: Skip disarmed probes when checking optkprobe overlap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98856

Introduced by commit afd6625 ("kprobes: Introduce kprobes jump
optimization") in v2.6.34-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a39c732a22ec4a369af9e19fbe3d666ec83eec4]
stable/6.12: [985a568171e7bdba6dcde3420d0e5bb515813457]
stable/6.18: [6745fa65f4115045431c0c15610e876855a04625]
stable/6.6: [3f968dcdf018861129f97910fa7bd680d939a9b0]
stable/7.2: [526fac219e8b7d3369b43026bd0a1df51b811cd4]

CVE-2026-98857: ipvs: bound LBLCR and LBLC cache growth

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98857

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a3c3de660f96865f303fd25f1285f2ffbfd521d]
stable/6.12: [31028d7b970962fbeda1e9131405c76551094300]
stable/6.18: [6316d17324bd4ca400c26adb7b656c6e3447c209]
stable/6.6: [bc9ff8e64771cc32a216953fe615386f46ac1eaa]
stable/7.2: [16c83c047ecfaf226ad81d45d77fa11a3184d0e4]

CVE-2026-98858: io_uring: fix task_work add use-after-free with SQPOLL

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98858

Introduced by commit af5d68f ("io_uring/sqpoll: manage task_work
privately") in v6.9-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a92193c91e8839fe5fc209616ea95465ae4b919d]
stable/6.12: [42b3332efacfd2140be4cd0dedad4fb96b8ae90e]
stable/6.18: [891bd8335a0de3bb15c3b797ce3026bbb0dbef6c]
stable/7.2: [395b25968fe854d4efaa19a8e9b7a5b6d1b3eea3]

CVE-2026-98859: HID: multitouch: stop the release timer from being
rearmed on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98859

Introduced by commit 4f4001b ("HID: multitouch: fix rare Win 8 cases
when the touch up event gets missing") in v4.13-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5acb2dace582f061aab5e14c399ac9480315f44b]
stable/6.12: [1f1bd9a3117f082eb891c0986c4f0e04cd974c9a]
stable/6.18: [0c19a6c1d25fd5ed66d1f80dc6f6e56cc1f0a787]
stable/6.6: [3776f34fbce990af45978f1628d2e1adc0d67d0f]
stable/7.2: [a0125ca86e405b8a704e96157a6c10ca51087652]

CVE-2026-98860: HID: bpf: cast size to ssize_t when checking hid_bpf_hw_request

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98860

Introduced by commit 2b658c1 ("HID: bpf: prevent buffer overflow in
hid_hw_request") in v7.0-rc5.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [3afefbfe55c2a8a0c4bdf6f4cc1f773da120027c]
stable/6.12: [8b85ef0f561039e249c3f883c5280a1449c6dbee]
stable/6.18: [97be6396817bd3b11d06239010d27902940bfaa9]
stable/7.2: [f9f808227554b2c116fd07dd2328ecd74ea3f411]

CVE-2026-98861: fprobe: Use guard(rcu_sched_notrace) and check rcu_is_watching()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98861

Introduced by commit 657b594 ("fprobe: Fix unregister_fprobe() to wait
for RCU grace period") in v7.1-rc4.
Fixed in v7.3-rc6.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [e0a6249190402a28f1e2925a81acf573157d55ef]
stable/6.18: [a85d0f00671b4d4527317c10ba018680f7d8d673]
stable/7.2: [dd4a0d4993633b45470abf6da4ea0ca563402245]

CVE-2026-98862: audit: fix exe mark UAF in kill_rules()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98862

Introduced by commit 34d99af ("audit: implement audit by executable")
in v4.3-rc1.
Fixed in v7.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa650d87a498844060eecb1d336f4d46f4d1b0b3]
stable/6.12: [304960900991157e6883bdf0b39782b690545ee8]
stable/6.18: [88633025f20ba9c32ccdb3efc86eafdf98cb825c]
stable/6.6: [9aee3caeff4dd4126d84f67607b95cec8719b867]
stable/7.2: [f2cc5462b78559c7628a9f8ac9a9592e7783183a]

CVE-2026-98863: KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting
said pages fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98863

Introduced by commit 671ddc7 ("KVM: nVMX: Don't leak L1 MMIO regions
to L2") in v5.4-rc5.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10180a277549339020b08000206092c07e0bff5a]
stable/6.18: [525694a6021ec6c8f7ce1f38acdf2dd77698fec1]
stable/7.2: [942192dbcd3a06695ef6b31cf10a41a21cf014d8]

CVE-2026-98864: sched_ext: Wait for SCX_OPSS_DISPATCHING before
reenqueueing a task

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98864

Introduced by commit ebf1ccf ("sched_ext: Fix ops.dequeue()
semantics") in v7.1-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7de9a6fb44eae4f05e68c805d58b9c618815adfa]
stable/7.2: [43457bf6550044c40bd6d3fcdf9ea66f5a55d139]

CVE-2026-98865: sched_ext: Don't run ops.dequeue() with a DSQ lock held

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98865

Introduced by commit ebf1ccf ("sched_ext: Fix ops.dequeue()
semantics") in v7.1-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb86607ada73185f321baa7f9d94a08a3a40bbf5]
stable/7.2: [fe499ae9da46e297f578d4346c4c8e338c3118db]

CVE-2026-98866: sched/cache: Introduce task_struct->sched_cache_grp to fix UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98866

Introduced by commit df0d984 ("sched/cache: Introduce infrastructure
for cache-aware load balancing") in v7.2-rc1.
Fixed in v7.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b636fef85bda7d1bab9c0a45067ab1508d79d946]
stable/7.2: [9436130e6da72af63289a4acb3aa0c1df07a3928]

CVE-2026-98867: dm-pcache: bound the logical key offset from persistent memory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98867

Introduced by commit 1d57628 ("dm-pcache: add persistent cache target
in device-mapper") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97fc4b53dbe4a983fdf093243067fa6a64562307]
stable/6.18: [3d5a87cb909c1f375f08065b20123fa5db5958d8]
stable/7.2: [10449703200076980704894c3d68d6796182371b]

CVE-2026-98868: dm-pcache: reject a kset that overruns its segment

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98868

Introduced by commit 1d57628 ("dm-pcache: add persistent cache target
in device-mapper") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ac1f10f987a2ffae4aecf0e2ceca8f552b665cb]
stable/6.18: [01a700e9278da5706c865b9ca3ae70fdb7b4531d]
stable/7.2: [96e2863b1f81ea61b8d8d5d5a45d3b4c018f8e10]

CVE-2023-7356: Bluetooth: ISO: Copy BASE if service data matches
EIR_BAA_SERVICE_UUID

Announce: https://www.cve.org/CVERecord?id=CVE-2023-7356

Introduced commit is not determined.Fixed in v6.7-rc1.
Affected file was added by ccf74f2 ("Bluetooth: Add BTPROTO_ISO socket
type") in v6.0-rc1.

Fixed status
mainline: [f4da3ee15de9944482382181329bb6d7335ca003]
stable/6.1: [ba25efe15e8fd909884e113a86c6ccd07d88256e]
stable/6.6: [927ef409f713929dea2b9a5ed5bb65e712be0050]

CVE-2026-98869: bpf: Infer zext_dst based on static register liveness analysis

Announce: https://www.cve.org/CVERecord?id=CVE-2026-98869

Introduced by commit 107e169 ("bpf: disable and remove registers chain
based liveness") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ce090afbf725e25fff29caacce1eaf8459b1117]


* Updated CVEs

CVE-2025-38204: jfs: fix array-index-out-of-bounds read in add_missing_indices

stable/6.6 and stable/6.12 were fixed.

Fixed status
stable/6.12: [2ec34dc7094b14149ce091c77aff43a45d255518]
stable/6.6: [c8733634978086b41255695d993cec3017a23a27]

CVE-2025-40158: ipv6: use RCU in ip6_output()

stable/6.6 and stable/6.12 were fixed.

Fixed status
stable/6.12: [92803b826e40e49a5e8a6e208f4b4574e9d19426]
stable/6.6: [423895685f367b5a0a956bd14b02df0192bded4c]

CVE-2025-71303: accel/amdxdna: Fix race condition when checking rpm_on

stable/6.18 was fixed.

Fixed status
stable/6.18: [a82142af837f67a3f0a257a6dc355448ace58926]

CVE-2025-71308: accel/amdxdna: Fix potential NULL pointer dereference
in context cleanup

stable/6.18 was fixed.

Fixed status
stable/6.18: [b569ff8a1bc1bcd4fdc6fd334604a654f61237a1]

CVE-2025-71313: PCI: endpoint: Add missing NULL check for alloc_workqueue()

stable/6.12, stable/6.6, and stable/6.18 were fixed.

Fixed status
stable/6.12: [829ccfb22950c430f2bf5b40465510c210afb4d5]
stable/6.18: [2f62f8be57882c26f8bede0cab293d013964208f]
stable/6.6: [11e78304b0113d3a122dc2c37426adc34c809645]

CVE-2026-23328: accel/amdxdna: Fix NULL pointer dereference of mgmt_chann

stable/6.18 was fixed.

Fixed status
stable/6.18: [6b3546e3a8c664fb8b97f587fd268dc6e413d79b]

CVE-2026-23341: accel/amdxdna: Fix crash when destroying a suspended
hardware context

stable/6.18 was fixed.

Fixed status
stable/6.18: [2d2c32b1b9e32f25214f0cbc818c4d55f7da1d0e]

CVE-2026-23374: blktrace: fix __this_cpu_read/write in preemptible context

stable/6.18 was fixed.

Fixed status
stable/6.18: [6e5c3ddf17a2cb1722301bbbd15655fcc20ed1ce]

CVE-2026-31501: net: ti: icssg-prueth: fix use-after-free of CPPI
descriptor in RX path

stable/6.18 was fixed.

Fixed status
stable/6.18: [c516c2e06fe580b8d38de60cd407072a5de81506]

CVE-2026-31573: media: verisilicon: Fix kernel panic due to __initconst misuse

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [5d177ff5eb235de9cc0b8e877466f5a3af6f573e]
stable/6.18: [07861e84b766c6db8014bc34138f3be4a62aad2a]

CVE-2026-31771: Bluetooth: hci_event: move wake reason storage into
validated event handlers

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [ac7889b0fe441e4ef892c40b1d002e91f93fa4ae]
stable/6.18: [dbc8b8d33c9e19e17e8b8b1361bbb46e2983f5f2]
stable/6.6: [1e4b738dd0d0f7b237686167706badad9d30649c]

CVE-2026-31777: ALSA: ctxfi: Check the error for index mapping

stable/6.18 was fixed.

Fixed status
stable/6.18: [971854e7b6ddda78669d3d0cf6566c7b8aca1fdb]

CVE-2026-43022: Bluetooth: hci_sync: hci_cmd_sync_queue_once() return
-EEXIST if exists

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [799e2e5fbf3f14874b5c6cc289a0dd68b2ca1979]
stable/6.18: [5cfa4f537a056c91ac6c09bc3ab58a4455217df7]
stable/6.6: [dfee8da127bafa46530b72347bce3ccae736296d]

CVE-2026-43045: mshv: Fix error handling in mshv_region_pin

stable/6.18 was fixed.

Fixed status
stable/6.18: [d14847cb7f65d419e43451d416a1f50c09a5f3be]

CVE-2026-43115: srcu: Use irq_work to start GP in tiny SRCU

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [2127e6b79d9d579ea538a350d1bbe859e39814d5]
stable/6.18: [28768bc7ea0b13f558a70f63cc3cfcd32d55d488]
stable/6.6: [20b98d9ffb09763048a7c84b47403eb0f177272c]

CVE-2026-43191: drm/amd/display: Adjust PHY FSM transition to
TX_EN-to-PLL_ON for TMDS on DCN35

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [be43c36ac13d3a158791566c9fe60511022b7a15]
stable/6.18: [02b033e18e08a1d0b53cf540196688c82af60a2f]

CVE-2026-43204: ASoC: qcom: q6asm: drop DSP responses for closed data streams

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [c0b69245263ffa3db6f1be6e068528578fde635b]
stable/6.18: [3a409a64b2d61430c63cbb15d51681f13b8b0acd]
stable/6.6: [414396c42ef20d2d0c9213adaf4dfa59490ca077]

CVE-2026-43228: hfs: Replace BUG_ON with error handling for CNID count checks

stable/6.18 was fixed.

Fixed status
stable/6.18: [559f856b109c45844816a1693e259f93d3556c61]

CVE-2026-43299: btrfs: do not ASSERT() when the fs flips RO inside
btrfs_repair_io_failure()

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [da3f596073de1c3cbc99941f01296968a85c8c76]
stable/6.18: [81e1ae665004b99a10686473d99f0a7cb6335f38]
stable/6.6: [a35b38cb4b0dd08d7cc0bd4e400208c7aeba8a72]

CVE-2026-43308: btrfs: don't BUG() on unexpected delayed ref type in
run_one_delayed_ref()

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [a5ac87aabdedd31e832b40466605e83f428136aa]
stable/6.18: [6ad4caadc6343c3d7987bf3211f15d66135c4c42]
stable/6.6: [0e77f1c8ebf5b1f858b5ac613baceb79919d6d3f]

CVE-2026-43310: media: verisilicon: Avoid G2 bus error while decoding
H.264 and HEVC

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [f2efc1e8ab65bdb9b892af132887323e4df92f02]
stable/6.18: [5133ef7c893c2c3aee7dd12503dc480de9dbfbb5]
stable/6.6: [f988fbf0536b42f6a05ccc1ac709d60236ec1aa6]

CVE-2026-43311: soc/tegra: pmc: Fix unsafe generic_handle_irq() call

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [5330afc068e90c538dd25aa8f82b3735bdb6d461]
stable/6.18: [57a79c5df057deb7c1d0ebc066698c795092530f]

CVE-2026-43414: scsi: qla2xxx: Completely fix fcport double free

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [7172f41786dc08144da4627483e405de57bf8d2c]
stable/6.18: [4097a2afe8acc6038b71aab825430f1403decf20]
stable/6.6: [baabbd29191514391ca81594e43261bd17c6795a]

CVE-2026-43443: ASoC: amd: acp-mach-common: Add missing error check
for clock acquisition

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [53682a55cac6f159311c63d04f3d7ba64a8a455a]
stable/6.18: [e0e31a7ed1191c12a28763bb70c4c7f5adadc79d]
stable/6.6: [a71ce398347fed9422dbd5c6458f7f8348012c64]

CVE-2026-45961: gfs2: fix memory leaks in gfs2_fill_super error path

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [d049ba2c1723110f82227eaf521427980811169b]
stable/6.18: [4456be93464a599eac0eb2afa63b5d662e1599d8]
stable/6.6: [4db5e4c8f1103b21005ab9e7fe9a5d2554438b74]

CVE-2026-45991: udf: fix partition descriptor append bookkeeping

stable/6.18 was fixed.

Fixed status
stable/6.18: [73df74544b55241dca5dd788523e6f5f10bd2b9b]

CVE-2026-46032: KVM: nSVM: Triple fault if restore host CR3 fails on
nested #VMEXIT

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [af79992ecdb6817970d757fb5d853b8d9b55a0d6]
stable/6.18: [b0eb0a8959ac2b808eb11548d002fe1f9b5650cc]
stable/6.6: [2e661773890e6ba6b16064fad961da3dd311be43]

CVE-2026-46210: media: iris: fix use-after-free of fmt_src during MBPF check

stable/6.18 was fixed.

Fixed status
stable/6.18: [96889fcdb0988108a19a29b0467717a503651a73]

CVE-2026-46245: drm/amd/display: Fix dc_link NULL handling in HPD init

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [0965f1e775130e325e74152d867d2e8ce865fa05]
stable/6.18: [1d15503e454bf117a0d0078332d48df86a41c828]
stable/6.6: [d772e8570f19ac05fd9b11c8af86ada98f35f0c8]

CVE-2026-46311: drm/amdgpu/userq: fix access to stale wptr mapping

stable/6.18 was fixed.

Fixed status
stable/6.18: [2da62dbb4169e758c0b1a9378b39a373bf4fb111]

CVE-2026-46330: Revert "net/smc: Introduce TCP ULP support"

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [dc824ffc28e5c9d0020b6bee2651b4aceed5b2bf]
stable/6.18: [dc24e03be0e4bb2aad1a9b272c4f86de3b11969a]
stable/6.6: [74d33525db50d9d95156c79cc874752654e66e70]

CVE-2026-52949: drm/ttm: Fix ttm_bo_shrink() infinite LRU walk on backup failure

stable/6.18 was fixed.

Fixed status
stable/6.18: [d0ce7b07dafe43d78150f90894027746576d7cb7]

CVE-2026-52956: libceph: Fix potential out-of-bounds access in
__ceph_x_decrypt()

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [ebc7eddf6225b87e3aae720875f9dd40cb6b1cef]
stable/6.18: [5df268406ef38d0f92547959296577c7077dacdc]
stable/6.6: [759053333a40c6997c2917dcd6160bfe40d2b42e]

CVE-2026-52960: ceph: put folios not suitable for writeback

stable/6.18 was fixed.

Fixed status
stable/6.18: [349499a65b6b5fb6f66ba3673598ab558f48c544]

CVE-2026-52965: drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on
swapout failure

stable/6.18 was fixed.

Fixed status
stable/6.18: [060f8f3020516d71bc4d6159d4d0beef85606a74]

CVE-2026-53007: ice: fix potential NULL pointer deref in error path of
ice_set_ringparam()

stable/6.18 was fixed.

Fixed status
stable/6.18: [c789649d4334a3767210071311d58bc8e74bdec1]

CVE-2026-53008: ice: fix race condition in TX timestamp ring cleanup

stable/6.18 was fixed.

Fixed status
stable/6.18: [e98cea6d5562f546482fab8ad571e95e3fff1800]

CVE-2026-53017: f2fs: fix data loss caused by incorrect use of nat_entry flag

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [9fd3bcb54a6afea5fa8a828d010561143560b7c5]
stable/6.18: [cb06a07d835ba1ea250785a796243bb483e65816]
stable/6.6: [0645fa4d48e9b77d93f8b7a1c1fea58a97c2f8b0]

CVE-2026-53025: greybus: raw: fix use-after-free on cdev close

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [3abf97a03f4abce1dc3639eea2fcd4bd747b3308]
stable/6.18: [e72ffe59e48a74a8d9220f5ca1d03f2194d882f0]
stable/6.6: [e4d07fd4e30024a4a15094ef2c404197667c857e]

CVE-2026-53108: powerpc/64s: Fix unmap race with PMD migration entries

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [5c8dd49f4a857aa40c4a8694930509d159feae24]
stable/6.18: [09207dc57ab4cb8967e6cad55a37e15ff8523d41]
stable/6.6: [6f571bf37da84ab822bf22341d48655312aaee20]

CVE-2026-53124: ublk: reset per-IO canceled flag on each fetch

stable/6.18 was fixed.

Fixed status
stable/6.18: [de05e37d02f3f33ebca4967164e54f5fea809d86]

CVE-2026-53222: ptp: ocp: fix resource freeing order

stable/6.18 was fixed.

Fixed status
stable/6.18: [daacc9d1430b63f6bee6e5646def5d6414d35c4e]

CVE-2026-53257: wifi: cfg80211: enforce HE/EHT cap/oper consistency

stable/6.18 was fixed.

Fixed status
stable/6.18: [afe815a67ec8f2fd03c261fb64f5cde7eb05c17a]

CVE-2026-53285: drm/amd/display: Wrap DCN32 phantom-plane allocation
in DC_RUN_WITH_PREEMPTION_ENABLED

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [19e82047cb68bcde55791ee20178acd431609b8d]
stable/6.18: [a8c1480bb066cf0f6e79129b7292e1c99ff68b9b]

CVE-2026-53292: net: phonet: do not BUG_ON() in pn_socket_autobind()
on failed bind

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [363c7fcac553dc2aa12fc90c6e5e6eba87500269]
stable/6.18: [5459933a799aaf642cbeb35fdf7e78c59bf2fb9b]
stable/6.6: [4255c8f756b78d07800baf3320bdbdc130c54193]

CVE-2026-53308: power: supply: max77705: Free allocated workqueue and
fix removal order

stable/6.18 was fixed.

Fixed status
stable/6.18: [4338663dfd21b9c6b012185e5c898769acb60692]

CVE-2026-53401: fbdev: omap2: fix use-after-free in omapfb_mmap

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [986d5fafb73b8b866651399934b66d690f49135a]
stable/6.18: [8363c219d88e78daaee5665117a0380442989338]
stable/6.6: [5e10b1747547c3815e90d28166e92144835e065f]

CVE-2026-63811: f2fs: read COW data with the original inode during atomic write

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [655d55c5740d37ffdf6233ff5fe21cea879407f1]
stable/6.18: [7e4ab3907f44dc243d026048d7f5d477dae9267b]
stable/6.6: [bcc9df992f3cbc43f2ecfe0b22e428e50f326e72]

CVE-2026-63858: netfilter: nf_tables: add hook transactions for device deletions

stable/6.18 was fixed.

Fixed status
stable/6.18: [768daa9f4276be4007e88dea61a378c8582ba008]

CVE-2026-63879: drm/amdgpu: fix amdgpu_hmm_range_get_pages

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [93a9f121de6383f20290840d025ee28fda5f53b5]
stable/6.18: [fa34d3e14cb763b50702e8a0f7d4cfd877a73ab9]
stable/6.6: [e35cf322897dd4921248d11311a89c865b534c14]

CVE-2026-63941: KVM: arm64: Correctly cap ZCR_EL2 provided by a guest hypervisor

stable/6.18 was fixed.

Fixed status
stable/6.18: [2090c1a2368339eab0e14dcde12fdf6a5ea6359d]

CVE-2026-63983: net/sched: fix packet loop on netem when duplicate is on

stable/6.18 was fixed.

Fixed status
stable/6.18: [4ec3a8ca97394f17e73a4d8d4c79c1c78b322772]

CVE-2026-64013: ACPI: button: Fix ACPI GPE handler leak during removal

stable/6.18 was fixed.

Fixed status
stable/6.18: [c85f325d9ec3116b0d4ee9d5b76c26aea0ad5ce0]

CVE-2026-64019: nvme-pci: fix dma mapping leak on data setup error

stable/6.18 was fixed.

Fixed status
stable/6.18: [fba32257979dda14b0d8ed7402490ae0be44972a]

CVE-2026-64020: nvme-pci: fix dma_vecs leak on p2p memory

stable/6.18 was fixed.

Fixed status
stable/6.18: [b9390aa62fdcabdaac2d09545be05901f6cecaf5]

CVE-2026-64040: cachefiles: Fix error return when vfs_mkdir() fails

stable/6.18 was fixed.

Fixed status
stable/6.18: [86f4c1586418d50203ee8d76cba5d7b148719a32]

CVE-2026-64057: afs: Fix the locking used by afs_get_link()

stable/6.18 was fixed.

Fixed status
stable/6.18: [93531bca46707c6c28c4f4eb26c101fa36ccb8cb]

CVE-2026-64067: netfs: Fix missing barriers when accessing
stream->subrequests locklessly

stable/6.18 was fixed.

Fixed status
stable/6.18: [f048f297d93fdb19d72d01d22f04c419d8b16602]

CVE-2026-64079: netfilter: x_tables: allocate hook ops while under mutex

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [693bffd742dd4fa9a0076ed120545af3679c588b]
stable/6.18: [f669571a2bf5067f50091cc598df9613663ee226]
stable/6.6: [5ea15e78232253e657d352e625fb4913e2f57e63]

CVE-2026-64117: wifi: mac80211: capture fast-RX rate before mesh reuses skb->cb

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [0cd37e746e98ab0baa6d8b812955220775b080d6]
stable/6.18: [a2650f8461cd8ba287fee2992b36abe733c2bd5e]
stable/6.6: [5fe97797412aa8bc0184f78379fafb594bcb7f66]

CVE-2026-64123: net: hsr: defer node table free until after RCU readers

stable/6.18 was fixed.

Fixed status
stable/6.18: [48d09dea506de667eb55f939bf98eec721effbdb]

CVE-2026-64146: erofs: fix metabuf leak in inode xattr initialization

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [e4a552e0b6413c1af2e140b5bc14bb849b411b57]
stable/6.18: [fcb23bb31508b62e8a1b32adf6217820e90e29b0]
stable/6.6: [3812cfe6cb0a5988df4fedcdaf9aab677b9cca61]

CVE-2026-64154: drm/msm/adreno: Fix a reference leak in a6xx_gpu_init()

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [bd750e4043bbd9e2ef69de50b11bd6f98c366cc0]
stable/6.18: [b76568c6721840a4ddb65e24e2849db0f8e83461]
stable/6.6: [bdad77438cc2ba006b041eb02adccb0b9f8cffad]

CVE-2026-64159: netfs: Fix zeropoint update where i_size > remote_i_size

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [f706e3889ff75877ecb3abae5ad667dbc990331e]
stable/6.18: [5afc2d9b86bed2e4d9e1ba467790cbc793223f98]

CVE-2026-64281: svcrdma: wake sq waiters when the transport closes

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [bc6acec84f9f777feb9a4ed5df190b57b4eb9c59]
stable/6.18: [35d5dd0c2fd1eb5a75c0774179c51db7b5284a43]

CVE-2026-64283: KVM: guest_memfd: Treat memslot binding offset+size as
unsigned values

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [e4683654881f3303ab286e45df6f91c0675d867c]
stable/6.18: [3f9c0fdefa0431ad7a5528d76b9cdad912500bdf]

CVE-2026-64325: wifi: mt76: mt7921/mt7925: fix NULL dereference in CSA beacon

stable/6.18 was fixed.

Fixed status
stable/6.18: [d16713c06006669c7162dfab1cedf4cb24429311]

CVE-2026-64388: smb/client: fix chown/chgrp with SMB3 POSIX Extensions

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [27ead8c5418af6bfab711079fecb9414d78d4cae]
stable/6.18: [3eaec47518e126e6dcd1a48521d740278073f0ec]
stable/6.6: [6825a45f6b8ef76b0ee32649ec3d6e39ca143a18]

CVE-2026-64400: ksmbd: prevent path traversal bypass by restricting
caseless retry

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [a1c331d98313380c38f616c8b28b890ec8ef9c28]
stable/6.18: [cfb5a56c218888f9d74165dff0c282cd0be97983]
stable/6.6: [eec1dd2586c4016b7555a5d047db2b3756459fb2]

CVE-2026-68105: drm/amdgpu: Fix kernel panic during driver load failure

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [b437e9b88b47fdf6d8d9d02651b8b56b9162de9a]
stable/6.18: [f7e744bac9a720740a60d19319e8e5ed5e5c3c76]

CVE-2026-68242: drm/i915/gt: Fix NULL deref on sched_engine alloc failure

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [7214db3e62fa9f0be7981cba9039bd835a79c070]
stable/6.18: [c174969f6af6c22fc9c51aefcdb7f9183c3a329a]
stable/6.6: [bedeee4612afc15c53f8d3c6da05897506b4ca24]

CVE-2026-68291: idpf: fix max_vport related crash on allocation error
during init

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [993571d207f5f4775b92df89788570468ffb9cdd]
stable/6.18: [08fffd2881e2804d55bc74f178e2843e8832b396]

CVE-2026-68295: LoongArch: BPF: Zero-extend signed ALU32 div/mod results

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [7577cca85f2d4590c9d9423ba72ef54181a713c9]
stable/6.18: [16656c3d734693be3d8a36dbf9d09142b69f3ddc]

CVE-2026-68305: drm/xe/vf: Add drm_dev guards when detaching CCS
read/write buffers

stable/6.18 was fixed.

Fixed status
stable/6.18: [0c07e046e639160a1597830c4c5615ee2a4a5ed5]

CVE-2026-68312: cifs: fix cifsFileInfo leak on kmalloc failure in
deferred close drain paths

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [7af7ec3af091f55d01f0ebe0246d10e37f358311]
stable/6.18: [6089f561e2c31a3ba52836c75c7d2ab50d2eea41]
stable/6.6: [c968b2417f6a15d35ff4b97d534af4a126cb510b]

CVE-2026-68323: tipc: serialize udp bearer replicast list updates

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [3ff143a884a19bfcf3aebd999b02274fe44f46f3]
stable/6.18: [5d3cea7d41dc72073fea6f879815c9b57c3b330d]
stable/6.6: [3ff6b534d20824cddab99c81ea3bd1144e635626]

CVE-2026-68375: bnxt_en: Handle partially initialized auxiliary devices

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [e75f1a5b267e820f5b7900c16d84f12c122218cc]
stable/6.18: [8549ac21ab503fc7a40bfa8e6beb69e6320d9877]

CVE-2026-68382: drm/xe/guc: Hold device ref until queue teardown completes

stable/6.18 was fixed.

Fixed status
stable/6.18: [81f70f130eff985fb678d8b891c960381bc7e900]

CVE-2026-68383: drm/xe/guc: Keep scheduler timeline name alive

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [eac2839585741e6c1b4af261a0b58bca0d6f5436]
stable/6.18: [88c38ff74f8345fcf8852549f94025754019b037]

CVE-2026-68399: bpf: Fix UAF in sock clone early bailouts

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [24139461545e44442df9b80deace26b2eb3e103d]
stable/6.18: [01f8a354497ba739f81b691b3702bc4c46500a4d]
stable/6.6: [f6814814b3bdd6ecb6bc1fc53ba4e827e0185f01]

CVE-2026-68404: wifi: cfg80211: use wiphy work for socket owner autodisconnect

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [4087a9ba4ece70297a4174afaa41c0b700302b65]
stable/6.18: [c2ddd180bbee766cf7359473d623423ea9485d93]
stable/6.6: [c55590e4c69e0fd194df6d20bc35381c201d99e1]

CVE-2026-68436: drm/amd/display: use kvzalloc to allocate struct dc

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [dd8506091e9f1e111d9964f5ec2348d7d5157bf2]
stable/6.18: [c59a693fbd213f8f27942509b48b1a4111fdd40d]

CVE-2026-68441: net/sched: Handle TC_ACT_REDIRECT from qdisc filter chains

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [636658e50b5c6a2c93413a9fa6d9da768dbfdaf2]
stable/6.18: [9cbad9c8125f5fe377c0800ab08f7196eab44456]
stable/6.6: [98ca831065c4d20baf97dc9e232777dc47a2b923]

CVE-2026-68470: wifi: mac80211: validate extension-frame layout before RX

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [7aba69b611007e11b9b93118ff8fe88998c3107f]
stable/6.18: [1c3d9c6bd5b795f3b952b40d574c8e424e14a39b]

CVE-2026-72031: ata: libata-core: Add NOLPM quirk for PNY CS900 1TB SSD

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [eb94157a86cef9a151ccd4bc52faae1853d0fa0c]
stable/6.18: [0a2c89d538fd4fca07c6ebe4fe03cc932f962441]

CVE-2026-72091: accel/amdxdna: reject user command submission without
a command BO

stable/6.18 was fixed.

Fixed status
stable/6.18: [241cf3b7455bebbe492b9df4912b48e3260061d4]

CVE-2026-72329: net/liquidio: drop cached VF pci_dev LUT

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [1cf5c6a80adc31456f3e93b2922a2446fd63e2c4]
stable/6.18: [08ff33dce6f91510bb296a753a232db0ca3fd3d8]
stable/6.6: [e3b20de8d7c06c8f1a0ded1e52be9d282609c3da]

CVE-2026-72331: accel/amdxdna: Fix VMA access race

stable/6.18 was fixed.

Fixed status
stable/6.18: [3dd12422653ad4bbbebe33c49c67dba4c653c804]

CVE-2026-72337: Bluetooth: 6lowpan: avoid untracked enable work

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [9061d0c19e97bb8d0aa235d0a571a5d6d0be7477]
stable/6.18: [31cc289d5b179a37be439043306f518376a58187]
stable/6.6: [333a39f134dd0bc614ef6658e9ccd448080443d1]

CVE-2026-72345: net/mlx5: LAG, Fix off-by-one in single-FDB error rollback

stable/6.18 was fixed.

Fixed status
stable/6.18: [0be672071d6e8c4d3be6a8f796d8e47198763770]

CVE-2026-72370: iomap: release pages on atomic dio size mismatch

stable/6.18 was fixed.

Fixed status
stable/6.18: [177d22d31a4ebf13964a4154035ade385382aced]

CVE-2026-72380: xen/pvcalls: bound backend response req_id before indexing rsp[]

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [ede7a60b046d8b7288651c55198574ed7c259da7]
stable/6.18: [bc8f2d1c6f7cf6e6551c00eb582baf4b52a04794]
stable/6.6: [72e27ef70a20298e60a1de438f3628c515dea895]

CVE-2026-72388: drm/panthor: Always use the IRQ-safe variant when
acquiring the fence lock

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [1804a760422a7d75eb6e1fc0638aaff18d1dde88]
stable/6.18: [9de9e8f279de0c299631f530de66c51642eef50a]

CVE-2026-72404: tipc: fix UAF in cleanup_bearer() due to premature
dst_cache_destroy()

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [6b0e29f7662c237e717f35dad746efe94715d0da]
stable/6.18: [3827ff67f9fbecd1086e33d23693ef6a1a9c6c38]
stable/6.6: [6aeb4ba4fb098199e13723cfd04d9a749741f731]

CVE-2026-72423: bpf: Guard conntrack opts error writes

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [63d95c6bbd6fc0e411404188306a1fea456300b0]
stable/6.18: [453f4f1e90de55b6bc297936031b68bef93f2e28]
stable/6.6: [669bc3b345712112d3f033a1953f5a10b15e7c65]

CVE-2026-72439: md/raid10: fix writes_pending leak on write request failures

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [b6667d925c274910423385042edf18f6788dbceb]
stable/6.18: [c642583adc136d4c70ce3c65c3f43e847d26c776]
stable/6.6: [f076460c5205c9687059e5a3afeed37d2f2ceb6b]

CVE-2026-72440: md/raid1: fix writes_pending and barrier reference
leaks on write failures

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [a846affa813013204d0cce0cfdaeb99e8fcce188]
stable/6.18: [7a450460687919e79b5f8503bdeb13ecf4cca311]
stable/6.6: [921e2baa626d1504bf30295816aaeb90ac8c82f4]

CVE-2026-72454: i3c: mipi-i3c-hci: Fix race in i3c_hci_addr_to_dev()

stable/6.18 was fixed.

Fixed status
stable/6.18: [308d7951ca221e8c8896b563c4e98d28a4400f2e]

CVE-2026-72477: fs/ntfs3: call _ntfs_bad_inode() when failing to rename

stable/6.18 was fixed.

Fixed status
stable/6.18: [580896e33003845de66c75cd61544cf9d9bfbe15]

CVE-2026-72493: net: serialize netif_running() check in enqueue_to_backlog()

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [cbe10ea090ea9d6fa5ff50c9b44f2a86fe56f0b7]
stable/6.18: [b422e3eff0edf0975de4883929adbed28f9d08bc]

CVE-2026-72497: RDMA/bnxt_re: Add a max slot check for SQ

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [d4d1c78b56b6abc0dcb6015faaed2cf4d0f2797b]
stable/6.18: [2106c337905d7445d75818e36920b63f9211c584]

CVE-2026-72499: RDMA/bnxt_re: Free CQ toggle page after firmware teardown

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [8a8d69a01bda1fec9b07b5559be2b6ed45b1e974]
stable/6.18: [33aed3ba04aa56eeeb876935896aa6530c46640e]

CVE-2026-74260: netfilter: nf_dup_netdev: add nf_dev_xmit_recursion*()
helpers and use them

stable/6.18 was fixed.

Fixed status
stable/6.18: [53fb46cf933dc4361c1a72491e247841d0b0fc85]

CVE-2026-74273: cxl/region: Block region delete during region creation

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [ecc86a28dc27509da511bb3f8c309750233e3177]
stable/6.18: [98c7e206af48b4433b2192cc1a538db2acc49876]
stable/6.6: [8efa9fcc1d31b29b31e0ac4efe48624a729796bc]

CVE-2026-74277: iommu/dma-iommu: Fix wrong scatterlist length
assignment in P2PDMA path

stable/6.18 was fixed.

Fixed status
stable/6.18: [6166cb1344f16dd403f2192f4bea6f6654f1ae1e]

CVE-2026-74307: ext4: validate donor file superblock early in EXT4_IOC_MOVE_EXT

stable/6.6 and stable/6.18 were fixed.

Fixed status
stable/6.18: [29e07ec352f0ad06c833a18bf47d82c81f55544f]
stable/6.6: [663f184b51492093d408e518efc95ee13b5b4440]

CVE-2026-74317: ixgbe: do not configure xps for XDP queues

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [706e811380909a709332136001fe31f37575ef53]
stable/6.18: [f488b83a38103e8eea442cd8fa1a10f982bd60af]
stable/6.6: [ec485257ccbc787bcde0271d6f649c9018ffb363]

CVE-2026-74336: wifi: mac80211: bound S1G TIM PVB walk to the TIM element

stable/6.18 was fixed.

Fixed status
stable/6.18: [68cf46755894d495b432e21f9e25637030d8b075]

CVE-2026-74338: bpf: Reject sleepable BPF_LSM_CGROUP programs at load time

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [4b9d8bdeb19e709f9bc3c317d48b0c0add3b2b1d]
stable/6.18: [b4059a1f57eff3e206d44697f64ad81076512760]
stable/6.6: [f0a49d16804d319774388a32d8cdcef319a9e481]

CVE-2026-74350: ocfs2: validate fast symlink target during inode read

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [030d4caae89977b80349df95523dfda1dfb10f73]
stable/6.18: [d94bf50756d7f80bb728ad58246376649e1035b6]
stable/6.6: [dcabbf7da43825e23e5e89adccc1430faee1bce1]

CVE-2026-74367: wifi: ath12k: fix inconsistent arvif state in
vdev_create error paths

stable/6.18 was fixed.

Fixed status
stable/6.18: [c09314b8b4c6290290a8a59c9e0e546231231186]

CVE-2026-74368: wifi: ath12k: fix memory leak in
ath12k_wifi7_dp_rx_h_verify_tkip_mic()

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [779ab501dc8f1148b3f10740a68335741bdc5ffe]
stable/6.18: [55c6f05b667726d2da5fd011d646fb48ce5b6b9c]
stable/6.6: [d960cd5dbcc6a01f49cc304b724f6b18a63a172d]

CVE-2026-74373: md/raid1,raid10: fix bio accounting for split md cloned bios

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [235d16ae715104b981a4fbc9434398e3816773b1]
stable/6.18: [bcf30e14d2bd509c57e93021b46aedc878896e7b]
stable/6.6: [91d0fc000d8cc40fcb4285e6160dd1ce98c56201]

CVE-2026-74374: md/raid1,raid10: fix error-path detection with md_cloned_bio()

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [8719aa0f57955fd641f952d16e02fc6b4934c6e3]
stable/6.18: [029b363c9b690613141338436ac91366b1928af2]
stable/6.6: [80eaeae0e4b1ed2418fd2b9088238651fb51df69]

CVE-2026-74375: md/raid1,raid10: fix deadlock in read error recovery path

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [0889242775340e2c5b69b1590bd71335dd4fdeda]
stable/6.18: [ea2d1d2ebf60b70b602a92261a567d5fc4575eab]
stable/6.6: [923a6f3172a362d6b2ff12386e376e0e47188f78]

CVE-2026-74449: drm/amd/display: Fix divide-by-zero in
calculate_mcache_setting on zero viewport

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [70f5f4ddba0d2d89e77ec13b79cdcfbef33be0d9]
stable/6.18: [23a541c31b45fa813b33269376f6bd53535429a8]

CVE-2026-74466: s390/zcrypt: Close speculative mem read possibility

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [d11a260bd7dfc6f6ccd43e1b930050f24e70cd5f]
stable/6.18: [59adeedebf02aa1c203de1d2b67ec45bfab7a3c6]
stable/6.6: [dd1a334523ba533cba63caf593a7329d8e0e5e6e]

CVE-2026-74527: octeontx2-af: Block VFs from clobbering special CGX PKIND state

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [7e888d7dd11519330ba6c6a28391d55891463a6a]
stable/6.18: [a76243488740a07c81c9adf431685bb7f7c31d8c]
stable/6.6: [1106b26e86ac1e7e4d1f634bcd532c5d44e60620]

CVE-2026-74529: Bluetooth: hci_sync: hold conn in hci_connect_pa_sync() callback

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [40ef39f1d755ff8d54423345c73d187e77854d0b]
stable/6.18: [68ffe4265775ed9e09e18e9a3b388740e25257bf]

CVE-2026-74530: Bluetooth: hci_sync: hold conn in
hci_connect_big_sync() callback

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [117d8bcaf1abc348185e8ab6a4ba9f8f516849a0]
stable/6.18: [ff5625d27415ace5667bf87ebc16c3a0a98db22f]

CVE-2026-74542: netfs: Fix folio_queue ENOMEM in writeback by adding a mempool

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [b343252d6f536203dd0660f676190dcbf6d2ecdc]
stable/6.18: [15ed8a9b7c63e9171f5139a6aaa1ffb61809861f]

CVE-2026-74544: net/sched: cls_u32: validate offshift to prevent
shift-out-of-bounds

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [006a4598da9a6b02e0ddc3ca5042b97224774364]
stable/6.18: [9990cac513e8b191de2ee589051ea7ebf3cee940]
stable/6.6: [724c8edbacf1259988829cb9967f751222121d8a]

CVE-2026-74558: xsk: reclaim invalid Tx descriptors in ZC batch path

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [56036bdc445c468b1defd1780ed2af4a3fc7ddb2]
stable/6.18: [2c0a8cc97a9d970a252f17aa0bbf4588768f7aad]

CVE-2026-74561: nexthop: avoid unlocked f6i_list walk in nh_rt_cache_flush

stable/6.18 was fixed.

Fixed status
stable/6.18: [f97fae992155b11da516a509c855ff9d0868b107]

CVE-2026-74562: nexthop: take nh->lock for f6i_list walks in replace
check and notify

stable/6.18 was fixed.

Fixed status
stable/6.18: [4b296d176580a85ccbc7135ebdf66c42087b23a2]

CVE-2026-74568: KVM: arm64: vgic: Fix race between LPI release and
re-registration

stable/6.18 was fixed.

Fixed status
stable/6.18: [f8e5715a37378ea1a140ee1162fa441e149c5142]

CVE-2026-74571: btrfs: skip global block reserve accounting for rescue mounts

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [3a69fae2371a5ee190d4c4bbe5304a753558c1c6]
stable/6.18: [969a96479add6bd42d7f7241f99f27b31571a953]
stable/6.6: [ca05d9abde2195cec3d07d0d4d65152d8171078f]

CVE-2026-74596: fs,fsverity: remove check for fsverity being enabled
in setattr_prepare()

stable/6.6 and stable/6.12 were fixed.

Fixed status
stable/6.12: [fd4ed50c134fd9f2334b8b29d117f3af5fe250e9]
stable/6.6: [3f3b0898557a93122a7f941e6a89adef2bb29ce4]

CVE-2026-74605: eventfs: Use children field for rcu head and add memory barriers

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [1b95382da85cff3bf0f922ff0275f186abdadfce]
stable/6.18: [2b80707b9e27671e10840d17c6f8f774c4ad9847]
stable/6.6: [25d27d5fa8645ab61018c3efec5c69f49280ca7d]

CVE-2026-74713: vhost_iotlb: bound map allocation in add_range

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [eb70200e34772572ad08e99291b08afea6522111]
stable/6.18: [b57164cdddb46924ff9fa191b727ca097744de88]
stable/6.6: [96da3e1439e7d689eea09fc9b6227fbab5b88ac3]

CVE-2026-74715: bpf: Fix netns reference imbalance in conntrack kfuncs

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [41731d4290400cb898f15f049ae4018d45415e69]
stable/6.18: [4af94462c0ca2187a02a1a6641020ae888c74d5c]
stable/6.6: [fb22bedf0c4f4f05bfa6e4a7ec0fd97bbdff9ce8]

CVE-2026-74716: accel/amdxdna: Fix locally exploitable BUG_ON in
amdxdna_insert_pages()

stable/6.18 was fixed.

Fixed status
stable/6.18: [618fc8dc219c11b8b85f0c8e3f7ff46cc1544339]

CVE-2026-74721: accel/amxdna: Fix page-insertion errors in
amdxdna_insert_pages()

stable/6.18 was fixed.

Fixed status
stable/6.18: [b3d05a335cbd3d89538e9dde1621dccf33ae945a]

CVE-2026-74723: btrfs: lzo: reject inline extents without valid headers

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [fd150d7c8e0ad9d721c011cfd4cc0f3c65bd6834]
stable/6.18: [056876c9db1e969bfcf7d8583c7696cc0dd080df]
stable/6.6: [5d00c9c1c951ae82d498eabbdfff973252a05c50]

CVE-2026-74729: soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [afe2527eae0b51d5e8ddd77293afab3a5a1311a4]
stable/6.18: [868c478abce858135db3eb65548a577e4b6747ac]
stable/6.6: [b87c0d24386ed5106feac12034fe09d893ccb469]

CVE-2026-74733: gpio: pca953x: fix pca953x_irq_bus_sync_unlock regmap lock

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [41255e64eb9dd87b0b8675f4e47a9c67bcef6e39]
stable/6.18: [bf3f37c2d40b51deb79aea910f28999d7c8c6b5a]
stable/6.6: [5d05c4252c09ce10624be2197853c80bf87424e4]

CVE-2026-74745: eth: bnxt: avoid deadlock when canceling IRQ affinity notifier

stable/6.18 was fixed.

Fixed status
stable/6.18: [d10e73572cda4af7487f82f58a7771f18cf61084]

CVE-2026-74747: ipvs: revalidate ihl to prevent out-of-bounds access

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [041b2303c8019394735c1f76c5138657bf660a7d]
stable/6.18: [eb81c8e758f49e04391f77d9470a6232bb5f1c7a]
stable/6.6: [2512289cbf58706fd558e8fccea4e28003a2af54]

CVE-2026-74750: ovpn: defer key slot crypto freeing to workqueue

stable/6.18 was fixed.

Fixed status
stable/6.18: [5cea365559449f2149ab724d33d406e3ec4c00c9]

CVE-2026-74754: scsi: core: pair EH runtime PM get and put

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [0038a2a75a15d163f428c93103c6d02d4d231a7a]
stable/6.18: [fdc93f4a801077efbf1b87570ade8d8f325de62f]
stable/6.6: [1ec5f6aa38ea990af37c49af7a4bb3db00da7f9d]

CVE-2026-80524: optee: ffa: Add NULL check in optee_ffa_lend_protmem

stable/6.18 was fixed.

Fixed status
stable/6.18: [0977a6f23439616701282fc4cb38eca40f36fec6]

CVE-2026-80543: s390/zcrypt: Pad trailing CCA or EP11 message with zeros

stable/6.18 was fixed.

Fixed status
stable/6.18: [44e61f1834831f873af5a4fec5a5e432b929c6a2]

CVE-2026-80544: s390/zcrypt: Improve EP11 CPRB domain handling with
ASN.1 parsing

stable/6.18 was fixed.

Fixed status
stable/6.18: [00a44ff06bcffb68b9cd7e90d2259b7d14b82b18]

CVE-2026-80545: s390/zcrypt: Improve EP11 CPRB length and overflow checks

stable/6.18 was fixed.

Fixed status
stable/6.18: [f463f474773aa49ed1d6087d95d44cea7099fdc7]

CVE-2026-80546: s390/zcrypt: Improve CCA CPRB length and overflow checks

stable/6.18 was fixed.

Fixed status
stable/6.18: [584400144020f40365de3972c4763da520e7280e]

CVE-2026-80631: btrfs: lzo: reject compressed segment that overflows
the compressed input

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [1c48c8c807e49ac4f72819a89035fb8d2d094015]
stable/6.18: [be7fb59512ffc2da5d98214a00117dfe9eccab78]
stable/6.6: [d9b17f9ce67d00e48fab62dcae197612a58f625f]

CVE-2026-80634: netfilter: flowtable: avoid num_encaps underflow on
bridge VLAN untag

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [ee8440bb000fff4ef8acbfc99652851e9ca0a35b]
stable/6.18: [547ea9f567498e4accc89e7816264f15a1a0629f]
stable/6.6: [1b52aeb40c9f04bf50eeb4ea09142139d163e239]

CVE-2026-80655: soc: xilinx: Fix race condition in event registration

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [07ea9081b8fefb99e2f427e0f0602a5e576cb120]
stable/6.18: [e124f7b170337563d78a7a6aa152c897d229bc39]

CVE-2026-80692: Bluetooth: hci_sync: hold conn in
hci_connect_acl/le_sync() callbacks

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [301a4e2e89313dee10f0e8cb084daedbbe4a3dce]
stable/6.18: [a4de6fc95b2f36967fc247ae51cad2171194f7cd]
stable/6.6: [f0a544ef6e38e4063d0ed72ad83d6bf0f4e70805]

CVE-2026-80693: idpf: bound interrupt-vector register fill to the
allocated array

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [a6447b6a9678e701ca4d32789f311067cf528c2d]
stable/6.18: [e299b7d1334ebec4d43a7bb697d10c12df1aaed3]

CVE-2026-80698: dmaengine: idxd: fix double free of wq, engine, and
group structs

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [38208445c41a6164e26748c600f954296991364d]
stable/6.18: [63844dc03960b09b36746eda636c08f1479407ce]
stable/6.6: [84cf00b1376c717e55d704dc259483e822ae1b34]

CVE-2026-80705: drm/amd/display: check if dml21_add_phantom_plane() is
successful

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [ef7d731f1df63d6230e159996c0703aaf5132bac]
stable/6.18: [bea1f73ad69eec36b757adb8e63beb3092f862ee]

CVE-2026-80738: bpf: Check sk_state before sk_protocol in bpf_tcp_*_syncookie

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [b5525e853a2a08a9559adb84b0616025958dc542]
stable/6.18: [22c2169770ad3b3595690e51caac875178cf496d]
stable/6.6: [5702e4c259809c760912c477c4ae34e9217bb4d9]

CVE-2026-80747: drm/amdkfd: Add bounds check for CRAT subtype length

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [77b659fb104eb069ea7a61960699e4d1eea6567a]
stable/6.18: [69164d6bdad5d6657e51436a3f602822f620a46a]
stable/6.6: [fef8c8afcb85dce5ff115f82a148cdf87a9617b9]

CVE-2026-80786: fbdev: Wrap user-invoked calls to fb_set_var() in helper

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [d33589eff3d40439b3c83e8da0d07d20df797d50]
stable/6.18: [ed7e9715849abd0816b8487b0d12ebd05d6e938b]
stable/6.6: [3130e7bf43ecfe3a15bcf90b9698e0764a2d8d08]

CVE-2026-80866: tipc: avoid busy looping in tipc_exit_net()

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [110bb16d37bdba03213156c0df37e7119c190936]
stable/6.18: [7672973957e3e20780afe5937a9fec70b72bc060]
stable/6.6: [99b82c8452887408ea908fdfa5df33c4a5dfa88f]

CVE-2026-80884: ntb: Store original DMA address for future release

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [a4a046f668c7c7d0df9510cc426678563fff1b03]
stable/6.18: [0f035333e19944f8ea7a423681f161eb1b2db21c]
stable/6.6: [2b9ddb7311c79e8af2410abd97765fffd9ddf586]

CVE-2026-89513: RISC-V: KVM: Fix PMU event info array size overflow

stable/6.18 was fixed.

Fixed status
stable/6.18: [ddbd71a3780942918a7d116d666313e5b3304d73]

CVE-2026-89527: svcrdma: Use svc_xprt_put to free listener on create failure

stable/6.6 and stable/6.12 were fixed.

Fixed status
stable/6.12: [ee70d690b5544b736706a9a5796aafb634013f54]
stable/6.6: [2e35ec558b8cece9399a50141ecaeadbdb8768dc]

CVE-2026-89534: svcrdma: Clear sc_cm_id when ADDR_CHANGE replacement fails

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [2a68aeb2de8ad0fef9c50e73a50622a35c6af1a8]
stable/6.18: [65f0f82f20334e76acaf29087a59af7b3b9699ed]

CVE-2026-89537: SUNRPC: Reject short RFC 4121 MIC tokens in
gss_krb5_verify_mic_v2

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [997577c52487181226775db3755079a3ba1d52b9]
stable/6.18: [996dd15f60121bdd7896b4554458f8806d608063]
stable/6.6: [b2e9e10f5a536befcdce64d3e6946dff42fb823e]

CVE-2026-89568: kho: fix size calculation in kho_preserved_memory_reserve()

stable/6.18 was fixed.

Fixed status
stable/6.18: [0692a8fdf0222af130c8ea97426f1c3bf3814905]

CVE-2026-89601: ext2: Fix lost inode updates for IS_SYNC inodes

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [e54de654423bee98d1ba50379b09daf97c7854a6]
stable/6.18: [5481766125041e71662f2e32ee0e91ad5f4d07f4]
stable/6.6: [b879565effd88fc119c2efea3f3868a9997ed9ba]

CVE-2026-89633: smb: client: fix OOB read/write from unvalidated
DataOffset in coalesce_t2()

stable/6.6 and stable/6.12 were fixed.

Fixed status
stable/6.12: [36d01415d881d5326a0dd3384f781cd7e69aff2d]
stable/6.6: [6eb70b78e48b0031bd1a05fe1b58959a48e87739]

CVE-2026-89638: smb: client: clear setuid/setgid bit on write with
cifsacl/modefromsid/posix extensions

stable/6.6 and stable/6.12 were fixed.

Fixed status
stable/6.12: [58b23fc9fb580432470d6c5da3c1e5660dba9fbc]
stable/6.6: [7ceb6f7cb8f8f2b094e0dcdaf75757775d231378]

CVE-2026-89642: cifs: call pagecache_isize_extended() in
cifs_setsize() when extending

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [40c16040783abcc240bd1b453e679ea6ca30e19e]
stable/6.18: [e1f692b6da3e632a25d0b3a99f833bb609bae1a3]
stable/6.6: [5463d96cd2e46064ceefcf861b028745a4f4c373]

CVE-2026-89654: ceph: fix UAF in check_new_map() on session freed during unlock

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [820871e9dbeecd2533c4c5f5d91878ceaf02324c]
stable/6.18: [9646dfee880730aae4b379a4b8ee6c88ac735acd]
stable/6.6: [352a278d5a1965aae3f817ce5d24a67ee42d45d1]

CVE-2026-89705: nfsd: restore rq_status_counter to even on all
nfsd_dispatch() exit paths

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [5773e00cc0f9e34983bd29ba2a607c6b14258e00]
stable/6.18: [df5500ab85df661d9e4439e4c456787181fbd5ff]

CVE-2026-89709: lockd, nfsd: RCU-protect nlmsvc_ops dispatch

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [6e7495972039f212e336e552b58cac9dd54611c3]
stable/6.18: [836ce2b99bcce6d68c58edd04efbc5cd1fd581af]
stable/6.6: [43943532c105ea8fe26039a1347cfda4ac0fcadc]

CVE-2026-89718: zram: fix out-of-bounds access in writeback_store()

stable/6.6 and stable/6.18 were fixed.

Fixed status
stable/6.18: [ef073edd7cfd31aeb90eeab23273102c601f4d8e]
stable/6.6: [c2745e657f0974871fbc60d46d48c2b04e581330]

CVE-2026-89812: drm/amdgpu: force complete the MES ring fences on reset

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [c48d5a4d2863e56a6692ecb6cd6c32404f40cd0f]
stable/6.18: [7d722821e2f626c4e34c8510f0ce1d6f10c77a3b]

CVE-2026-89813: drm/amdgpu: force complete the KIQ ring fences on reset

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [9944329e409b04d71fa22f39b38a4bd78b75bcd9]
stable/6.18: [c26cbd5c33cd72daa03079235de60688a3c97c52]
stable/6.6: [11adb2bae30a3155395594e5c9bc0daf0c4ffa15]

CVE-2026-89866: media: chips-media: wave5: Resume device before setting EOS flag

stable/6.18 was fixed.

Fixed status
stable/6.18: [56c2c5ad35614ca5ae23838d6af5d7f59e3124dc]

CVE-2026-89907: LoongArch: KVM: Validate MSI data before routing it to EIOINTC

stable/6.18 was fixed.

Fixed status
stable/6.18: [506f03b5f869cbae50d31b50d80d4a5735d47f94]

CVE-2026-89912: KVM: arm64: vgic-its: Don't dereference a NULL
collection on ITT save

stable/6.6 and stable/6.12 were fixed.

Fixed status
stable/6.12: [2c3a87ad3d3935c43d465cd2465db9020f9e898f]
stable/6.6: [dd0c3e6c03e3bb3fd7c0fa422230020674c5c25e]

CVE-2026-90040: KVM: SEV: Forcefully invalidate SNP VMSA if its
backing gmem page is zapped

stable/6.18 was fixed.

Fixed status
stable/6.18: [ef4dee4640c6adc3051401399b0788135e77d50b]

CVE-2026-90061: netfilter: nf_tables: skip double clone set
expressions on element insert

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [04d1930072e694d9d03bfefdb7e1ebdc872a3d0c]
stable/6.18: [c6b56b8d549a043b6c8ff616db8748263eae05ae]
stable/6.6: [9cbf6da967ec8c6e8278b70353b712980a12d848]

CVE-2026-90079: octeontx2-af: fix cn20k mailbox lifetime on repeated
rvu_mbox_init()

stable/6.18 was fixed.

Fixed status
stable/6.18: [c08314f91782983d67af0807ed1360e404ac4a8b]

CVE-2026-90082: net: mana: Cap MSI-X vectors to the device MSI-X table size

stable/6.18 was fixed.

Fixed status
stable/6.18: [7b3e08eea1e8cae37e84540c5cb4aee4887e46ac]

CVE-2026-90087: Bluetooth: do not leak an hci_conn when a second LE
connect is rejected

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [78970b39529844b31df2949015f66752e17210fe]
stable/6.18: [8a8585e421d06f878b33ef79f82cace0d485e3d8]
stable/6.6: [a78d16530c1538a215a827c7c3a4b408d6759bc0]

CVE-2026-90093: Bluetooth: L2CAP: access chan->conn safely in get/setsockopt

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [3af72bf8f73c519ee562e6963d5ff8e678924f93]
stable/6.18: [8460dc49c9756a1e9288218060b4d41e1b704905]
stable/6.6: [19e154d794eb4d33d99ca4a087b1cea9d5e65786]

CVE-2026-90095: fuse: Fix the condition to enable over-io-uring

stable/6.18 was fixed.

Fixed status
stable/6.18: [1ca1df82d9248fc0b5ff17d45607484f18e5d60b]

CVE-2026-90099: net/sched: account classifier filter allocations to memcg

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [bf6006cea193cf065f7a64fc7974247f8112af33]
stable/6.18: [68fb30607169c92de57c5c82b6af8a733af1cc09]
stable/6.6: [5fbb06d4f3d4c509ffe95572384a498bf319e5bf]

CVE-2026-90104: NFSv4.1: zero referring call lists before decoding

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [7510a5b9edec9d9536a4e69f10edfb2592e6cf7f]
stable/6.18: [f4d23937e1c41995c2f54af26c89b5e48a41c299]
stable/6.6: [ed54460caf5b5aa65ec03c9a6032d831f39f19f5]

CVE-2026-90105: vxlan: fix reading neigh ha

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [751cb520f9e47538b7223df133806a29fc41f54f]
stable/6.18: [f43ef9a3f9c121472a0754c9e9bff13317ace0f7]
stable/6.6: [6093baf2b2c57e7da33bacd2223570a78b416d89]

CVE-2026-90106: net: bridge: arp/nd proxy: fix reading neigh ha

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [a178bcb01051688fb085ffb72cc4b13b5df0fc0f]
stable/6.18: [884cbf15ccd3980bcc9583073045f91798a86d4e]
stable/6.6: [490c72868443ff90f47f4ccbaaff1eaf8fed46ab]

CVE-2026-90111: ip6mr: do not clone dst in ip6mr_cache_report()

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [42ef371466d5648f5c9e8bc219f0af0a2c2bbf8c]
stable/6.18: [f57b0fd1c62e1be274ee154ab7fb8ac4481b7f89]
stable/6.6: [7f8287f606c8c028d4224e85d95dc448c6d6d623]

CVE-2026-90121: irqchip/gic-v5: Clear per-CPU IRS data on teardown

stable/6.18 was fixed.

Fixed status
stable/6.18: [0887d41abf76638942688cb0c0ff8087f52e2b33]

CVE-2026-90142: virtio_net: Fix resize of the RX ring

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [5c941b5d989a15cdaa987a2c602fb168461c6186]
stable/6.18: [5235abdb760bbd7a6fcecf1890b5160b7a75a9ce]

CVE-2026-90144: dpll: fix NULL deref in dpll_device_ops() during teardown race

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [7d9661d6ef60bee705a3bb220dc59f10d9155c31]
stable/6.18: [d39da3ff8d39c31761bf1698bc02a5a206722136]

CVE-2026-90146: bpf, xdp: move offload check into dev_xdp_install()

stable/6.6 and stable/6.12 were fixed.

Fixed status
stable/6.12: [486dbe7efec2be19cd3625be282f7f6b34a3f2c5]
stable/6.6: [bd06033625ec20b7bdec43d21f776fc1a5e9000e]

CVE-2026-90154: ksmbd: scope session state changes to bound connections

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [3d66f3ec3c69fa242939a9f9e6815df33390b1bb]
stable/6.18: [1ff0e41afbe73240a7d7b96d4e8e86d0aaf0fe0b]
stable/6.6: [3deefd5fb1368e2577144b0961b1a5df26b587d1]

CVE-2026-90155: ksmbd: detach blocked lock requests before freeing

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [d31db79cfaa9fce6649772ad279779473ba8aef9]
stable/6.18: [f77d2accafca529e0ea3f979eb6e6cf1dac05c90]
stable/6.6: [d20d3f6ad8b0b6f4e1bb32cdf7eca251962e8f04]

CVE-2026-90156: ksmbd: safely discard unregistered deferred locks

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [77413400f083a959724de6f36348c9677ef9873a]
stable/6.18: [52b91bc5253bb83665f3ea70565d0b2487dae643]
stable/6.6: [ecdcfa15b3d799476c685cecd433ebefc93015c8]

CVE-2026-90162: ksmbd: defer publishing granted locks to prevent
UAF/double-free race

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [65f54ed0289e9a57e6c60b14347ccea4c318f1fc]
stable/6.18: [ff6870cf3b7eccc69d03cbb6f23e3995d96e9a8d]
stable/6.6: [b68d4bb6b03a667c305626bd2c242fd162bac17e]

CVE-2026-90167: ksmbd: serialize oplock close with pending break ownership

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [7d6e682b7633120c2f93400b8c6f335d9d8e5318]
stable/6.18: [dc1e34f78dfab755fab9ad820ac5f82348fe1792]
stable/6.6: [7148a6c06ddf1c263a1cf422bee541f24d3d3926]

CVE-2026-90174: ksmbd: fix slab-out-of-bounds read in ksmbd_alloc_user()

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [863f74ad158fef2987b9146f29d4b3149bb95953]
stable/6.18: [272c05a51285fe3495ab2f7eb77a48ad831b929f]
stable/6.6: [67223b1150a9edea52350d8cd085ea9081beaa45]

CVE-2026-90177: bpf: Check pointer type for all atomic RMW paths

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [b14dabe9656c1029abf3aa01e69c0d62f37f2f88]
stable/6.18: [d4ba9d888ac0a8f12c78071fff73e1205a0b9293]

CVE-2026-90182: blk-iocost: clear delay state when freeing policy data

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [8b4d0b1b3079bbe9a5366e2c8020eb22926733b6]
stable/6.18: [b399a88eb8b16c5a1a3645fd49ff507fb82b363c]
stable/6.6: [6b59f976db5def818829fc1eb4efc0a5c8c2f0cf]

CVE-2026-90183: blk-iolatency: clear delay state when freeing policy data

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [b6449a915d1826e1450f6368fc379fe44caa06ca]
stable/6.18: [5c6593422eb3c3a21505436ccf74599a433584c8]
stable/6.6: [53ccb4b967edc5f82ff6f9c066fb96c31aa7561a]

CVE-2026-90206: nvmet: fix max_qid race between configfs and
controller allocation

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [a1b88a1782eb6b368071dcda548a41b5c23d8cd2]
stable/6.18: [6e6f8e3bfc66dff1833a48ecfd857268cff3be84]
stable/6.6: [af811970da4f0a928f5a1b1a946a04f755ce86f2]

CVE-2026-90208: clocksource/drivers/samsung_pwm: Switch to raw_spinlock_t type

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [5720fe5cabda19f395d194ca57321c7b85f8af80]
stable/6.18: [a25ea67a913f98b8461aff1e9e3a5f6dc2378395]
stable/6.6: [8f823b47eb889ea70f4c360164e96453f40e3646]

CVE-2026-90217: bpf: Compare iterator types during state pruning

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [86bbaf9e6e4fa6c0dfb352e9e11fae328069233a]
stable/6.18: [e4ab436d5ba61e4910fd49d24bb64ddb34d493d6]

CVE-2026-90234: NFS: Return a delegation the client fails to record

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [fe3b1c8966a27b70599d28ce7e80819adac1ff22]
stable/6.18: [6822ba1ae9b6df6a094f7f8998f1da734c85fa19]
stable/6.6: [9e71e332fa2c7a48f3d00001f856a13cc2d69639]

CVE-2026-90242: iommu/vt-d: Fix iopf_refcount leak on RID domain replacement

stable/6.18 was fixed.

Fixed status
stable/6.18: [243bf1e45e40be4705aae17c5044bf83df5f4a92]

CVE-2026-90261: btrfs: zoned: flush active metadata block group at
btree_writepages() start

stable/6.18 was fixed.

Fixed status
stable/6.18: [58b0ab0340ce04a057169d42cbacbf786063813d]

CVE-2026-90263: btrfs: check if root is readonly when setting posix acl

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [dc3a6e90a0a6350a6d43fed9f005f54171809580]
stable/6.18: [ce8103676f4d4b13e1f087fcfb34f80774d30be2]
stable/6.6: [20b2c2f3316e82a76ae3358c0bd45824f50f3fd5]

CVE-2026-90267: scsi: sd: Fix special_vec mempool leak when
scsi_alloc_sgtables() fails

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [744a65e113094756e6c1cfba9ff1bf4247cb68d4]
stable/6.18: [e90f746f4ca3896ca560e820b7b6b0a467026938]
stable/6.6: [710a2448a06a8215ba8acb4a2791954800f7db0a]

CVE-2026-90273: coresight: etm4x: missing
cscfg_csdev_disable_active_config() in perf enable

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [26f9e89bad5a7e3005d3dc97a2e2fa6d6b2b8bb6]
stable/6.18: [d5f3dae82705d9388434892915008da3bb83c4ba]
stable/6.6: [ba63c62d4252f6bc58fd2a567075c72d03332562]

CVE-2026-90289: drm/amd/display: Resize MST HDCP per-connector arrays to 32

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [ac490fea9fe74f9d9975c5d8250c8719750589cd]
stable/6.18: [562d24ac214ba9530d88841088eb6adce5c537b5]
stable/6.6: [decea8279bec5a35413b2cb8e36951cca308fac0]

CVE-2026-90300: bpf: Clear buf on error in __bpf_get_task_stack

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [6f5a7bcc049709af12e403111d5e73e80910dafc]
stable/6.18: [1f0f61573ba4cb899105b5cef65be3ca02205f93]
stable/6.6: [4acc761b4e3feca1eb648d21fc4d665b23c5372d]

CVE-2026-90301: ocfs2: o2hb: quiesce negotiate handlers and timeout work

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [f218d70f27bb326f5e9b2f33503e253851b3bafa]
stable/6.18: [9d44822ba34d6035690f725f9de602744a6e1946]
stable/6.6: [b672d4de13247369c8dc394ba83f2a896d9cc25c]

CVE-2026-90311: thermal: hwmon: Remove hwmon class device along with its parent

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [23094544b8e8c43909fd61ca8866ecfe38093ae8]
stable/6.18: [9b405b3e7e131ee85dd78b9cc951b41f0828a333]
stable/6.6: [df002834cfd880b800fa607135e4bb2e403ce187]

CVE-2026-90315: PCI/sysfs: Add lockdown checks to legacy I/O and memory handlers

stable/6.18 was fixed.

Fixed status
stable/6.18: [3556caa31a2bfbc22c11b812fd4ed8851c2d7bff]

CVE-2026-90317: bpf: Invalidate RCU pointers after final spin unlock

stable/6.18 was fixed.

Fixed status
stable/6.18: [f81972b235f3ebfa40bdce8bcfee3f242fb24065]

CVE-2026-90323: ublk: validate auto buf reg before taking uring_cmd

stable/6.18 was fixed.

Fixed status
stable/6.18: [8397942b67128e0b1275cfedb5abf4faafac5fd0]

CVE-2026-90330: HID: logitech-hidpp: Fix FF device cleanup on init failure

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [6bb216586a3cb4ce327511a7c0445fa88e85b3cb]
stable/6.18: [2fd9c8112907c14efefe6a90d20b774737052db3]
stable/6.6: [360a49fc53acdfe2dbb80c23cfa606ed7e13a85d]

CVE-2026-90335: tty: skip cdev_del() when no cdev is registered

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [21031bd0d662549412378110c989b164feb6e4be]
stable/6.18: [2af4c46b429907edc8cb069c78fca1d950120b98]
stable/6.6: [ea3d2fae7c1d6492145976553817d22e8ef69a0e]

CVE-2026-90336: serial: core: clear freed pointers on
uart_register_driver() failure

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [802e2192a9d38027730c2869c67c9131b8c8fe9f]
stable/6.18: [ddf51d74ee9f9857c99477329d80408cedebda61]
stable/6.6: [a9c0ffe5930c97b352f32febfc59a6e6ae6772ee]

CVE-2026-90337: serial: core: do fallible allocations before the
console can be registered

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [8c7c75bfa7b84d6999de2100ce9c09e3779249a0]
stable/6.18: [9260a92ce90e6a95ce2ffdf1441c5216bf3f9552]
stable/6.6: [e2ddbfd826836cba1b7a25ee4eb512f7d752b703]

CVE-2026-90345: wifi: brcmfmac: fix P2P action frame handling without device vif

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [6641ba636bf675b2634c49fe818931cf6ca8f547]
stable/6.18: [f334b26b884dff5d0a558dc464fa55f300868a68]
stable/6.6: [66b89c6a7da47efb38a9b839c2ae221b23a1c88b]

CVE-2026-90346: wifi: nl80211: clean up color-change beacon data on errors

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [bbe3a69a7b64398dddd1c989e9a40eaa57616b33]
stable/6.18: [0ec1d14cf302ae7c23ec218527b2849a1fced3f4]
stable/6.6: [5f47c9bc4a62e61f932a83680a796bc09ae48dd3]

CVE-2026-90347: arm64: ptrace: Keep 'orig_x0' in-sync with x0 on syscall entry

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [ce17c651a90e242ad48df0df89b1e4cebcda5e14]
stable/6.18: [e9e2854fcff5733ffc607e8ecc87e0e591ab41fd]
stable/6.6: [332c9c1a148d0425326989c1187face8f6b2a60c]

CVE-2026-90355: wifi: mt76: mt7996: clear stale link state on full reset

stable/6.18 was fixed.

Fixed status
stable/6.18: [e512823aabbdc91444b9d886638f059ef58e86b1]

CVE-2026-90359: bpf: Reject >8 byte return values on return-reading
trampoline paths

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [de54ba33690d2dd3c4aa686c9693505644285b0b]
stable/6.18: [9a9e902bd0556052534641f7d5f868c6dc4b84ae]

CVE-2026-90365: wifi: mt76: cancel reset and rc work on device unregister

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [7b3b1b3c7d434b5c5bc8d7de0b9c335242eeefba]
stable/6.18: [aca0cd273b486a078f936b3fb409e619673521b1]
stable/6.6: [5dd845c6388c6c9a4085ecdf59c7fe7bf3398e2e]

CVE-2026-90380: wifi: mt76: mt792x: fix use-after-free in mt76_rx_poll_complete

stable/6.18 was fixed.

Fixed status
stable/6.18: [2aa3d3b9fac9163e9226e35556607ae3f75be21e]

CVE-2026-90381: wifi: mt76: fix handling channel context with
different bands in mt76_switch_vif_chanctx()

stable/6.18 was fixed.

Fixed status
stable/6.18: [7a1b971b799eae8a957acb90d8100576df889644]

CVE-2026-90401: md: remove REQ_NOWAIT support from raid1/10/456

stable/6.18 was fixed.

Fixed status
stable/6.18: [ffcc9ea4e4d121c78aef6654a1577aa7d120774d]

CVE-2026-90408: wifi: ath12k: fix overreads in
ath12k_wmi_process_csa_switch_count_event()

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [24f7cdabea9f7ab95dbd6d8bc9ac6ec48d96a7e5]
stable/6.18: [23bed4ef132c55c9016f0c6122c8b8ba2efa2353]
stable/6.6: [d4aec20f3a84634171c139ab2e02bb2e5a5c756b]

CVE-2026-90409: drm/panthor: Add vm_bind region with kbo range overlap check

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [276753aaad65e6f7dac7989a600c1c2d3a382c1a]
stable/6.18: [f2be47fa8e225968eb66863657143fe900ec4bca]

CVE-2026-90412: nvmet: fix return status of RMI log page on allocation failure

stable/6.18 was fixed.

Fixed status
stable/6.18: [ffd56ada81f975a33f1df447f1bec9090a818e98]

CVE-2026-90417: RDMA/cxgb4: Fix dereg_skb leak and double free in
write_tpt_entry()

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [379cf06e6fe34af980064c6ccaf15d8e26ec4a42]
stable/6.18: [2fcd26f4680143e9ec477069530548dbe20fce6f]
stable/6.6: [68c1d2c085f205e8a5338bc3d3304f897deca4d9]

CVE-2026-90421: PCI: Fix UAF when probe runs concurrent to dyn ID removal

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [2cbcb0819c6367e1d5b0792a960594cc19576e23]
stable/6.18: [c36816feff47f676dcc51919777d483f4146c1ee]
stable/6.6: [d867db0a2602919510f346bc555f7b3093f6b6cc]

CVE-2026-90427: iommu/tegra241-cmdqv: Don't fall back to a freed smmu
after devm_krealloc()

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [ea2edb27ef2648d8687cd0fc3ec3ba1793436e7e]
stable/6.18: [268cbe3a36ae57a2ec09601f343b92f6f092d505]

CVE-2026-92480: scsi: ufs: core: Validate string descriptors

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [02dd1a65dff842d9360a38ebe243dc8f6adbbaf5]
stable/6.18: [f3480c59f4ce97d831e9d06f5a2b9c20547ed1a4]
stable/6.6: [566109f1ee4e389b4effab43b0ce1fdab302e9de]

CVE-2026-92482: pinctrl: mediatek: use devm_gpiochip_add_data() for GPIO chip

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [2490528a90a26f408ec3e95f865bad35454f9ff3]
stable/6.18: [01b5fcdc30c0ab35af960b60508eae1f7f7d32fd]
stable/6.6: [dc6e5d802c88468290fee8826dd3a54cf58da25a]

CVE-2026-92485: bpf: Fix WARNING in bpf_tracing_link_release

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [d02035c5eb4955616efc5c6dbe3d98f19d798cb2]
stable/6.18: [094f0a895cf97a993d06d5dc4c12e7cb7da845a5]
stable/6.6: [a5c6316052f0ff1467221ecf2996cbab0a496b1e]

CVE-2026-92503: ext4: fix ABBA deadlock in ext4_xattr_inode_cache_find()

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [d3b19b318e0e0483180d15f1d9f5e807a1fb59d5]
stable/6.18: [074d0620401974cbfa9b63684cdfae99c7b2059c]
stable/6.6: [29a2a166450a3e89f61a486033b10cf170fde8b0]

CVE-2026-93081: firmware: arm_scmi: Fix SCMI device destroy lifetimes

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [916e27f71a80f6d77c48d1a1a5782d6d5ef9017c]
stable/6.18: [a60bc2df2d323cc1342f0cf95563cae266801e20]
stable/6.6: [d8ecdceeb90cd2c265b222a7b65487faf68fea73]

CVE-2026-93096: cxl/features: Serialize multi-part Get/Set Feature transfers

stable/6.18 was fixed.

Fixed status
stable/6.18: [c6492e17412048387435f256ffafc4dd6518db28]

CVE-2026-93099: fs/resctrl: Fix UAF from worker threads when domains are removed

stable/6.18 was fixed.

Fixed status
stable/6.18: [6a2e023429a41afd0d9dfe74268aa51774a953ff]

CVE-2026-93104: RDMA/rvt: Return NULL after port allocation failure

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [5a1a7a5e2fe1a15824fa9ae5edd8f008259471d1]
stable/6.18: [80968b42d13080bf7bc1f3ee17fef126ce2ad98f]
stable/6.6: [b7129930d1ec46c03a0de07fdce6c29f75795006]

CVE-2026-93105: esp: do not unref managed frag pages in esp_ssg_unref()

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [3ec55f0c8a6a543cf660584d1346e11f6311ee59]
stable/6.18: [1ad6456898f6e6cf58be83bdb607acb1119a9cd1]
stable/6.6: [201bdf10ae92e7cbd524adf8c0323e2a963d5fd7]

CVE-2026-93116: platform/x86: asus-wmi: fix resource leaks on probe failure

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [8d5999608da60db45949e5459f74f581cdaacd04]
stable/6.18: [8410cd2690d463b60527d00ac8cffea2d5a041f6]
stable/6.6: [959ed35f8c8f07b8dd43c3f917a43ae2f77e4471]

CVE-2026-93122: usb: gadget: uac: validate rate list length before storing

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [0c2710a36b41bf8defba83c395b99eb1660e9e9a]
stable/6.18: [0203146ad450932c2d3132e367a99c49efe3122d]
stable/6.6: [72888d54bae3677ecd4ba9793b7fd27ba0b27862]

CVE-2026-93125: bpf: Reject rdonly/rdwr_buf_size kfunc arguments that
exceed u32 max

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [b6ac0b5732047d43172b9dfbe6b57b9b8de303c2]
stable/6.18: [93a20b14f8627b2d3486e3ec1d3f2e7275a506ec]
stable/6.6: [2147065d3a4e1d5d42ae553fef165f17ec5e0e79]

CVE-2026-93129: platform/x86: dell-wmi-base: Fix handling of ultra
performance key

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [ace1a687ea9ea70d17e3089ca173acfa1ec24412]
stable/6.18: [16a82add1918d3aae1e0b68c0a983b6fc64f5062]
stable/6.6: [30674a7bbf20311a0c4edd5edb9526ef1eecc692]

CVE-2026-93144: bpf: Reject writes through untrusted BTF pointers

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [c4dc883447ae38c4e22a29cc016046fa65d88994]
stable/6.18: [644cf4e77c2770d4246f6d12f99bc80d253b0ec6]
stable/6.6: [56f92fecd80419567288b7972caa90107033836e]

CVE-2026-93148: bpf: Reject MEM_ALLOC BTF accesses past object bounds

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [90d36e825da4fadeede64784ceda975ab7b31dab]
stable/6.18: [cf08ff2255de98cfcbc8bf7236fbeb38f0d5b4f1]
stable/6.6: [94033c193bc38794511b2ebfa3dc0287d3b2bf60]

CVE-2026-93164: uprobes/x86: Move optimized uprobe from nop5 to nop10

stable/6.18 was fixed.

Fixed status
stable/6.18: [7abc9b49ad01a179e893ba137364a560e21b09f8]

CVE-2026-93168: dmaengine: xilinx_dma: Fix CPU stall in xilinx_dma_poll_timeout

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [c30a26d4987a01e619449bf170f584c007e07d75]
stable/6.18: [f786e7b3adbf3bd14964a1cedf9d55b6ad91dcd7]
stable/6.6: [2ba67aa183a3ce174d534425b67eda84f6e3c896]

CVE-2026-93175: drm/amd/display: Fix dangling pointer in CRTC reset function

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [9de069b724f3614ed7dd55bfbb37c434db54e128]
stable/6.18: [3a03827bb3cda1527aa923f18160c449f2b4cf2c]
stable/6.6: [ef3293c87a79f734d506769ff86f99bf1bad522e]

CVE-2026-93176: drm/amd/display: Fix dangling pointer in plane reset function

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [0999a267bdc13648b6b0db893e7eabe30bc13e7c]
stable/6.18: [3d8391d3149a1aeb93505a4f9fb9ed8364882c42]
stable/6.6: [cda8af27b787d79eadc4eb8109d9f2e856dadac2]

CVE-2026-93179: drm/amd/powerplay: fix VoltageObjectInfo zero-stride
loop and OOB read

stable/6.6 and stable/6.12 were fixed.

Fixed status
stable/6.12: [203ffe648948ca3c2f55b21118945a7a6d0884aa]
stable/6.6: [574af7c61f2bed37baa3b60669e428d24d2c9ae8]

CVE-2026-93201: dm-pcache: validate seg_id fields from persistent memory

stable/6.18 was fixed.

Fixed status
stable/6.18: [96d4b275281b45aacd0f0510fa8bec85d9f7dc5a]

CVE-2026-93221: nfsd: convert nfsd_net boolean flags to unsigned long flags word

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [faac245ca739b66e96fb7bb43e21df537239a4e5]
stable/6.18: [40bab0da844c142431a6b1cc21b4cf53491dac44]
stable/6.6: [94b450977c60261903c945419d2df4a464de60c4]

CVE-2026-93243: mm/secretmem: properly account locked pages

stable/6.6 and stable/6.12 were fixed.

Fixed status
stable/6.12: [a41c95ac90f285cbe473b9606428b14518896ea4]
stable/6.6: [51fba083e454f901947d6a335eeff671171d4714]

CVE-2026-93248: drm/xe: don't WARN on kernel job timeout when device
already wedged

stable/6.18 was fixed.

Fixed status
stable/6.18: [041cce629a08d4a2f1a28ec61a105b26b7f047e6]

CVE-2026-93251: ACPI: bus: Introduce acpi_bus_get_primary_device()

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [fd4f907b558721716da30acd6630191acf811b95]
stable/6.18: [ebdd932dc24c1cf7cc31710b7730515e4e66d886]
stable/6.6: [50ddd82b88b1d1cc467b5df953344c1a9feec268]

CVE-2026-93255: btrfs: make sure EXTENT_BUFFER_READING is cleared
under refs_lock

stable/6.18 was fixed.

Fixed status
stable/6.18: [8f7285d608ed0db7c9f09f341547db5ce1351090]

CVE-2026-93260: powerpc/xive: propagate IPI init errors to prevent
use-after-free

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [2ea6238343691309e68308131c7e80c3ae05afea]
stable/6.18: [5c9ab0c9cede9f149733d330e2d7d45341b71359]
stable/6.6: [e36b1c2eafcaaddefa70d55e6fda74cf6cda38af]

CVE-2026-93272: remoteproc: qcom_wcnss: Fix handling the lack of PD
regulators in v3

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [e572cbb513cde53d90fb4729cad75056cd647ce3]
stable/6.18: [2e7e39bb81913feaac463b7add46bafdca06fbde]
stable/6.6: [7abab59d6c99ba2b8101d6f44ad25159b1510724]

CVE-2026-93282: ksmbd: fix maximum allowed access checks

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [37459edb69c094553026ee48c2cc2acc657f9f43]
stable/6.18: [28289d880e6d11ae7ac77b81af3312453febf939]
stable/6.6: [7c293e83d86cfd38124f51b27882ad631818bf48]

CVE-2026-97554: smb: client: avoid using uninitialized SIDs in
cifs_posix_to_fattr()

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [33106019c3be57b5fc6411cfaad6d98214a51265]
stable/6.18: [2be31f252ade791b84f7164991f14436aed1d4b9]
stable/6.6: [604feb3e8141bf11f5afd48d36d401fee5af9536]

CVE-2026-97558: smb: client: fix cifsFileInfo reference leak in deferred close

stable/6.6 and stable/6.12 were fixed.

Fixed status
stable/6.12: [bbeb7a42c9ea656e17ddcbdc2d7917aa853383a6]
stable/6.6: [525c225e23d61694091f2806de553a69362a78ff]

CVE-2026-97561: smb: client: honor forceuid/forcegid when mapping SIDs
to uid/gid

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [bc35de451c128d399ad185d6269f8847e97cd1c9]
stable/6.18: [6ac7a29691558bed18e2df1780636b8aa0fd13d5]
stable/6.6: [be6eccccec867c22d7c65fab4ea4e91ec3d5b8c6]

CVE-2026-97567: mptcp: prevent race between disconnect() and rtx

stable/6.6 and stable/6.12 were fixed.

Fixed status
stable/6.12: [2261f857ef4e0d21eb1a8b47b06640cf7ab16d3e]
stable/6.6: [75b3b30ae4ee6aa0572595f6b48544ed4f479eb6]

CVE-2026-97928: drm/amdgpu: skip the VMID 0 flush for VRAM

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [6593494733ccaf691db7bd13801583d188409607]
stable/6.18: [30dacb56f07283a1acb353ce81baef31f85396b0]

CVE-2026-97933: tracing: Take trace_array reference when opening a
tracer options file

stable/6.6 and stable/6.18 were fixed.

Fixed status
stable/6.18: [d9232a90c6f7de822177d35d73d9234cba523ef9]
stable/6.6: [61894ea0d2a1ae8ce903abf73bd56958c035f182]

CVE-2026-97988: vhost: invalidate vring access on IOTLB transitions

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [e8fe13c14d57cc7c6bd69c72c5fabaaf0d918f98]
stable/6.18: [7f8ee0b8f632441aec456a7c147fb43f5c73542d]
stable/6.6: [021bf73731f7aa94540a549cf850db5968019960]

CVE-2026-97989: vduse: validate virtqueue alignment

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [5d4bdca17d87c90b1d888f8846a781a18aa453c9]
stable/6.18: [831dab9b9bcc184adf78f18b5b788316e3174aec]
stable/6.6: [650bac9c73d3b4d83be683028283654c05346556]

CVE-2026-97997: virtio_ring: fix stale descriptor flags after a failed
packed add

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [cfe8128ceb78374b0f9cebb608bb48e3928d784a]
stable/6.18: [3e6400e3b8b858cdf0f8d70b20d8b55d703af368]
stable/6.6: [5ad081761a1f0b0d95ab08b61a6008309fba95f9]

CVE-2026-98004: iommu/riscv: Serialize command queue publishing

stable/6.18 was fixed.

Fixed status
stable/6.18: [787405e9e7bdc53ea7e063fe7b855171b4bd0e91]

CVE-2026-98019: bpf: mark a NULL call argument precise

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [627089c278df58749f25686c6a3caf7e181b5951]
stable/6.18: [b1fe6379e401b8ce0f561cb4d84af2b70b4343c3]
stable/6.6: [febbb66e682d8328f7c5bcbdd5e4291abab2e858]

CVE-2026-98032: tracing: Fix subbuf resize races with trace_pipe_raw readers

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [574efd988d116bd56ac688ab2d64e06ba0da982a]
stable/6.18: [3f30b2cd4eba45c05f822f03f1b0f4077d6d4dc3]

CVE-2026-98033: bpf: Preserve inner map identity in callback frames

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [166221c52d3ca332f8699a854efca8e2704bb137]
stable/6.18: [08b534bafdd9de65b6374474a8fe719c90eb3b01]
stable/6.6: [cf85e4f94d7feef8b3c4c90dbe2468595a48393b]

CVE-2026-98034: bpf: Mark NULL kptr stores precise

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [b8b98d3d37908402ff63515fa4d7574235436ea8]
stable/6.18: [bb667eb575c906f24c707986541a99424c5b07ea]
stable/6.6: [86a3171c90bfc35a54e9d83cd197ca0d72d2f4e4]

CVE-2026-98038: bpf: Keep refcount_acquire nullable for borrowed RCU kptrs

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [85bfc8b6db43502444c428eaa2de20bdd2fb9064]
stable/6.18: [8d19e2cdfba9ba8c8eb6a459cd666bec00a1d2c6]

CVE-2026-98043: bpf: Don't infer non-NULL from a pointer with an
unbounded offset

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [019d845a08b8ccfe8eefaaf4bca6870f2b8c58ae]
stable/6.18: [65bea674f43c09c0eda033a140dfac6a2842a19f]
stable/6.6: [8b414dbe97fcefd116e5a620c3bd9993014aa4ce]

CVE-2026-98048: bpf: don't rewrite bpf_fastcall patterns entered by a jump

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [a0cd1c3ac63504ba3c50c01a00c11812919b619f]
stable/6.18: [c4d3bdb3ab211dcfad734b02e06fcb12adb4757f]

CVE-2026-98049: bpf: zero extend the result of an arena 32-bit cmpxchg

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [1bb1be18263995b159cf5afad3a05500ba6d2a7b]
stable/6.18: [6bb6ae5ab1beffda51dabf41612f501d07f10fc6]

CVE-2026-98057: ring-buffer: Add checking nr_subbufs to persistent
ring buffer validation

stable/6.18 was fixed.

Fixed status
stable/6.18: [364a31052aa9ef91db137f82d797366007cd85b7]

CVE-2026-98058: bpf: Mark syscall helpers as sleepable

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [d8cfe9f71d302970ae393616960f2b3021d2b3b0]
stable/6.18: [65f636322ac402add6046c68e9ece77b9ffd71c9]
stable/6.6: [9496d857205e60241034b798d7745ff8830ba599]

CVE-2026-98084: bpf: backtracking shouldn't clear outer frame R1-R5
for callbacks

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [cdc93c6370f792d0649df2a145ac0cdcd430e411]
stable/6.18: [3a39bc9707fbd1bef4df7318a9d02222741dda5b]
stable/6.6: [1ac58dab0a83d2c64e3b807a3a0b399f17a74110]

CVE-2026-98085: bpf: backtrack_insn(): Handle ld_{abs,ind} subprog exit edge

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [12c064bcfa56e3631be9f5336ee113b7f849959a]
stable/6.18: [a0cd9e22f8faed30a8da8be357c51bd8b3074ee9]
stable/6.6: [19cca7c36055906b3cff3e297618ee8a50cde25d]

CVE-2026-98099: ipv6: mcast: use rcu_assign_pointer() for __rcu list updates

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [49d7e1b456ba2f3ee08b3e264d999c09992cde8e]
stable/6.18: [afca229b39acc2590976b3e4f6e0fe76cededc60]
stable/6.6: [0e3e3cec28c4d1bf29948da40b4e9e5d44f7852b]

CVE-2026-98131: net: stmmac: fix dma mapping leak in stmmac_tso_xmit()

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [c5449b635362cb678d29d8f6ab54e65734d891ce]
stable/6.18: [8a3257f142ae513d0c96d42f97386d4941bcec29]

CVE-2026-98134: bpf: check_cond_jmp_op(): properly infer if register is null

stable/6.6, stable/6.12, and stable/6.18 were fixed.

Fixed status
stable/6.12: [dfd8f8adda565e08c370c45cf9d6b2511ba9b5c6]
stable/6.18: [9bf96b4347f541604b3caadeabda0773d9ceaf2a]
stable/6.6: [d51cd486930f5bcfd4b55d55ab8e47b03f93d2ed]

CVE-2026-98147: printk: Don't WARN on kthread_run failure.

stable/6.12 and stable/6.18 were fixed.

Fixed status
stable/6.12: [15ba35d632c38d879d182577b0af487de0f2dec4]
stable/6.18: [0af43b52fe4b1751b731c067127fdf47cf1b700c]

CVE-2026-98162: smb/server: fix tree connection leak in smb2_tree_connect()

stable/6.6 and stable/6.18 were fixed.

Fixed status
stable/6.18: [fea9c705bbc618ba6426424c9f8330555820c9ec]
stable/6.6: [fa0c45986fc60b3edfb35879f2fb0eacc0e49e98]

CVE-2026-98375: xen/netfront: drop RX packets with a short Ethernet header

stable/6.6 and stable/6.12 were fixed.

Fixed status
stable/6.12: [236a17caebcff31f75bec5ff4136bde2de944e40]
stable/6.6: [0542d213253eec18785a24b603b28bd385dfe4a5]

CVE-2023-52586: drm/msm/dpu: Add mutex lock in control vblank irq

stable/6.6 was fixed.

Fixed status
stable/6.6: [f6dd625053726ea2a209282bee97218f2ec04149]

CVE-2023-52590: ocfs2: Avoid touching renamed directory if parent does
not change

stable/6.6 was fixed.

Fixed status
stable/6.6: [1743d5a678048735d6d0e88cdede3b88d8234725]

CVE-2024-14040: net: nexthop: Increase weight to u16

stable/6.6 was fixed.

Fixed status
stable/6.6: [2860d59e4ce2bb428c8cecd3b95585012910b7d0]

CVE-2024-36892: mm/slub: avoid zeroing outside-object freepointer for
single free

stable/6.6 was fixed.

Fixed status
stable/6.6: [694eea36e3e16e8a5aee641dfceb0702176e3b30]

CVE-2024-38608: net/mlx5e: Fix netif state handling

stable/6.6 was fixed.

Fixed status
stable/6.6: [70eca80d98a44f47cd1633d0c20bda8ae546b4d1]

CVE-2024-40999: net: ena: Add validation for completion descriptors consistency

stable/6.6 was fixed.

Fixed status
stable/6.6: [edb9a302cc9386142beffe5d9bbe4bfd36999eee]

CVE-2024-41008: drm/amdgpu: change vm->task_info handling

stable/6.6 was fixed.

Fixed status
stable/6.6: [251840f22eff35c25de531a3fcb523df94c128c0]

CVE-2024-41023: sched/deadline: Fix task_struct reference leak

stable/6.6 was fixed.

Fixed status
stable/6.6: [f8005214946fd1d9fefdeff19c6ce46d60de2cef]

CVE-2024-41932: sched: fix warning in sched_setaffinity

stable/6.6 was fixed.

Fixed status
stable/6.6: [d35130036d327b6c175d95db9ea8d64e1abd4a1b]

CVE-2024-42107: ice: Don't process extts if PTP is disabled

stable/6.6 was fixed.

Fixed status
stable/6.6: [9aa83a5eb013f8aff20e701aa25ba6b0eaad0b65]

CVE-2024-42123: drm/amdgpu: fix double free err_addr pointer warnings

stable/6.6 was fixed.

Fixed status
stable/6.6: [1eb6c4a0d83d1f348d718f813706105eff8cfc74]

CVE-2024-42139: ice: Fix improper extts handling

stable/6.6 was fixed.

Fixed status
stable/6.6: [1f7f63f7165d1c8eee6424b517054db9f672e48b]

CVE-2024-42155: s390/pkey: Wipe copies of protected- and secure-keys

stable/6.6 was fixed.

Fixed status
stable/6.6: [7d5711e03cefd59da4d198ca02d4f8238ba1105c]

CVE-2024-42162: gve: Account for stopped queues when reading NIC stats

stable/6.6 was fixed.

Fixed status
stable/6.6: [acf609843a848e2c22ccce98eef109330403380d]

CVE-2024-42317: mm/huge_memory: avoid PMD-size page cache if needed

stable/6.6 was fixed.

Fixed status
stable/6.6: [2011c0ebaf710194900f31e64e2ab7295037dbab]

CVE-2024-43819: kvm: s390: Reject memory region operations for ucontrol VMs

stable/6.6 was fixed.

Fixed status
stable/6.6: [705a8b8cc5a44b206096abb1bfdc8bc43b3c75c7]

CVE-2024-43824: PCI: endpoint: pci-epf-test: Make use of cached
'epc_features' in pci_epf_test_core_init()

stable/6.6 was fixed.

Fixed status
stable/6.6: [97cee643a825808711cc78475fd61a30824b7a0f]

CVE-2024-44951: serial: sc16is7xx: fix TX fifo corruption

stable/6.6 was fixed.

Fixed status
stable/6.6: [2a0ba376cdf729b5c66226c65c6c7cf9de744d52]

CVE-2024-46681: pktgen: use cpus_read_lock() in pg_net_init()

stable/6.6 was fixed.

Fixed status
stable/6.6: [7eed5b3115ce9e057bf64c3f6be9ea72f8298e4e]

CVE-2024-46808: drm/amd/display: Add missing NULL pointer check within
dpcd_extend_address_range

stable/6.6 was fixed.

Fixed status
stable/6.6: [117df33ecfd8ab41cde8e582ec90d3cb8d82ee9d]

CVE-2024-46834: ethtool: fail closed if we can't get max channel used
in indirection tables

stable/6.6 was fixed.

Fixed status
stable/6.6: [7e6ff8c58985fbe20d131112aba0a8867cdedc59]

CVE-2024-46842: scsi: lpfc: Handle mailbox timeouts in lpfc_get_sfp_info

stable/6.6 was fixed.

Fixed status
stable/6.6: [c6d8cce685d6088d795b29a0f47e6fd04548fd64]

CVE-2024-47661: drm/amd/display: Avoid overflow from uint32_t to uint8_t

stable/6.6 was fixed.

Fixed status
stable/6.6: [6fc6ef4cd858a45479fed881e326d2449a2c9e51]

CVE-2024-47677: exfat: resolve memory leak from exfat_create_upcase_table()

stable/6.6 was fixed.

Fixed status
stable/6.6: [af3c9c0bf8542dc5cd1c841a17af3f11747c3d77]

CVE-2024-47794: bpf: Prevent tailcall infinite loop caused by freplace

stable/6.6 was fixed.

Fixed status
stable/6.6: [f8ba0d22afa613b280fc40fcf6ae99f73c7b36e6]

CVE-2024-49885: mm, slub: avoid zeroing kmalloc redzone

stable/6.6 was fixed.

Fixed status
stable/6.6: [7299868253c0e8ba9bf31f6e5198e8eafa1e700b]

CVE-2024-49888: bpf: Fix a sdiv overflow issue

stable/6.6 was fixed.

Fixed status
stable/6.6: [45f2bbe7bc08d716a07a40025c672cad93180903]

CVE-2024-49918: drm/amd/display: Add null check for head_pipe in
dcn32_acquire_idle_pipe_for_head_pipe_in_layer

stable/6.6 was fixed.

Fixed status
stable/6.6: [180280f3c4621d699d903773bb84bf7f0bc6a891]

CVE-2024-49920: drm/amd/display: Check null pointers before multiple uses

stable/6.6 was fixed.

Fixed status
stable/6.6: [4f51f6d23c5856f105110531f81d84e78e462005]

CVE-2024-49921: drm/amd/display: Check null pointers before used

stable/6.6 was fixed.

Fixed status
stable/6.6: [692e9a20018da7aa225d8dced44803f9852aca81]

CVE-2024-49940: l2tp: prevent possible tunnel refcount underflow

stable/6.6 was fixed.

Fixed status
stable/6.6: [98691b2e28a6c3dac0680914493d54c77f215755]

CVE-2024-49945: net/ncsi: Disable the ncsi work before freeing the
associated structure

stable/6.6 was fixed.

Fixed status
stable/6.6: [64704f231d5dee8639e256507178f43dde1f131c]

CVE-2024-49970: drm/amd/display: Implement bounds check for stream
encoder creation in DCN401

stable/6.6 was fixed.

Fixed status
stable/6.6: [00872dcc2a3e4a42155c2f3b7f21952a62301035]

CVE-2024-50289: media: av7110: fix a spectre vulnerability

stable/6.6 was fixed.

Fixed status
stable/6.6: [0e58d7070eef16615e280d9b25d334b08e042b61]

CVE-2024-53050: drm/i915/hdcp: Add encoder check in hdcp2_get_capability

stable/6.6 was fixed.

Fixed status
stable/6.6: [d233c8da8b70fbf5d986d3ef55005f17b2ee6d32]

CVE-2024-53051: drm/i915/hdcp: Add encoder check in intel_hdcp_get_capability

stable/6.6 was fixed.

Fixed status
stable/6.6: [df17aa6038f96355640ace6ef3c3ff59c10c633f]

CVE-2024-53090: afs: Fix lock recursion

stable/6.6 was fixed.

Fixed status
stable/6.6: [9ada9ff6339d49df2260bb876ccf895d88928f81]

CVE-2024-53114: x86/CPU/AMD: Clear virtualized VMLOAD/VMSAVE on Zen4 client

stable/6.6 was fixed.

Fixed status
stable/6.6: [cf79df17706605032461f1ebde730b4391d1ca9c]

CVE-2024-53147: exfat: fix out-of-bounds access of directory entries

stable/6.6 was fixed.

Fixed status
stable/6.6: [82dc96f0f4eec8afdde8467d21d1b6b989dbb20a]

CVE-2024-53187: io_uring: check for overflows in io_pin_pages

stable/6.6 was fixed.

Fixed status
stable/6.6: [1a0aecabff72a95d240e6d7645949bfe0620dcd7]

CVE-2024-53201: drm/amd/display: Fix null check for
pipe_ctx->plane_state in dcn20_program_pipe

stable/6.6 was fixed.

Fixed status
stable/6.6: [0335fb698ab0415d87650bc7a0f465c563ddec7d]

CVE-2024-53219: virtiofs: use pages instead of pointer for kernel direct IO

stable/6.6 was fixed.

Fixed status
stable/6.6: [0015d54a47995867781224450525e60a1a0077ab]

CVE-2024-56544: udmabuf: change folios array from kmalloc to kvmalloc

stable/6.6 was fixed.

Fixed status
stable/6.6: [2384a29db79bd2cfe0b7646ac0030cb355825e29]

CVE-2024-56702: bpf: Mark raw_tp arguments with PTR_MAYBE_NULL

stable/6.6 was fixed.

Fixed status
stable/6.6: [41168ed90f98e380c483ead0683bbdebe0217835]

CVE-2024-56712: udmabuf: fix memory leak on last export_udmabuf() error path

stable/6.6 was fixed.

Fixed status
stable/6.6: [e469922fbdf6ad729e5dc8d49289b5036a0ecdf8]

CVE-2024-56742: vfio/mlx5: Fix an unwind issue in mlx5vf_add_migration_pages()

stable/6.6 was fixed.

Fixed status
stable/6.6: [465e06ffbb681f6fe34ca3aeba4b609677c3d4c1]

CVE-2024-57804: scsi: mpi3mr: Fix corrupt config pages PHY state is
switched in sysfs

stable/6.6 was fixed.

Fixed status
stable/6.6: [d7dade716905b189f17cc1601cbb4b421a811a28]

CVE-2024-57809: PCI: imx6: Fix suspend/resume support on i.MX6QDL

stable/6.6 was fixed.

Fixed status
stable/6.6: [30fc8f6d33bb23ce68650148486391847de6cdf3]

CVE-2024-57857: RDMA/siw: Remove direct link to net_device

stable/6.6 was fixed.

Fixed status
stable/6.6: [6a97bfc0293db234ac6ec32f6a32bd6702191a95]

CVE-2024-57974: udp: Deal with race between UDP socket address change and rehash

stable/6.6 was fixed.

Fixed status
stable/6.6: [2855445a1870b8e568fb19edbd60b9c499e3dae0]

CVE-2024-57975: btrfs: do proper folio cleanup when run_delalloc_nocow() failed

stable/6.6 was fixed.

Fixed status
stable/6.6: [545d6893d3a34737d000af103e1557c592075c41]

CVE-2024-57976: btrfs: do proper folio cleanup when cow_file_range() failed

stable/6.6 was fixed.

Fixed status
stable/6.6: [4ace6fb49c8be23b005828763d8b0d0bb0f3b0c5]

CVE-2024-57999: powerpc/pseries/iommu: IOMMU incorrectly marks MMIO range in DDW

stable/6.6 was fixed.

Fixed status
stable/6.6: [57d90fe7aab16f9b10e8646b38f24929015c9538]

CVE-2024-58006: PCI: dwc: ep: Prevent changing BAR size/flags in
pci_epc_set_bar()

stable/6.6 was fixed.

Fixed status
stable/6.6: [01aaa7935af3050fd1e1e7de50001247c75baeab]

CVE-2024-58012: ASoC: SOF: Intel: hda-dai: Ensure DAI widget is valid
during params

stable/6.6 was fixed.

Fixed status
stable/6.6: [2be324c89993c51c9554a84415604be098876d42]

CVE-2024-58074: drm/i915: Grab intel_display from the encoder to avoid
potential oopsies

stable/6.12 was fixed.

Fixed status
stable/6.12: [3a03ef592ef9b900698b46703015f9134721479c]

CVE-2025-21635: rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy

stable/6.6 was fixed.

Fixed status
stable/6.6: [33b3e09a489a31b30342b77cc55290f025d95c7e]

CVE-2025-21650: net: hns3: fixed hclge_fetch_pf_reg accesses bar space
out of bounds issue

stable/6.6 was fixed.

Fixed status
stable/6.6: [a85246635466752b9af72188e4a839541120d952]

CVE-2025-21696: mm: clear uffd-wp PTE/PMD state on mremap()

stable/6.6 was fixed.

Fixed status
stable/6.6: [8e2f6ba256dd1e590addc48e6e9577bf39c482f2]

CVE-2025-21714: RDMA/mlx5: Fix implicit ODP use after free

stable/6.6 was fixed.

Fixed status
stable/6.6: [a306dfff6b76aafa264ad33874a8992a8d5858b7]

CVE-2025-21722: nilfs2: do not force clear folio if buffer is referenced

stable/6.6 was fixed.

Fixed status
stable/6.6: [8458c686d50a804611b97038dd6e75a474ac2221]

CVE-2025-21723: scsi: mpi3mr: Fix possible crash when setting up bsg fails

stable/6.6 was fixed.

Fixed status
stable/6.6: [bf66ec718e68767f6d463617adaf021963678803]

CVE-2025-21729: wifi: rtw89: fix race between cancel_hw_scan and
hw_scan completion

stable/6.6 was fixed.

Fixed status
stable/6.6: [7368f88b2e62d043cd64fe7bdd5c3c2a2f9795b0]

CVE-2025-21768: net: ipv6: fix dst ref loops in rpl, seg6 and ioam6 lwtunnels

stable/6.6 was fixed.

Fixed status
stable/6.6: [e2ef3fa31353b30bda94358fe5205c141289746d]

CVE-2025-21801: net: ravb: Fix missing rtnl lock in suspend/resume path

stable/6.6 was fixed.

Fixed status
stable/6.6: [6105f0d9cc7be8669c2eed24b88b4655d5c35e8c]

CVE-2025-21825: bpf: Cancel the running bpf_timer through kworker for PREEMPT_RT

stable/6.6 was fixed.

Fixed status
stable/6.6: [50e44aa5f9905d237c245b8012937ef4dd971dcb]

CVE-2025-21870: ASoC: SOF: ipc4-topology: Harden loops for looking up
ALH copiers

stable/6.6 was fixed.

Fixed status
stable/6.6: [6b6b47c1aa717a0ed3400e00a81dfea686a41d7f]

CVE-2025-21885: RDMA/bnxt_re: Fix the page details for the srq created
by kernel consumers

stable/6.6 was fixed.

Fixed status
stable/6.6: [d63d73d045e4874b901ab7b1bde05449659355c7]

CVE-2025-21888: RDMA/mlx5: Fix a WARN during dereg_mr for DM type

stable/6.6 was fixed.

Fixed status
stable/6.6: [6e59f56161cccc437d665212d5c3ea3f1c3f5a1f]

CVE-2025-21892: RDMA/mlx5: Fix the recovery flow of the UMR QP

stable/6.6 was fixed.

Fixed status
stable/6.6: [6088e11c9aed12ecc8df465bdd334e60b75999a9]

CVE-2025-21927: nvme-tcp: fix potential memory corruption in nvme_tcp_recv_pdu()

stable/6.6 was fixed.

Fixed status
stable/6.6: [9d22cf5cc94cd7dee84773ec41db78a46107dfa3]

CVE-2025-21961: eth: bnxt: fix truesize for mb-xdp-pass case

stable/6.6 was fixed.

Fixed status
stable/6.6: [924ef5959b7cfbee8f923a77b0ad19b5f0a4d526]

CVE-2025-21972: net: mctp: unshare packets when reassembling

stable/6.6 was fixed.

Fixed status
stable/6.6: [3d0281d0713952e8dd14d6d47e3a9c345c28a3b7]

CVE-2025-21976: fbdev: hyperv_fb: Allow graceful removal of framebuffer

stable/6.6 was fixed.

Fixed status
stable/6.6: [b1a86a5ab0d44160534f495a3630646092d98e27]

CVE-2025-22070: fs/9p: fix NULL pointer dereference on mkdir

stable/6.6 was fixed.

Fixed status
stable/6.6: [b17edabd917142d9ecd058f7c6ee9da5e32af1dd]

CVE-2025-22109: ax25: Remove broken autobind

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [064bc39c23f72efbfbf189786da711d253451033]
stable/6.6: [f364eb60987a55712bcfb9a69235bf3f31bfab5a]

CVE-2025-22113: ext4: avoid journaling sb update on error if journal
is destroying

stable/6.6 was fixed.

Fixed status
stable/6.6: [b6d27f4869c9c4dedce0ba1c719d6c748a4ecc68]

CVE-2025-22115: btrfs: fix block group refcount race in
btrfs_create_pending_block_groups()

stable/6.6 was fixed.

Fixed status
stable/6.6: [77fd40b7ed0c3acf989a0f2a07b15a0a59ea8f96]

CVE-2025-22127: f2fs: fix potential deadloop in prepare_compress_overwrite()

stable/6.6 was fixed.

Fixed status
stable/6.6: [4513843d58d8fa1daebd3817205a15309b146342]

CVE-2025-23132: f2fs: quota: fix to avoid warning in dquot_writeback_dquots()

stable/6.12 was fixed.

Fixed status
stable/6.12: [9ec535db9da76dafa05c89f8b58a0b1d7dddba1c]

CVE-2025-23133: wifi: ath11k: update channel list in reg notifier
instead reg worker

stable/6.6 was fixed.

Fixed status
stable/6.6: [ec97bd5378c594be1f1c7a15dcf381e075b665d9]

CVE-2025-23135: RISC-V: KVM: Teardown riscv specific bits after kvm_exit

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [b7236c52151c91f7b83a42d6ec5728a49e06416f]
stable/6.6: [ce906c4ae572554f4ea4381d7d0a4ab39f5fca5d]

CVE-2025-37743: wifi: ath12k: Avoid memory leak while enabling statistics

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [8319cf3c0f2ed1f1d4c256c0bf605833bc45dbbb]
stable/6.6: [0554373bc9acccfbbc53a7fc5f94e8227a2f2959]

CVE-2025-37746: perf/dwc_pcie: fix duplicate pci_dev devices

stable/6.12 was fixed.

Fixed status
stable/6.12: [0778c3e01a9f382a5bc444a5271e013406642501]

CVE-2025-37747: perf: Fix hang while freeing sigtrap event

stable/6.6 was fixed.

Fixed status
stable/6.6: [aae58a39ac4c63c3fa53536fb2504c9f1d0e1719]

CVE-2025-37750: smb: client: fix UAF in decryption with multichannel

stable/6.6 was fixed.

Fixed status
stable/6.6: [08160de2a65227e5b64fcb6765cd936ec384ee93]

CVE-2025-37759: ublk: fix handling recovery & reissue in ublk_abort_queue()

stable/6.6 was fixed.

Fixed status
stable/6.6: [ab41bf5a211fbec3a85e025658ed90a911ccb692]

CVE-2025-37806: fs/ntfs3: Keep write operations atomic

stable/6.6 was fixed.

Fixed status
stable/6.6: [7af81befc042853949982439f847e25fedef6598]

CVE-2025-37807: bpf: Fix kmemleak warning for percpu hashmap

stable/6.6 was fixed.

Fixed status
stable/6.6: [25014e3dfa6d2fb95c920b9e6b2f0b303baa4533]

CVE-2025-37856: btrfs: harden block_group::bg_list against list_del() races

stable/6.6 was fixed.

Fixed status
stable/6.6: [9039afe6240ae01d6caf2fa731590ac74fb8a69b]

CVE-2025-37860: sfc: fix NULL dereferences in ef100_process_design_param()

stable/6.6 was fixed.

Fixed status
stable/6.6: [a9703b006a475f474a571801ad3dd9b1bda35273]

CVE-2025-37861: scsi: mpi3mr: Synchronous access b/w reset and tm
thread for reply queue

stable/6.6 was fixed.

Fixed status
stable/6.6: [31dad8d385953a886e57df70ab43ee25ba37797c]

CVE-2025-37870: drm/amd/display: prevent hang on link training fail

stable/6.6 was fixed.

Fixed status
stable/6.6: [52cdc47cf6519e2912a34d29b7eeb3f10ca85efa]

CVE-2025-37906: ublk: fix race between io_uring_cmd_complete_in_task
and ublk_cancel_cmd

stable/6.12 was fixed.

Fixed status
stable/6.12: [346b7d74c612234dae0878892682b9722e7c04c8]

CVE-2025-37977: scsi: ufs: exynos: Disable iocc if dma-coherent
property isn't set

stable/6.6 was fixed.

Fixed status
stable/6.6: [b101fc9ac18d1ac434b703839a5117342a591792]

CVE-2025-38029: kasan: avoid sleepable page allocation from atomic context

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [468e7d51dba433a72dcd63eee6db9ad721d39ac5]
stable/6.6: [c33a7fe6dda591694cebfe15abf4644abb4f61c0]

CVE-2025-38041: clk: sunxi-ng: h616: Reparent GPU clock during frequency changes

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [0c4f89f02c72f7cfb98a9a09cae89cc2e39e6017]
stable/6.6: [47a0da0c80749767de1bc0a7a27a69b34c22fbda]

CVE-2025-38042: dmaengine: ti: k3-udma-glue: Drop skip_fdq argument
from k3_udma_glue_reset_rx_chn

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [929995c980da57beeb415744c7c271a9fde80fa9]
stable/6.6: [40d66e0adde4b8ec2fad01f847072af792aeccea]

CVE-2025-38060: bpf: copy_verifier_state() should copy 'loop_entry' field

stable/6.6 was fixed.

Fixed status
stable/6.6: [b7867e55cbcbaed8498b6b96855371eb9afebdc7]

CVE-2025-38064: virtio: break and reset virtio devices on device_shutdown()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [1eaa83fd94ed5e40d43139025f5acb7bcfed3b5f]
stable/6.6: [acdfe206be6c70ec55dc8bfdb1a22036d10fae26]

CVE-2025-38069: PCI: endpoint: pci-epf-test: Fix double free that
causes kernel to oops

stable/6.6 was fixed.

Fixed status
stable/6.6: [761db4ca3a469f2070757acd4e104dff5125ca99]

CVE-2025-38096: wifi: iwlwifi: don't warn when if there is a FW error

stable/6.6 was fixed.

Fixed status
stable/6.6: [20d00e9b5309107b30d882a67639d6fbbfaba36a]

CVE-2025-38132: coresight: holding cscfg_csdev_lock while removing
cscfg from csdev

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [8f16b9caf0bdba46044e1d3727ee78291aa36347]
stable/6.6: [1cd09aaf47a570bf6b05a7cd06b98e9d35fe82c7]

CVE-2025-38137: PCI/pwrctrl: Cancel outstanding rescan work when unregistering

stable/6.12 was fixed.

Fixed status
stable/6.12: [a63ed775f476ba81558bba24d7538836e1ffb823]

CVE-2025-38140: dm: limit swapping tables for devices with zone write plugs

stable/6.12 was fixed.

Fixed status
stable/6.12: [13c0425c99c67c2296f1eec61254a4f91484eac3]

CVE-2025-38178: [REJECTED]: EDAC/igen6: Fix NULL pointer dereference

stable/6.12 was fixed.

Fixed status
stable/6.12: [3eaa9b09455975868783cd011dba5dc9e6e21b87]

CVE-2025-38187: drm/nouveau: fix a use-after-free in r535_gsp_rpc_push()

stable/6.12 was fixed.

Fixed status
stable/6.12: [69270d24af7694494ac4116bcad30a812ca49ca7]

CVE-2025-38199: wifi: ath12k: Fix memory leak due to multiple rx_stats
allocation

stable/6.12 was fixed.

Fixed status
stable/6.12: [2c4b122c75581331177686f68a08981371147d37]

CVE-2025-38207: mm: fix uprobe pte be overwritten when expanding vma

stable/6.12 was fixed.

Fixed status
stable/6.12: [7030046a9b4de8199a3cbc3de20366d95dce2142]

CVE-2025-38261: riscv: save the SR_SUM status over switches

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [9e7005c3638134df5b7df467c1d884a2482c77cb]
stable/6.6: [1b63cdc0d63ae33522b4714642fbefa298acc274]

CVE-2025-38264: nvme-tcp: sanitize request list handling

stable/6.6 was fixed.

Fixed status
stable/6.6: [8f27d152b2a59f443091cf9e3d815f06e32e9b96]

CVE-2025-38272: net: dsa: b53: do not enable EEE on bcm63xx

stable/6.6 was fixed.

Fixed status
stable/6.6: [155bc8f94d52c01c0952acee8156f05f26d81ef6]

CVE-2025-38279: bpf: Do not include stack ptr register in precision
backtracking bookkeeping

stable/6.6 was fixed.

Fixed status
stable/6.6: [2d9a8022009d2d6ad7aaea249902d88f1fa70144]

CVE-2025-38284: wifi: rtw89: pci: configure manual DAC mode via PCI
config API only

stable/6.12 was fixed.

Fixed status
stable/6.12: [7436f230c11acf64543dcb8c2ecbb3e9aa14fc22]

CVE-2025-38292: wifi: ath12k: fix invalid access to memory

stable/6.6 was fixed.

Fixed status
stable/6.6: [920c2db46ca4476c25ec52758441e2e7ab498b0f]

CVE-2025-38303: Bluetooth: eir: Fix possible crashes on eir_create_adv_data

stable/6.6 was fixed.

Fixed status
stable/6.6: [e98ce4b70beab73563d82bd21821024140e6da06]

CVE-2025-38359: s390/mm: Fix in_atomic() handling in do_secure_storage_access()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [7aee3e5163cade3f4cf1cc0710dfbadb47f1ba84]
stable/6.6: [9bcfbd58fc5a02777fed3e582f22503ef3289a43]

CVE-2025-38414: wifi: ath12k: fix GCC_GCC_PCIE_HOT_RST definition for WCN7850

stable/6.6 was fixed.

Fixed status
stable/6.6: [ea2e6c150380021852c1ed2137a104e379a234bb]

CVE-2025-38421: platform/x86/amd: pmf: Use device managed allocations

stable/6.12 was fixed.

Fixed status
stable/6.12: [d6a38e1a82d2f9abd0bae84a354654bccb8389f6]

CVE-2025-38507: HID: nintendo: avoid bluetooth suspend/resume stalls

stable/6.6 was fixed.

Fixed status
stable/6.6: [d3c8519f85b786dcae2498b3496f32e3925e4601]

CVE-2025-38582: RDMA/hns: Fix double destruction of rsv_qp

stable/6.6 was fixed.

Fixed status
stable/6.6: [067ca15be8b8342931536b66206c496e76864ecf]

CVE-2025-38595: xen: fix UAF in dmabuf_exp_from_pages()

stable/6.6 was fixed.

Fixed status
stable/6.6: [ba8bc644f168509c16d48444991de7cfea3f12ec]

CVE-2025-38597: drm/rockchip: vop2: fail cleanly if missing a primary
plane for a video-port

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [8fc974776c668fef1fc73fefbf573a076bb073e8]
stable/6.6: [45be183b9944f765b77623daffb024cb38d192bf]

CVE-2025-38605: wifi: ath12k: Pass ab pointer directly to
ath12k_dp_tx_get_encap_type()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [d9d2a0466e981d1be95fc8bdc05806ea21def758]
stable/6.6: [be27a11a42b2190f817b198bf5e753e5e4ac849e]

CVE-2025-38636: rv: Use strings in da monitors tracepoints

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [665ca03e93cee01baadc7b5eaee21b9d892e0dab]
stable/6.6: [dcae71222c8b9e5b5dd88a2d67347dedf10e68c6]

CVE-2025-38656: wifi: iwlwifi: Fix error code in iwl_op_mode_dvm_start()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [f95598a133a905fd937354ad902773d05593b8b9]
stable/6.6: [5c432da1ee191e9f7830dd516456706063d7bec3]

CVE-2025-38705: drm/amd/pm: fix null pointer access

stable/6.6 was fixed.

Fixed status
stable/6.6: [29a15e06a3d41f60a73a8a0ad7847b11c55f61bf]

CVE-2025-38722: habanalabs: fix UAF in export_dmabuf()

stable/6.6 was fixed.

Fixed status
stable/6.6: [d26058c2349d77d1ef179a2cc9752ca12004b6ff]

CVE-2025-39677: net/sched: Fix backlog accounting in qdisc_dequeue_internal

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [38cdf8d1f5f3ee133f6e48dd422df4057fa9bfcb]
stable/6.6: [dcfed7251e23cd71d32c4ecc444ff97992087e46]

CVE-2025-39705: drm/amd/display: fix a Null pointer dereference vulnerability

stable/6.6 was fixed.

Fixed status
stable/6.6: [0d9f4f202de1522aadc7a827aba0ae92b3d70937]

CVE-2025-39732: wifi: ath11k: fix sleeping-in-atomic in
ath11k_mac_op_set_bitrate_mask()

stable/6.6 was fixed.

Fixed status
stable/6.6: [1f45a710c82b29d4c501b1cb472dff68d59ecc8c]

CVE-2025-39754: mm/smaps: fix race between smaps_hugetlb_range and migration

stable/6.6 was fixed.

Fixed status
stable/6.6: [f76089018b34dbe0c2e9b67c5b7d8860668748bb]

CVE-2025-39775: mm/mremap: fix WARN with uffd that has remap events disabled

stable/6.12 was fixed.

Fixed status
stable/6.12: [1c15b4cd3a97aea013bdb18d9a55ca0384fbb8d4]

CVE-2025-39789: crypto: x86/aegis - Add missing error checks

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [b4ba650125d21e937f82fcafcd2738fe31209c05]
stable/6.6: [74d3b91f1598eedf87a977702f9f55e32698206d]

CVE-2025-39810: bnxt_en: Fix memory corruption when FW resources
change during ifdown

stable/6.6 was fixed.

Fixed status
stable/6.6: [dc797a4bbbcac6d19e6e2508e4df685755cd94a5]

CVE-2025-39829: trace/fgraph: Fix the warning caused by missing
unregister notifier

stable/6.6 was fixed.

Fixed status
stable/6.6: [aa977309397fe2438801b1ca1ce7bc4106d8e985]

CVE-2025-39830: net/mlx5: HWS, Fix memory leak in hws_pool_buddy_init error path

stable/6.12 was fixed.

Fixed status
stable/6.12: [4ccdbf50dd88a2a7399409e68887dd8077f6a562]

CVE-2025-39834: net/mlx5: HWS, Fix memory leak in
hws_action_get_shared_stc_nic error flow

stable/6.12 was fixed.

Fixed status
stable/6.12: [a2751e1af5dc8b1a64cfd463576c58617c2573ac]

CVE-2025-39850: vxlan: Fix NPD in {arp,neigh}_reduce() when using
nexthop objects

stable/6.6 was fixed.

Fixed status
stable/6.6: [8ba034c41b20dc4f32ece748f1429709ae8ceedc]

CVE-2025-39851: vxlan: Fix NPD when refreshing an FDB entry with a
nexthop object

stable/6.6 was fixed.

Fixed status
stable/6.6: [18e4b315e359fa0505eee318a0cb745240122e2f]

CVE-2025-39859: ptp: ocp: fix use-after-free bugs causing by ptp_ocp_watchdog

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [aad70bdfc8244616e48c434310cab241a3f17781]
stable/6.6: [e2a6eabe5304a789b7d40ce2576cd80154255e51]

CVE-2025-39862: wifi: mt76: mt7915: fix list corruption after hardware restart

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [6826728f9fd7e7db57cd9647932eea47cbc645c6]
stable/6.6: [6d40c15d70c2dba2f68dd50e452255bfa1b016f0]

CVE-2025-39878: ceph: fix crash after fscrypt_encrypt_pagecache_blocks() error

stable/6.12 was fixed.

Fixed status
stable/6.12: [4a918f04cf97b2436a8dfe5cb51bb33f8e8831f4]

CVE-2025-39879: ceph: always call ceph_shift_unused_folios_left()

stable/6.12 was fixed.

Fixed status
stable/6.12: [523214f0afa1b3d0e696917bc5a4d0737718e3d7]

CVE-2025-39910: mm/vmalloc, mm/kasan: respect gfp mask in
kasan_populate_vmalloc()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [aa1b4b7a1b92743297f9da741424df4703a8e11b]
stable/6.6: [9598c83a50a5f9d57fd0c12fc08d9425c1ce9537]

CVE-2025-39921: spi: microchip-core-qspi: stop checking viability of
op->max_freq in supports_op callback

stable/6.12 was fixed.

Fixed status
stable/6.12: [4ad071e3d57967f7ab483aed0687468bc1d9e9ce]

CVE-2025-39927: ceph: fix race condition validating r_parent before
applying state

stable/6.6 was fixed.

Fixed status
stable/6.6: [dc5aad078abc416dd3d555c50f5308c16ba918a7]

CVE-2025-39933: smb: client: let recv_done verify data_offset,
data_length and remaining_data_length

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [241e58de23e7c1bbb9bee526c17d9a0f2a90fbad]
stable/6.6: [f23d5c6b7540ec9b1e73a8ea3b2ae9045248d728]

CVE-2025-39940: dm-stripe: fix a possible integer overflow

stable/6.6 was fixed.

Fixed status
stable/6.6: [891ab8c6954199e4f36029b49df86c8b1d6b0b2f]

CVE-2025-39948: ice: fix Rx page leak on multi-buffer frames

stable/6.6 was fixed.

Fixed status
stable/6.6: [8729dc4eeb502145418db5f2ca2192fd26f3efda]

CVE-2025-39958: iommu/s390: Make attach succeed when the device was
surprise removed

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [79fa3a19aa6114189b33e2ba1f393b0f635d7544]
stable/6.6: [3b32cf6e279597d1b6477fb89d46abf65263c139]

CVE-2025-39990: bpf: Check the helper function is valid in get_helper_proto

stable/6.6 was fixed.

Fixed status
stable/6.6: [dfbff47f120e4b0793ca0e0b8660361ccac25a74]

CVE-2025-40003: net: mscc: ocelot: Fix use-after-free caused by cyclic
delayed work

stable/6.6 was fixed.

Fixed status
stable/6.6: [c4672bdc4730d28ee8d9f65386599298047c045e]

CVE-2025-40057: ptp: Add a upper bound on max_vclocks

stable/6.6 was fixed.

Fixed status
stable/6.6: [da513f2ad1b1b1cf1880ccc2603ce1f1f818eb2e]

CVE-2025-40065: RISC-V: KVM: Write hgatp register with valid mode bits

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [5cba8ae00279296a586d0596443109d601b1d116]
stable/6.6: [8b6e327736db013b9e385c3f6f9f0b04ddf26e43]

CVE-2025-40075: tcp_metrics: use dst_dev_net_rcu()

stable/6.6 was fixed.

Fixed status
stable/6.6: [7012bea5622396b37566fbdc059f7c6a6c279d74]

CVE-2025-40086: drm/xe: Don't allow evicting of BOs in same VM in
array of VM binds

stable/6.12 was fixed.

Fixed status
stable/6.12: [d21087d083e6f324d69ee87c872a4cbb5bc4a48c]

CVE-2025-40113: remoteproc: qcom: pas: Shutdown lite ADSP DTB on X1E

stable/6.12 was fixed.

Fixed status
stable/6.12: [ce536b90fc6a32629577f81db333f39ebacef0cb]

CVE-2025-40130: scsi: ufs: core: Fix data race in CPU latency PM QoS
request handling

stable/6.12 was fixed.

Fixed status
stable/6.12: [eee1b13526b8f1e6a2402973d95f9fa854771f57]

CVE-2025-40136: crypto: hisilicon/qm - request reserved interrupt for
virtual function

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [24315474ca913c0693939ab74b389ee04c7d3020]
stable/6.6: [5f75857ed634d04266301d7a4f695a7deeb9bfdc]


CVE-2025-40170: net: use dst_dev_rcu() in sk_setup_caps()

stable/6.6 was fixed.

Fixed status
stable/6.6: [9f22b5f7f1a32f8bbcc82bf34e34ea63523fcd02]

CVE-2025-40180: mailbox: zynqmp-ipi: Fix out-of-bounds access in
mailbox cleanup loop

stable/6.6 was fixed.

Fixed status
stable/6.6: [47a92030422d09c2de0633d23f660a65b717f008]

CVE-2025-40213: Bluetooth: MGMT: fix crash in set_mesh_sync and
set_mesh_complete

stable/6.6 was fixed.

Fixed status
stable/6.6: [31d6c9216aa1be18ba317239738f73b0b0c7b691]

CVE-2025-40289: drm/amdgpu: hide VRAM sysfs attributes on GPUs without VRAM

stable/6.6 was fixed.

Fixed status
stable/6.6: [3d608e67b966c3074c432db626bb23c350c112d7]

CVE-2025-40325: md/raid10: wait barrier before returning discard
request with REQ_NOWAIT

stable/6.6 was fixed.

Fixed status
stable/6.6: [29c742ff222dd39335b927a6909c23b8752a053c]

CVE-2025-40338: ASoC: Intel: avs: Do not share the name pointer
between components

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [a80a82f567f7c6276d96409377d4691ea30d18a2]
stable/6.6: [0a187ea7a5b4e78b9be1f9c1507cff04f3ae4ab1]

CVE-2025-40355: sysfs: check visibility before changing group
attribute ownership

stable/6.12 was fixed.

Fixed status
stable/6.12: [5e963b5aca9c1c23f7a040d555a9bc21c0ab8819]

CVE-2025-68174: amd/amdkfd: enhance kfd process check in switch partition

stable/6.12 was fixed.

Fixed status
stable/6.12: [3385a1def2df45ac04a70532dfcd20d9eeac9fbb]

CVE-2025-68175: media: nxp: imx8-isi: Fix streaming cleanup on release

stable/6.6 was fixed.

Fixed status
stable/6.6: [6776866cffbc243de4255f7c31a367d7cb8e6f4d]

CVE-2025-68188: tcp: use dst_dev_rcu() in
tcp_fastopen_active_disable_ofo_check()

stable/6.6 was fixed.

Fixed status
stable/6.6: [e61dfd906ad027a4ade1f89e5fe706a3fcd52527]

CVE-2025-68193: drm/xe/guc: Add devm release action to safely tear down CT

stable/6.12 was fixed.

Fixed status
stable/6.12: [fd4e41545d5955e6f7b4a0c4b56d21010ce8e812]

CVE-2025-68201: drm/amdgpu: remove two invalid BUG_ON()s

stable/6.6 was fixed.

Fixed status
stable/6.6: [b68d1f321119b83ca58edd1365c44453b4047c91]

CVE-2025-68209: mlx5: Fix default values in create CQ

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [a39d334c9840705af69f0466f8f0129c366004ca]
stable/6.6: [1a7865e3e4de2830d8a9fe8c273dc10b248b7338]

CVE-2025-68230: drm/amdgpu: fix gpu page fault after hibernation on PF
passthrough

stable/6.6 was fixed.

Fixed status
stable/6.6: [f0ee42f47cc1b0a95d2d22ba352ff89fc0cd13d4]

CVE-2025-68236: scsi: ufs: ufs-qcom: Fix UFS OCP issue during UFS
power down (PC=3)

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [0c2619d1da8bd3d18524d69f12571a8cd7362833]
stable/6.6: [1c963811b0824d0f51aabd394986589a2126f341]

CVE-2025-68251: erofs: avoid infinite loops due to corrupted subpage
compact indexes

stable/6.6 was fixed.

Fixed status
stable/6.6: [b18a82503a67a530d48f5a5b429e162749fe2c89]

CVE-2025-68311: tty: serial: ip22zilog: Use platform device for probing

stable/6.6 was fixed.

Fixed status
stable/6.6: [2eb6a5f6adb7d494962a1d1995c47dbbc13a8460]

CVE-2025-68318: clk: thead: th1520-ap: set all AXI clocks to CLK_IS_CRITICAL

stable/6.12 was fixed.

Fixed status
stable/6.12: [d816c00bb69fb2eecd3fccac067857f3a0dbc44e]

CVE-2025-68319: netconsole: Acquire su_mutex before navigating configs hierarchy

stable/6.12 was fixed.

Fixed status
stable/6.12: [932c0c7a7ec413399febca5fe3dddf913bb5c924]

CVE-2025-68324: scsi: imm: Fix use-after-free bug caused by unfinished
delayed work

stable/6.6 was fixed.

Fixed status
stable/6.6: [9a8e53154353580d53f7f86a253927e41294017e]

CVE-2025-68353: net: vxlan: prevent NULL deref in vxlan_xmit_one

stable/6.12 was fixed.

Fixed status
stable/6.12: [333deb6b43c11d5bce00463b364ac993d2fa02a6]

CVE-2025-68356: gfs2: Prevent recursive memory reclaim

stable/6.6 was fixed.

Fixed status
stable/6.6: [66eb53cecc5f83183535bbfb2fa6464322049b61]

CVE-2025-68359: btrfs: fix double free of qgroup record after failure
to add delayed ref head

stable/6.12 was fixed.

Fixed status
stable/6.12: [82d46660ebd94c269e3f25a77eb563621d8e67e3]

CVE-2025-68360: wifi: mt76: wed: use proper wed reference in mt76 wed
driver callabacks

stable/6.12 was fixed.

Fixed status
stable/6.12: [369cdd236970f7ad95e47eb2d43dbc759288a636]

CVE-2025-68368: md: init bioset in mddev_init

stable/6.12 was fixed.

Fixed status
stable/6.12: [903fb4851ee8d291372d285f616c398a9c4cbbec]

CVE-2025-68374: md: fix rcu protection in md_wakeup_thread

stable/6.6 was fixed.

Fixed status
stable/6.6: [dc6d1249ee35c1c76700b4b96281daeb7637bce1]

CVE-2025-68376: coresight: ETR: Fix ETR buffer use-after-free issue

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [4e83434247ff8005a0b9a1ee997864abf8f259ec]
stable/6.6: [5d5d130835b417c7bfd6c942f0149e34397d4463]

CVE-2025-68378: bpf: Fix stackmap overflow check in __bpf_get_stackid()

stable/6.6 was fixed.

Fixed status
stable/6.6: [d6028caa0ee39dccd005468adfa3223b92bd3ad3]

CVE-2025-68729: wifi: ath12k: Fix MSDU buffer types handling in RX error path

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [17a9b93283c6f0b799a338bbc50fa115012429d9]
stable/6.6: [abfbceda0d2391524ad1df88867b3f3af36d17c7]

CVE-2025-68730: accel/ivpu: Fix page fault in
ivpu_bo_unbind_all_bos_from_context()

stable/6.12 was fixed.

Fixed status
stable/6.12: [9ad57ebd1249c7bbfe9a07ff5e0176dfa320cd62]

CVE-2025-68735: drm/panthor: Prevent potential UAF in group creation

stable/6.12 was fixed.

Fixed status
stable/6.12: [c6bbec068a9accd6f1df05f3df9a5254c99292ee]

CVE-2025-68745: scsi: qla2xxx: Clear cmds after chip reset

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [c82c0fbb97d0fd44324eb55ab758408c7c964b32]
stable/6.6: [0d0a1a267c1ee7c41aeffdca84afcb113787a91a]

CVE-2025-68755: staging: most: remove broken i2c driver

stable/6.12 was fixed.

Fixed status
stable/6.12: [10d50bc913b69fa18a5c6fbf293c7a87962e22ef]

CVE-2025-68822: Input: alps - fix use-after-free bugs caused by
dev3_register_work

stable/6.6 was fixed.

Fixed status
stable/6.6: [b9d8cfd6d77f5072a4df10646810d128220457fb]

CVE-2025-71072: shmem: fix recovery on rename failures

stable/6.6 was fixed.

Fixed status
stable/6.6: [8fdbc6f9a994eb327868a4aa74a58953f31a2d0f]

CVE-2025-71073: Input: lkkbd - disable pending work before freeing device

stable/6.6 was fixed.

Fixed status
stable/6.6: [8cf889d45bbc8477206dda78c8f757ea8ff68213]

CVE-2025-71074: functionfs: fix the open/removal races

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [75240e5e51c6e6d67a3039384125fa54259a3926]
stable/6.6: [585a656283c954337036422afcd9cb70dd4135e7]

CVE-2025-71109: MIPS: ftrace: Fix memory corruption when kernel is
located beyond 32 bits

stable/6.6 was fixed.

Fixed status
stable/6.6: [9cfda98cf02eacfa6b09076e98bd479fd73407c2]

CVE-2025-71141: drm/tilcdc: Fix removal actions in case of failed probe

stable/6.12 was fixed.

Fixed status
stable/6.12: [28138ea7180c382b449ba9dce12fdec68880dea4]

CVE-2025-71225: md: suspend array while updating raid_disks via sysfs

stable/6.6 was fixed.

Fixed status
stable/6.6: [863b9b7be824a6b2c0587532d3ece3022c6dd451]

CVE-2025-71227: wifi: mac80211: don't WARN for connections on invalid channels

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [579cf5939f8f4c4f88c75862d0c573fb13567b74]
stable/6.6: [c02b1d244a5d799696ca74d3fba6539c8d76195f]

CVE-2025-71272: most: core: fix resource leak in
most_register_interface error paths

stable/6.6 was fixed.

Fixed status
stable/6.6: [82f42a13e3d7a07a950ee4fa2d4c74843a3e7ace]

CVE-2025-71273: wifi: rtw88: Use devm_kmemdup() in rtw_set_supported_band()

stable/6.6 was fixed.

Fixed status
stable/6.6: [d57e31c8df7b8bb684c6b56854676972a8b7c8ed]

CVE-2025-71285: net: qrtr: Drop the MHI auto_queue feature for IPCR DL channels

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [8e130ff078892fa5a6bf272ced7565af58d98a85]
stable/6.6: [ab0bdaf7a7f4f83b947193563f2a483ab87f72db]

CVE-2025-71306: ima: Fix stack-out-of-bounds in is_bprm_creds_for_exec()

stable/6.18 was fixed.

Fixed status
stable/6.18: [0f39d936a34933ebfbdc13a04f0aba814d3b9709]


CVE-2026-100072: ACPI: platform: Use acpi_bus_get_primary_device()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [527a497fb2ef77a95170eefe2007e2c4c957bd2c]
stable/6.6: [a75e5de593ef158feb17989bff7730c5a3d82503]

CVE-2026-100074: bpf: Mark bpf_refcount field as unique

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [20b3c72c1b83054c568d2322a95e217fdc281bc3]
stable/6.6: [015f9fbcf3382c5eb563a157ee8cabb6fbfcfe5e]

CVE-2026-100076: staging: rtl8723bs: fix xmit_frame/xmit_buf leaks on
mgnt-frame error paths

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [2f5e2752c2b4bad01df4523cfe2b41b702c60f00]
stable/6.6: [17260b5215d4ced17a733e2c027a76290e476fad]

CVE-2026-100077: drm/msm: Recover HW before retire hung submit

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [2f021d93f15829ba052ff22bc40df0ec3ae7c7ab]
stable/6.6: [d4bee74b7cb93e40c60b43dc9dc0c3aab444649f]

CVE-2026-13087: A heap out-of-bounds write vulnerability was found in
the Linux kernel's
RPC-over-RDMA server reply path in net/sunrpc/xprtrdma/svc_rdma_sendto.c.
When a crafted RPC-over-RDMA client sends a large NFS READ request with an
empty Write list and no Reply chunk, the server linearizes the entire
multi-page reply into a fixed-size 4096-byte heap buffer without bounds
checking, resulting in a kernel heap overflow. This can lead to denial of
service via kernel crash or potential code execution through corruption of
adjacent kernel heap objects.

stable/6.6 was fixed.

Fixed status
stable/6.6: [8068358f445a11296328ffa7c524701596814a17]

CVE-2026-22996: net/mlx5e: Don't store mlx5e_priv in mlx5e_dev devlink priv

stable/6.6 was fixed.

Fixed status
stable/6.6: [7b3b902320214835013ce625053b0743a71c804c]

CVE-2026-23007: block: zero non-PI portion of auto integrity buffer

stable/6.12 was fixed.

Fixed status
stable/6.12: [765bf0a5880777c04ae98fc2a9f3b995737b3a64]

CVE-2026-23017: idpf: fix error handling in the init_task on load

stable/6.12 was fixed.

Fixed status
stable/6.12: [f32ae3cfc976074e9c5927893ce49bcf12f53748]

CVE-2026-23035: net/mlx5e: Pass netdev to mlx5e_destroy_netdev instead of priv

stable/6.6 was fixed.

Fixed status
stable/6.6: [444b0e44aa43081d4ddd138575e5a2dcabf439c7]

CVE-2026-23137: of: unittest: Fix memory leak in unittest_data_add()

stable/6.6 was fixed.

Fixed status
stable/6.6: [4c7ad40c285ab85e3614433e063f14aac2e2fe17]

CVE-2026-23143: virtio_net: Fix misalignment bug in struct virtnet_info

stable/6.12 was fixed.

Fixed status
stable/6.12: [d1e9614a142eff34c93e94a15a71ad0e806799c4]

CVE-2026-23207: spi: tegra210-quad: Protect curr_xfer check in IRQ handler

stable/6.6 was fixed.

Fixed status
stable/6.6: [513587caec66b67243027f26867ad3512f06744f]

CVE-2026-23208: ALSA: usb-audio: Prevent excessive number of frames

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [81e4b0009f2acc841d77a24fd796528b0bf62c4e]
stable/6.6: [152fc4f7b4a8af1c0418d2722f3b2729799cc837]

CVE-2026-23213: drm/amd/pm: Disable MMIO access during SMU Mode 1 reset

stable/6.6 was fixed.

Fixed status
stable/6.6: [b2b9ac2bb2c5b5b0a39f7f422bbe12d3ea4ccf34]

CVE-2026-23214: btrfs: reject new transactions if the fs is fully read-only

stable/6.6 was fixed.

Fixed status
stable/6.6: [34614f5dd26c8257aafcdaf1053a797289359664]

CVE-2026-23217: riscv: trace: fix snapshot deadlock with sbi ecall

stable/6.12 was fixed.

Fixed status
stable/6.12: [f8b8ec0ddde74066d4452a7a961da544f193e00f]

CVE-2026-23226: ksmbd: add chann_lock to protect ksmbd_chann_list xarray

stable/6.6 was fixed.

Fixed status
stable/6.6: [43ad494ac6e940a8eabf25d5bd77bb3bb53b1153]

CVE-2026-23247: tcp: secure_seq: add back ports to TS offset

stable/6.6 was fixed.

Fixed status
stable/6.6: [e873e8c16b2fb743a381a9e59c108e63512301ec]

CVE-2026-23259: io_uring/rw: free potentially allocated iovec on cache
put failure

stable/6.12 was fixed.

Fixed status
stable/6.12: [41cda4c66846c3bfcdeaf28444ccabbb55e64cf1]

CVE-2026-23276: net: add xmit recursion limit to tunnel xmit functions

stable/6.6 was fixed.

Fixed status
stable/6.6: [da5f0166cef3d4285ddbb1b638661263fc03ee92]

CVE-2026-23327: cxl/mbox: validate payload size before accessing
contents in cxl_payload_from_user_allowed()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [483b7eb4b1b2a03235afe1b274732dcf8231d4ec]
stable/6.6: [3555e41737c0f8b5b53a511573661477e3942dee]

CVE-2026-23361: PCI: dwc: ep: Flush MSI-X write before unmapping its ATU entry

stable/6.6 was fixed.

Fixed status
stable/6.6: [5e2fc90018635fc982d39f8c11cd3b368fdaf3b7]

CVE-2026-23371: sched/deadline: Fix missing ENQUEUE_REPLENISH during
PI de-boosting

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [65af3633caf195d397ec4c39f51ae7615bd5a627]
stable/6.6: [ce6253fe718811cceb3a0ae0dbf0a5941dea3eb6]

CVE-2026-23377: ice: change XDP RxQ frag_size from DMA write length to
xdp.frame_sz

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [6aed180a44b1c0a3971107fa052a41b03acdb31e]
stable/6.6: [f2b29bbe355221a65c3eccf9500e5e33e4f1cb5c]

CVE-2026-23383: bpf, arm64: Force 8-byte alignment for JIT buffer to
prevent atomic tearing

stable/6.6 was fixed.

Fixed status
stable/6.6: [f5a41b61b5faae1965a5a2cb55322fe8f17e3b2d]

CVE-2026-23385: netfilter: nf_tables: clone set on flush only

stable/6.12 was fixed.

Fixed status
stable/6.12: [454306ceb94dc47a52443181082c91204c007a74]

CVE-2026-23459: ip_tunnel: adapt iptunnel_xmit_stats() to
NETDEV_PCPU_STAT_DSTATS

stable/6.6 was fixed.

Fixed status
stable/6.6: [127c5e6e2d6fa8185314537c08204ec3515eae99]

CVE-2026-23472: serial: core: fix infinite loop in handle_tx() for PORT_UNKNOWN

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [d45cfa70bf0159afb31cb03d2d16ec5a5053460c]
stable/6.6: [c9e845014723d552944cec4e146ec7b841cda34d]

CVE-2026-31410: ksmbd: use volume UUID in FS_OBJECT_ID_INFORMATION

stable/6.6 was fixed.

Fixed status
stable/6.6: [1df0123f96f377282feaae24d8e561fff4a6541f]

CVE-2026-31462: drm/amdgpu: prevent immediate PASID reuse case

stable/6.6 was fixed.

Fixed status
stable/6.6: [f69491478e3de0e3c6aac2ee89b3cda3f2471301]

CVE-2026-31487: spi: use generic driver_override infrastructure

stable/6.6 was fixed.

Fixed status
stable/6.6: [6e8eb467bed6aa1a563dba8f366c9fd76ba0004e]

CVE-2026-31493: RDMA/efa: Fix use of completion ctx after free

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [7ba09d85f177e9f5f64b881f33dbcb57b2cf23d5]
stable/6.6: [8c24b5179af260a5f36571c992d29aab1f448544]

CVE-2026-31505: iavf: fix out-of-bounds writes in iavf_get_ethtool_stats()

stable/6.6 was fixed.

Fixed status
stable/6.6: [d5dcca707f56c46582486d783c1eca2323189111]

CVE-2026-31506: net: bcmasp: fix double free of WoL irq

stable/6.6 was fixed.

Fixed status
stable/6.6: [c5e2de193831ab9610a1ca542507f75d126f09b5]

CVE-2026-31526: bpf: Fix exception exit lock checking for subprogs

stable/6.12 was fixed.

Fixed status
stable/6.12: [4eca06a55417c3b2e538656d12c89e224343653e]

CVE-2026-31530: cxl/port: Fix use after free of parent_port in cxl_detach_ep()

stable/6.6 was fixed.

Fixed status
stable/6.6: [b1f62588ab1be6c9535d74348003c86b47ec4abd]

CVE-2026-31531: ipv4: nexthop: allocate skb dynamically in rtm_get_nexthop()

stable/6.6 was fixed.

Fixed status
stable/6.6: [18a4543c1750f96be63e349936d2dfdcb360b2dc]

CVE-2026-31557: nvmet: move async event work off nvmet-wq

stable/6.6 was fixed.

Fixed status
stable/6.6: [a8a3fb2888e2c4fd5410a19ac1623cc78a2383ec]

CVE-2026-31560: spi: spi-dw-dma: fix print error log when wait finish
transaction

stable/6.6 was fixed.

Fixed status
stable/6.6: [bac13309339b6f1ac02e6e53ebc75cf61483c396]

CVE-2026-31562: drm/mediatek: dsi: Store driver data before invoking
mipi_dsi_host_register

stable/6.12 was fixed.

Fixed status
stable/6.12: [57b4864ca02f76d7debe8ce14c912335aef16055]

CVE-2026-31568: s390/mm: Add missing secure storage access fixups for
donated memory

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [74ccc099f1baa9236b8fb600406457a0870c83a9]
stable/6.6: [1eb35c54cd81cf874ce7d69e3dbfb162f211b8bd]

CVE-2026-31579: wireguard: device: use exit_rtnl callback instead of
manual rtnl_lock in pre_exit

stable/6.12 was fixed.

Fixed status
stable/6.12: [707607db2193591b68c0e70f814133472c185b1e]

CVE-2026-31592: KVM: SEV: Protect *all* of
sev_mem_enc_register_region() with kvm->lock

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [25c85d5831201391fb920d51067c6d93cce55348]
stable/6.6: [777a8ebd2da3529a455af022ed929408fdbb161f]

CVE-2026-31606:  usb: gadget: f_hid: don't call cdev_init while cdev in use

stable/6.6 was fixed.

Fixed status
stable/6.6: [3aa77f5da0ecb00895411f4246d8a3e4db0343c2]

CVE-2026-31630: rxrpc: proc: size address buffers for %pISpc output

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [a6042b8066b24dbcc7945616a157d4d43e463668]
stable/6.6: [808a34cdbe8ce336c202d8ea6d5e48496764dc37]

CVE-2026-31645: net: lan966x: fix page pool leak in error paths

stable/6.6 was fixed.

Fixed status
stable/6.6: [a229a4dc87302fa131f3394b09b0efd8c255a5ac]

CVE-2026-31650: mmc: vub300: fix use-after-free on disconnect

stable/6.12 was fixed.

Fixed status
stable/6.12: [4b5251eebc2b1dedbb33fedf1b1109fea161b846]

CVE-2026-31663: xfrm: hold dev ref until after transport_finish NF_HOOK

stable/6.6 was fixed.

Fixed status
stable/6.6: [94439cbe478b53f92223da9aae95fffb28623c3f]

CVE-2026-31677: crypto: af_alg - limit RX SG extraction by receive buffer budget

stable/6.6 was fixed.

Fixed status
stable/6.6: [7e345de2e69475430af85e09210795d8eb8e719c]

CVE-2026-31706: ksmbd: validate num_aces and harden ACE walk in
smb_inherit_dacl()

stable/6.6 was fixed.

Fixed status
stable/6.6: [ad7d18df7423c522ed9dc7e33bd5d54c66b1bc37]

CVE-2026-31722: usb: gadget: f_rndis: Fix net_device lifecycle with device_move

stable/6.6 was fixed.

Fixed status
stable/6.6: [9701a98f4459b52558f683b6b12a6feb6f17b255]

CVE-2026-31723: usb: gadget: f_subset: Fix net_device lifecycle with device_move

stable/6.6 was fixed.

Fixed status
stable/6.6: [edb08047051883591517feb5a51bf2bfd2b769fb]

CVE-2026-31724: usb: gadget: f_eem: Fix net_device lifecycle with device_move

stable/6.6 was fixed.

Fixed status
stable/6.6: [b1d854462510f7b7c504bfd5f8ec19c0737ed5e4]

CVE-2026-31725: usb: gadget: f_ecm: Fix net_device lifecycle with device_move

stable/6.6 was fixed.

Fixed status
stable/6.6: [fdc3aa4c23d3e0ed781ca0e10213c645e445cc03]

CVE-2026-31746: s390/zcrypt: Fix memory leak with CCA cards used as accelerator

stable/6.12 was fixed.

Fixed status
stable/6.12: [1650268579e1113b30402dbcca4dba6589a0fccf]

CVE-2026-31767: drm/i915/dsi: Don't do DSC horizontal timing
adjustments in command mode

stable/6.6 was fixed.

Fixed status
stable/6.6: [481f7a463ae4bea9503ae7fa1481ad75dc872af4]

CVE-2026-43009: bpf: Fix incorrect pruning due to atomic fetch
precision tracking

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [7c72e5f3741d1c5cc53439137162f0e09254e6e9]
stable/6.6: [1aac6b271e0a80b91c2f6a8f75ab0c0b1fc8ffe8]

CVE-2026-43034: bnxt_en: set backing store type from query type

stable/6.12 was fixed.

Fixed status
stable/6.12: [c66a27ca534580de1d28cf568f59fe5f50d43e15]

CVE-2026-43036: net: use skb_header_pointer() for TCPv4 GSO frag_off check

stable/6.6 was fixed.

Fixed status
stable/6.6: [5057502630fbc8ce468ff617ff59af275960b537]

CVE-2026-43042: mpls: add seqcount to protect the platform_label{,s} pair

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [8adc5b6fc876928d8c95555d30b66fa50b07421e]
stable/6.6: [0d377825548fe598595b5a5fa4a309fb593d8fb4]

CVE-2026-43048: HID: core: Mitigate potential OOB by removing bogus memset()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [b37e6019fe420335d884e30535549a25f084e00d]
stable/6.6: [218b93b7e284de1aa40a53f8f130f84f7da38858]

CVE-2026-43049: HID: logitech-hidpp: Prevent use-after-free on force
feedback initialisation failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [df966f0def87550bd81d0892cdff992202de2712]

CVE-2026-43053: xfs: close crash window in attr dabtree inactivation

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [190d54d1d42878fce8c735c2d9ac835725694d3a]
stable/6.18: [7ea3850b9ce005e70f502b308edb2d99ca074ed3]

CVE-2026-43059: Bluetooth: MGMT: Fix list corruption and UAF in
command complete handlers

stable/6.6 was fixed.

Fixed status
stable/6.6: [3d6de8467236cd763ddc7d06127689bdfbfbd8ff]

CVE-2026-43073: x86-64: rename misleadingly named
'__copy_user_nocache()' function

stable/6.6 was fixed.

Fixed status
stable/6.6: [73c2dc2c14d6a2efa5dde469546a907482af07fe]

CVE-2026-43083: net: ioam6: fix OOB and missing lock

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [f1af9d19503b73011dae5051c354fd39b03e240d]
stable/6.6: [a05a85779c2574b6534abb8cdc6d65fbc2e91208]

CVE-2026-43101: ipv6: ioam: fix potential NULL dereferences in
__ioam6_fill_trace_data()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [f87aa5d1a7f56727a768757613a303b4245444a1]
stable/6.6: [34b8390ac0ba57004b90ea568ac06f50bf896a80]

CVE-2026-43107: xfrm: account XFRMA_IF_ID in aevent size calculation

stable/6.6 was fixed.

Fixed status
stable/6.6: [f8f3bb89ab677db15f9f5250c77af728f9afe995]

CVE-2026-43118: btrfs: fix zero size inode with non-zero size after log replay

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [91990732ec4ce5c09361d498c6d621f5a76ee1f2]
stable/6.6: [c939bfa67d221f75351a5bf2fc912e8125547b7e]

CVE-2026-43125: dlm: validate length in dlm_search_rsb_tree

stable/6.6 was fixed.

Fixed status
stable/6.6: [2deafd015ea9a0e75ee5764e20eb1e16bd73efd8]

CVE-2026-43126: ALSA: mixer: oss: Add card disconnect checkpoints

stable/6.6 was fixed.

Fixed status
stable/6.6: [20c52a70414095447da1be076f492cc7a6dce7cf]

CVE-2026-43127: ntfs3: fix circular locking dependency in run_unpack_ex

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [76016d15bbd90caa0ce7765fddf9bde8e943e601]
stable/6.6: [d60f09d2d16c44a797d8cb67015cde2508720506]

CVE-2026-43153: xfs: remove xfs_attr_leaf_hasname

stable/6.6 was fixed.

Fixed status
stable/6.6: [759e44a6cba8e81d945ffc269a326ec39e7f54f5]

CVE-2026-43172: wifi: iwlwifi: fix 22000 series SMEM parsing

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [b23c7cd616a6a113363be707b7b9e4bc41b18a07]
stable/6.6: [5cc021586420c5e13acc65da5bf73edd451e2c3e]

CVE-2026-43185: ksmbd: fix signededness bug in smb_direct_prepare_negotiation()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [a110dbe928561d440e9e117d17331139a0bedace]
stable/6.6: [56eab82fa6fb5ca024b0514e249d40d9b23ee5a7]

CVE-2026-43197: netconsole: avoid OOB reads, msg is not nul-terminated

stable/6.6 was fixed.

Fixed status
stable/6.6: [68fe91df6ea822dae772fceaad0686e4f5839aec]

CVE-2026-43199: net/mlx5e: Fix "scheduling while atomic" in IPsec MAC
address query

stable/6.6 was fixed.

Fixed status
stable/6.6: [5efde07521309274f26727860774614cbc187242]

CVE-2026-43213: wifi: rtw89: pci: validate sequence number of TX release report

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [0fe36044267c3c70d0471d2109c34f805c975154]
stable/6.6: [c0da84e308a0b0b51cd234168a9d84be4a3c5c50]

CVE-2026-43234: team: avoid NETDEV_CHANGEMTU event when unregistering slave

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [dde2fa2a658802d0ff03cd4a0e7d4a5459ef18de]
stable/6.6: [1cf0ef73991880dd89aa1feaf547ab13e4767b85]

CVE-2026-43244: kcm: fix zero-frag skb in frag_list on partial sendmsg error

stable/6.6 was fixed.

Fixed status
stable/6.6: [6f129a251c2795ba55dd5cc1fdf7e0af3098d848]

CVE-2026-43248: vhost: move vdpa group bound check to vhost_vdpa

stable/6.6 was fixed.

Fixed status
stable/6.6: [566899af053246406f2faf931044d2b0af8f34d2]

CVE-2026-43249: 9p/xen: protect xen_9pfs_front_free against concurrent calls

stable/6.6 was fixed.

Fixed status
stable/6.6: [480aa6ffd4ac7036eea042047d0cca71bc2074bb]

CVE-2026-43250: usb: chipidea: udc: fix DMA and SG cleanup in _ep_nuke()

stable/6.6 was fixed.

Fixed status
stable/6.6: [aad97c92119cb85db105ddda4a44c86cc0748e8c]

CVE-2026-43258: alpha: fix user-space corruption during memory compaction

stable/6.6 was fixed.

Fixed status
stable/6.6: [5593c9b255ae73f57a8b5e696a660032acbd67da]

CVE-2026-43263: media: chips-media: wave5: Fix Null reference while
testing fluster

stable/6.12 was fixed.

Fixed status
stable/6.12: [925b8f99f92fc968990ebb4ec49c96ac2d4e600b]

CVE-2026-43272: ring-buffer: Fix possible dereference of uninitialized pointer

stable/6.12 was fixed.

Fixed status
stable/6.12: [a4afdff9c715af50cf6c3f2dc601932c2cea17a2]

CVE-2026-43294: drm: renesas: rz-du: mipi_dsi: fix kernel panic when
rebooting for some panels

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [ad9a3246e76b83cd19eb07088111a743a9558bcd]
stable/6.6: [3cd7a71958c9f7f1def1a110e1ac98c022a554cd]

CVE-2026-43298: drm/amdgpu: Skip vcn poison irq release on VF

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [89008271744f13854cb30408cf9aaada313ebb4a]
stable/6.6: [87fc584a72bc47f984600f693501be06548d733e]

CVE-2026-43309: md raid: fix hang when stopping arrays with metadata
through dm-raid

stable/6.12 was fixed.

Fixed status
stable/6.12: [63054027d95200b04f3cf624faa7817e0555d56a]

CVE-2026-43317: most: core: fix leak on early registration failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [04474009a2ea7aa27c67d323952a23bb16d5acc5]

CVE-2026-43325: wifi: iwlwifi: mvm: don't send a 6E related command
when not supported

stable/6.12 was fixed.

Fixed status
stable/6.12: [c0e380109984e5499b969230131a3e80efc1613f]

CVE-2026-43337: drm/amd/display: Fix NULL pointer dereference in
dcn401_init_hw()

stable/6.12 was fixed.

Fixed status
stable/6.12: [fcc51c81cb472eb460310c477460356dc4845ff7]

CVE-2026-43338: btrfs: reserve enough transaction items for qgroup ioctls

stable/6.6 was fixed.

Fixed status
stable/6.6: [320942ce316a17b104b5814db55e42a42c2442cf]

CVE-2026-43346: ice: ptp: don't WARN when controlling PF is unavailable

stable/6.12 was fixed.

Fixed status
stable/6.12: [228497715a162d040df1617e62c3b7d0df54b235]

CVE-2026-43352: i3c: mipi-i3c-hci: Correct RING_CTRL_ABORT handling in
DMA dequeue

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [55a0b47a372245f7667e0a4ba5c6f2a4c7a889a6]
stable/6.6: [04b2853fdbb2ec9d03ece45da3c830396647120f]

CVE-2026-43353: i3c: mipi-i3c-hci: Fix race in DMA ring dequeue

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [16061383a9def977e4be908c7dcede9a8a4227fd]
stable/6.6: [73bb6b15f1fd71479ed12b314876f3ce5935b80a]

CVE-2026-43463: rxrpc, afs: Fix missing error pointer check after
rxrpc_kernel_lookup_peer()

stable/6.12 was fixed.

Fixed status
stable/6.12: [d854c93b12f2076c564f595b41b93b02fd42a0f9]

CVE-2026-43464: net/mlx5e: RX, Fix XDP multi-buf frag counting for legacy RQ

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [9488ee96b4f53d2aed474c744f0ed64f61d1dcc9]
stable/6.6: [1106412414dc3ee62999115be10ca83199b02108]

CVE-2026-43465: net/mlx5e: RX, Fix XDP multi-buf frag counting for striding RQ

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [f0a850677a7b7589208ce11480e6958f516c8386]
stable/6.6: [6451ea47d60a8ca3524dfe370c013cd01063c7d3]

CVE-2026-43485: nouveau/gsp: drop WARN_ON in ACPI probes

stable/6.12 was fixed.

Fixed status
stable/6.12: [2bbb55c4e6665e35a2ebb856d393802753017b2d]

CVE-2026-45859: netfilter: nfnetlink_queue: do shared-unconfirmed
check before segmentation

stable/6.6 was fixed.

Fixed status
stable/6.6: [aead84bdacd77e08357fd718e5dcaffaf387f3c3]

CVE-2026-45861: gfs2: Fix slab-use-after-free in qd_put

stable/6.6 was fixed.

Fixed status
stable/6.6: [53aaf083de197946b25bc4ffa3068d37366ce73d]

CVE-2026-45877: HID: intel-ish-hid: fix NULL-ptr-deref in
ishtp_bus_remove_all_clients

stable/6.6 was fixed.

Fixed status
stable/6.6: [cde7f709d1025dadfc52e903e43981c1644bd8bd]

CVE-2026-45893: apparmor: Fix & Optimize table creation from possibly
unaligned memory

stable/6.6 was fixed.

Fixed status
stable/6.6: [1fbc4b24c7443ffd501609be74d9856fb940d703]

CVE-2026-45894: iommu/vt-d: Clear Present bit before tearing down PASID entry

stable/6.6 was fixed.

Fixed status
stable/6.6: [c36b0515c6445bd137ec8ad86ef5470c45d6e4bf]

CVE-2026-45901: netfilter: nf_tables: revert commit_mutex usage in reset path

stable/6.6 was fixed.

Fixed status
stable/6.6: [b0dd8637fbaae8405eb9e8de741f9ce7c9667b6f]

CVE-2026-45917: ipvs: do not keep dest_dst if dev is going down

stable/6.6 was fixed.

Fixed status
stable/6.6: [11d35b11013442576f35fd9e8a8fc16155101906]

CVE-2026-45932: bpf: Fix tcx/netkit detach permissions when prog fd isn't given

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [0c249f523175963b0a746bba673ecebdf6cefd86]
stable/6.6: [8e1623e7d61faf16cbadc80550da874303611ff5]

CVE-2026-45934: btrfs: fix EEXIST abort due to non-consecutive gaps in
chunk allocation

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [09207c3975e1f8f76a52472004dfcab997b4cbd6]
stable/6.6: [12addb8ab5eec94098d4c7c6614830ccbe7ad130]

CVE-2026-45940: net: stmmac: fix oops when split header is enabled

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [92b45c99311ac4f3857cccee47059c4fb067fd4d]
stable/6.6: [107e169f963920b11fa3c1bb384c077fe7330696]

CVE-2026-45943: erofs: fix inline data read failure for ztailpacking pclusters

stable/6.6 was fixed.

Fixed status
stable/6.6: [237e0524a53812706e4cad30f40ef6c3213a2a92]

CVE-2026-45944: iommu/vt-d: Clear Present bit before tearing down context entry

stable/6.6 was fixed.

Fixed status
stable/6.6: [ab4aeab2d630e68be60ccbea3fcf76fa7c281a18]

CVE-2026-45949: hwrng: core - use RCU and work_struct to fix race condition

stable/6.6 was fixed.

Fixed status
stable/6.6: [1cde96d5d53b9105b48617afbc4682a83db4ff04]

CVE-2026-45956: drm/exynos: vidi: use priv->vidi_dev for ctx lookup in
vidi_connection_ioctl()

stable/6.12 was fixed.

Fixed status
stable/6.12: [e1aed617eb80b49eac2f8c7bb7a0990f641dd59b]

CVE-2026-45973: RDMA/mlx5: Fix UMR hang in LAG error state unload

stable/6.6 was fixed.

Fixed status
stable/6.6: [33deba9bf5c34335182342588315f3db7dbc56d3]

CVE-2026-46008: mm/damon/core: fix damos_walk() vs kdamond_fn() exit race

stable/6.18 was fixed.

Fixed status
stable/6.18: [93a7f297362deac614ce3dbbba73ff2ba31aaca3]

CVE-2026-46014: KVM: SVM: Add missing save/restore handling of LBR MSRs

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [4428a0a8643b0acf4ed7b8ea3e5975023bf4aafb]
stable/6.6: [bca0597272f9712b1f8ebd38b184db1dc2902ff7]

CVE-2026-46044: ipmi:ssif: Clean up kthread on errors

stable/6.12 was fixed.

Fixed status
stable/6.12: [d6855a3b15851061c817506492b6aa0b605cff1e]

CVE-2026-46059: KVM: nSVM: Always use NextRIP as vmcb02's NextRIP
after first L2 VMRUN

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [f9197a9dd1408e203147326139122f9c5312ce9c]
stable/6.6: [b1a45e8a59bcf1f1ec0da6d4e42190b4211c67fc]

CVE-2026-46066: ceph: fix num_ops off-by-one when crypto allocation fails

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [5dd151799d826d3736ae60c2b22cbc9d96a2a613]
stable/6.6: [f65a96fe2467a9b184c6ae963d95a260a202c98e]

CVE-2026-46071: KVM: nSVM: Avoid clearing VMCB_LBR in vmcb12

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [11d347b7edf5093d69aca72317300798a32bfd6b]
stable/6.6: [165b08d2d1346dce5ed43db65e10f3194b9ae2fe]

CVE-2026-46076: KVM: nSVM: Raise #UD if unhandled VMMCALL isn't
intercepted by L1

stable/6.6 was fixed.

Fixed status
stable/6.6: [fcef67506c0234935cb0fb026740a637edb58d7c]

CVE-2026-46130: dm-verity-fec: fix reading parity bytes split across
blocks (take 3)

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [dac69d1b76049d7e5f565089a6a7f4502a85b9de]
stable/6.6: [03348b440f69417dc3a3c71d8271cff6b05f67fb]

CVE-2026-46148: spi: microchip-core-qspi: control built-in cs manually

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [244fc8942123afe753ae8962407fb312a1d96a07]
stable/6.6: [783dc000b8be6d18713bde4d2705e168f2a61782]

CVE-2026-46157: ALSA: pcm: oss: Fix data race at accessing runtime.oss.trigger

stable/6.6 was fixed.

Fixed status
stable/6.6: [c937a494901df8fbfaa5037a5883a7cd44282ea8]

CVE-2026-46171: riscv: kvm: fix vector context allocation leak

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [70ecebe7c58ce01f8da3f513eafb51bd147b1e63]
stable/6.6: [8f3a5dc4055e1001b44ca8ae2bd3eb1d07782049]

CVE-2026-46175: f2fs: fix fsck inconsistency caused by FGGC of node block

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [8ac93964658d0649337dcb3f6e38d77f8cdd86f3]
stable/6.6: [d1820a5814eadb8e63ab6c7c8d04e28ce49836be]

CVE-2026-46181: RDMA/mlx4: Fix mis-use of RCU in mlx4_srq_event()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [f0dbd9355ce1e93808541260c7ffab7956df9233]
stable/6.6: [2d8b30b496bc53e961ba7415fd629fc27813017c]

CVE-2026-46200: spi: mpc52xx: fix controller deregistration

stable/6.6 was fixed.

Fixed status
stable/6.6: [c6e3b9f5dcb80fe4d3f1e470f79a91a3cc526cee]

CVE-2026-46228: spi: ch341: fix devres lifetime

stable/6.12 was fixed.

Fixed status
stable/6.12: [42dfcd2ced905ea3993d88a051c13e04ab1029f7]

CVE-2026-46241: spi: mpc52xx: fix use-after-free on registration failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [dd74a790818ebb9a2be3a94ac935a374755cd278]

CVE-2026-46254: AppArmor: Allow apparmor to handle unaligned dfa tables

stable/6.6 was fixed.

Fixed status
stable/6.6: [bd00629b527888a08a5222640fea045c6f64f5b5]

CVE-2026-46256: NFS/localio: prevent direct reclaim recursion into NFS
via nfs_writepages

stable/6.12 was fixed.

Fixed status
stable/6.12: [9118e1cab8a5571c6a95011f77ff28480aee9cb0]

CVE-2026-46272: coresight: tmc-etr: Fix race condition between sysfs
and perf mode

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [206b6f672613d08b33e951a744d0a1c6ac5ad8ad]
stable/6.6: [3e8cdf184646c28c5ea5fba754d24a3b29068739]

CVE-2026-46282: iio: frequency: admv1013: fix NULL pointer dereference on str

stable/6.6 was fixed.

Fixed status
stable/6.6: [ef8b71a0fc692f8cb7f124a8143b540446b1fe9d]

CVE-2026-46302: selinux: allow multiple opens of /sys/fs/selinux/policy

stable/6.12, stable/6.18, stable/6.6 were fixed.

Fixed status
stable/6.12: [0ed712134a3db0075bfe9a0f8536c48728ec745e]
stable/6.18: [c24d2e190b955baf3a95e05d34b192f61bd201b3]
stable/6.6: [d8cafd0226d5df682d1f4ea978a4318fe3a11210]

CVE-2026-46324: netfilter: nf_tables: use list_del_rcu for netlink hooks

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [fe45e203527af8a2c0dc4c8a7b56c09c74b796c8]
stable/6.6: [2405730fde96f7fa483a5862e323b681e0e09f54]

CVE-2026-46325: RDMA/rxe: Fix iova-to-va conversion for MR page sizes
!= PAGE_SIZE

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [2a585a08a43c568ed6e9f27a97fd3d95106b9e68]
stable/6.6: [e327021bd73b134c18167e2cd2a52eb5597fcba6]

CVE-2026-52937: tap: fix stack info leak in tap_ioctl() SIOCGIFHWADDR

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [8197905d97099d8b1e3883112bbb497abd20f9f0]
stable/6.6: [37d028a473b0826ad5970b52b791db4a29a23627]

CVE-2026-52983: net: airoha: fix BQL imbalance in TX path

stable/6.12 was fixed.

Fixed status
stable/6.12: [fcd6a3bb48bb661876c2743e89f0a6567f5cea2c]

CVE-2026-52990: fsnotify: fix inode reference leak in fsnotify_recalc_mask()

stable/6.6 was fixed.

Fixed status
stable/6.6: [926ec3937b28d30c08427053c8d8af7f9e086d82]

CVE-2026-52991: sched/psi: fix race between file release and pressure write

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [af0638534bfae7980582c6482531a0872f8ee341]
stable/6.6: [d8ddbc3330fa6851c56b046e630a8fc64830a0ce]

CVE-2026-53000: netfilter: nat: use kfree_rcu to release ops

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [050f98e56782b14677c5bae50800e60775bbf6bb]
stable/6.6: [ede973d62d26d9c550269af05366ab9e30fc92ee]

CVE-2026-53015: erofs: unify lcn as u64 for 32-bit platforms

stable/6.6 was fixed.

Fixed status
stable/6.6: [18f9f3ddbf2ed6d245a4c6f91c51f7248f8a982c]

CVE-2026-53018: f2fs: avoid reading already updated pages during GC

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [08423a9564d92e51505763b6b2f47b3da8b0a355]
stable/6.6: [c260c874a6d578a45105f98089b1f0db5c6ff0a3]

CVE-2026-53024: greybus: raw: fix use-after-free if write is called
after disconnect

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [2b46f07913a80521ecfe60b229c84bdd7dfb15ab]
stable/6.6: [966b941ca469fb794637a0803670454f68515e40]

CVE-2026-53053: iommu/amd: Fix clone_alias() to use the original device's devid

stable/6.6 was fixed.

Fixed status
stable/6.6: [166a08644aa509e5d27e154d7fa774f4181df9e0]

CVE-2026-53070: sctp: disable BH before calling udp_tunnel_xmit_skb()

stable/6.6 was fixed.

Fixed status
stable/6.6: [7f0062c40781fe0a340965f5bb0816681982ff4c]

CVE-2026-53091: net: pull headers in qdisc_pkt_len_segs_init()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [7564dc804d8289d2e5c6edb8173754051b71bff4]
stable/6.6: [5895cfc76924a629c6eaa5e5f049de642860045f]

CVE-2026-53097: wifi: mt76: mt7996: fix use-after-free bugs in
mt7996_mac_dump_work()

stable/6.6 was fixed.

Fixed status
stable/6.6: [533b1a9fa0128c75e40dd2d2c38a32b4e660741f]

CVE-2026-53102: wifi: mt76: Fix memory leak after
mt76_connac_mcu_alloc_sta_req()

stable/6.6 was fixed.

Fixed status
stable/6.6: [a2af91af9536922edc3f63de90c3f1fe9db71717]

CVE-2026-53103: wifi: mt76: mt7925: fix potential deadlock in
mt7925_roc_abort_sync

stable/6.12 was fixed.

Fixed status
stable/6.12: [253cfc33d95ce4a30fd2eca0ff0138603c6c2fcc]

CVE-2026-53104: wifi: mt76: Fix memory leak destroying device

stable/6.12 was fixed.

Fixed status
stable/6.12: [3c363fc4dbdb77a3f02dcf6ba90c1f0a111ef055]

CVE-2026-53109: powerpc/pgtable-frag: Fix bad page state in pte_frag_destroy

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [f4bc93135bfe39e7052d31e4c71f5f838e0bf516]
stable/6.6: [e9d197c248e70278645f206defa87f085826c4c1]

CVE-2026-53113: wifi: ath11k: fix memory leaks in beacon template setup

stable/6.6 was fixed.

Fixed status
stable/6.6: [7bedc489611f01634cec20f88f961a1f08e8d935]

CVE-2026-53115: bus: fsl-mc: use generic driver_override infrastructure

stable/6.6 was fixed.

Fixed status
stable/6.6: [dbba371b19129abe9649553ab912e6bccf6c1a5b]

CVE-2026-53118: vdpa: use generic driver_override infrastructure

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [4eab1a74a498f0bf19f102f9362e9deef9307aea]
stable/6.6: [4005cb89139f7c9af85046b241dcf3fa2e1b3559]

CVE-2026-53120: PCI: use generic driver_override infrastructure

stable/6.6 was fixed.

Fixed status
stable/6.6: [fdfa287956d00b936e0ac409b21e4f90501ad109]

CVE-2026-53122: btrfs: fix deadlock between reflink and transaction
commit when using flushoncommit

stable/6.6 was fixed.

Fixed status
stable/6.6: [1034251715a3474d8615232a032ed0e3451ae6ec]

CVE-2026-53129: fs/mbcache: cancel shrink work before destroying the cache

stable/6.6 was fixed.

Fixed status
stable/6.6: [cbdd6f0fb19a0ce8a013acd80ac87a62f57fa20d]

CVE-2026-53156: nvmem: core: fix use-after-free bugs in error paths

stable/6.6 was fixed.

Fixed status
stable/6.6: [6cdcf0d16c80900f42d60252480cd131c1a83d23]

CVE-2026-53178: staging: rtl8723bs: rtw_mlme: add bounds checks before
ie_length subtraction

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [8863ac3a4fedf86b0ef5b8ecc37fbaa52f2a8160]
stable/6.6: [18143799ad51a32b1351e4e1591b6285a0a9d7dd]

CVE-2026-53179: staging: rtl8723bs: fix buffer over-read in
rtw_update_protection

stable/6.6 was fixed.

Fixed status
stable/6.6: [d95edbbf7830d77ad68d437c384055eac8cd9892]

CVE-2026-53220: netfilter: revalidate bridge ports

stable/6.6 was fixed.

Fixed status
stable/6.6: [98cc0403f546c52104d654fa24d86e9bcac964d3]

CVE-2026-53224: sctp: validate embedded INIT chunk and address list
lengths in cookie

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [29ab56e7660b6f849c10c46e87e085649df751eb]
stable/6.6: [dd75066882ecc4ec8df3f5384b4b9fa9579be8f0]

CVE-2026-53226: gpio: rockchip: fix generic IRQ chip leak on remove

stable/6.6 was fixed.

Fixed status
stable/6.6: [6198123cac2ffd9d9a9d252dfa84ab81fb487ba3]

CVE-2026-53229: net/mlx5e: xsk: Fix DMA and xdp_frame leak on XDP_TX
xmit failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [3bad189a31eb78575ea69f093e8ef5b7e3e8c832]

CVE-2026-53258: wifi: fix leak if split 6 GHz scanning fails

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [df44397bbd8f3a38115c9590b686787e4aaf6327]
stable/6.6: [87484866cae9130b97c2b356eeaea4f47b292f75]

CVE-2026-53262: l2tp: pppol2tp: hold reference to session in pppol2tp_ioctl()

stable/6.6 was fixed.

Fixed status
stable/6.6: [312ecea13b67797747eb9d4b9dab8d3846de6dfb]

CVE-2026-53272: erofs: fix use-after-free on sbi->sync_decompress

stable/6.6 was fixed.

Fixed status
stable/6.6: [59db5d8bcc65e04d8598afd81ec3a18edb407470]

CVE-2026-53277: KVM: arm64: Take the SRCU lock for page table walks in
fault injection and AT emulation

stable/6.12 was fixed.

Fixed status
stable/6.12: [0648b375aa951cc15d9e90f9ac4de71e0b51fa45]

CVE-2026-53281: iommu/vt-d: Avoid NULL pointer dereference or refcount
corruption

stable/6.12 was fixed.

Fixed status
stable/6.12: [d1a677f9c5e02c4ae49614044ac21296660d1391]

CVE-2026-53284: btrfs: only release the dirty pages io tree after
successful writes

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [d915195c2f57794ed8ec4bf131bcead4b5dc29c1]
stable/6.6: [7107b047e709ad258f7c29a342266a8e3653f370]

CVE-2026-53297: net: mana: Guard mana_remove against double invocation

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [8ee85b75a72216c857c39457f6595709c4c9f856]
stable/6.6: [793bf1f4e469c51d0e39199823da5e1de85a2741]

CVE-2026-53313: drm/amd/display: Avoid NULL dereference in dc_dmub_srv
error paths

stable/6.6 was fixed.

Fixed status
stable/6.6: [1cad9afbb2d559b738b83c498f9c1abdfd327e7f]

CVE-2026-53317: wifi: mt76: mt7921: Place upper limit on station AID

stable/6.6 was fixed.

Fixed status
stable/6.6: [9d63dd026644fa612a1fd348d5d3ab5d73df7fb8]

CVE-2026-53321: io_uring/napi: cap busy_poll_to 10 msec

stable/6.12 was fixed.

Fixed status
stable/6.12: [42785efe813e5a7d815f3b6be126e1bc0d12d2b6]

CVE-2026-53330: drm/amd/display: Fix out-of-bounds read in
dp_get_eq_aux_rd_interval()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [7c5f2d16a8f4464bf2a719ceb2316b8a6b87a3c0]
stable/6.6: [a632474c793b7f2a9bbd3d8e3d0dd7d256989300]

CVE-2026-53368: f2fs: fix fsck inconsistency caused by incorrect
nat_entry flag usage

stable/6.12 was fixed.

Fixed status
stable/6.12: [270c519bca3a59b6140d176415aff16e4e06f9e3]

CVE-2026-53377: drm/msm: always recover the gpu

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [1c0034c1a614a118acbb4bdf7ab51490ee919ad2]
stable/6.6: [01930f94b8b13400f3346044cacf98f01d337f3d]

CVE-2026-63825: gcov: use atomic counter updates to fix concurrent
access crashes

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [4575852c23a10abc7648d31e4c12cf79d7391637]
stable/6.6: [b0f7bd5eeb903a0021a80e9d704814e2a9d3998c]

CVE-2026-63832: wifi: mt76: add wcid publish check in mt76_sta_add

stable/6.12 was fixed.

Fixed status
stable/6.12: [720f39a9c60fdb604291c630f4f157753b376d68]

CVE-2026-63853: drm/amdgpu/vcn: set no_user_fence for VCN v4.0 enc ring

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [d8df8918677136b018d71d0b94a1f6b816715946]
stable/6.6: [525cc9df654365c147ae61e5562cf599ea2257f7]

CVE-2026-63857: net: airoha: Do not read uninitialized fragment
address in airoha_dev_xmit()

stable/6.12 was fixed.

Fixed status
stable/6.12: [dba5f4959653e4c212beb746594952e8645d1115]

CVE-2026-63859: net: airoha: Add missing bits in airoha_qdma_cleanup_tx_queue()

stable/6.12 was fixed.

Fixed status
stable/6.12: [7b86b4c7767e932f59cd23b31587b73a03cb1dfc]

CVE-2026-63940: KVM: SEV: Ignore Port I/O requests of length '0'

stable/6.6 was fixed.

Fixed status
stable/6.6: [bbd3a27e4f99fdcad82d12d79c04a95dff1ff70b]

CVE-2026-63962: usb: typec: tcpm: bound altmode_desc[] per iteration
in svdm_consume_modes()

stable/6.6 was fixed.

Fixed status
stable/6.6: [816c6251409db28f1b875988fcbd2ff1764a81f0]

CVE-2026-63963: usb: typec: tcpm: validate VDO count in Discover
Identity ACK handlers

stable/6.6 was fixed.

Fixed status
stable/6.6: [6bacd22e1eae77abf089bbdc016270200a8dc83b]

CVE-2026-63974: Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE
during device close

stable/6.6 was fixed.

Fixed status
stable/6.6: [7b81c1378b79c3143ca3fdb3d18ac0f01cbabb21]

CVE-2026-63978: net/handshake: Drain pending requests at net namespace exit

stable/6.6 was fixed.

Fixed status
stable/6.6: [ee4b2ba9d30155f9945811cd3c0c1b06d45787a9]

CVE-2026-63979: net/handshake: hand off the pinned file reference to accept_doit

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [2f28dbb30b88eafab8d49aaec94710b4e12dea8e]
stable/6.6: [b869e3e4ce1996df23b3efdbbe9a64c4ab81d745]

CVE-2026-63998: ethtool: module: call ethnl_ops_complete() on module
flash errors

stable/6.12 was fixed.

Fixed status
stable/6.12: [170d82a57f4be1ce83de823a93bafd218a0d5fb1]

CVE-2026-63999: ethtool: rss: fix indir_table and hkey leak on get_rxfh failure

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [323faef6366349f57d4ad67d318a0c8906e360b3]
stable/6.6: [14dbf22c397b799b3a80f63fc90c2fc0585bbeb3]

CVE-2026-64001: ALSA: pcm: oss: Fix setup list UAF on proc write error

stable/6.6 was fixed.

Fixed status
stable/6.6: [d9df965284abde27ba6bfbdfc8407697cf6802f1]

CVE-2026-64006: netfilter: nf_tables: fix dst corruption in same
register operation

stable/6.12 was fixed.

Fixed status
stable/6.12: [379ff8d40f59632bea1208956629c2a04067d403]

CVE-2026-64024: tcp: fix stale per-CPU tcp_tw_isn leak enabling ISN prediction

stable/6.12 was fixed.

Fixed status
stable/6.12: [8bb6aa419b142dcc2680177ecc39c4c38db7fc16]

CVE-2026-64036: cgroup/rstat: validate cpu before css_rstat_cpu() access

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [3d595affbe00a2e8bf43b9f2947a8efcdc1c059e]
stable/6.6: [b28b862b07257219755d0b0a7fbe5d23b7c9ea91]

CVE-2026-64038: hwmon: (lm90) Stop work before releasing hwmon device

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [5c116abf208dd97c4ceb76c5c50c9bc34a017796]
stable/6.6: [1fe96176636cb17906680c098688b144bd9c1c45]

CVE-2026-64060: netfs: Fix leak of request in netfs_write_begin() error handling

stable/6.12 was fixed.

Fixed status
stable/6.12: [9192f304379187b396d56d6a1a406712c6bfa5a3]

CVE-2026-64068: netfs: Fix missing locking around retry adding new subreqs

stable/6.12 was fixed.

Fixed status
stable/6.12: [f59c4ec86ef3a9ac99706ae163a38ec28129fd76]

CVE-2026-64076: netfilter: bridge: eb_tables: close module init race

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [6bb35bdaabb22fd2d86b601904e928dbaa537941]
stable/6.6: [5fc488f46086d17e8e545d8104ddd95b175de218]

CVE-2026-64077: netfilter: ebtables: move to two-stage removal scheme

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [f34e5a674afe743d1af80684d64b511f40a5c35d]
stable/6.6: [6fe4c808b6cdb405ed64ea6e740d557bba3d7745]

CVE-2026-64138: ksmbd: validate SID in parent security descriptor
during ACL inheritance

stable/6.6 was fixed.

Fixed status
stable/6.6: [8efbea0253b7fa2d1960cab0fed36544ca0b41ab]

CVE-2026-64190: net: team: fix NULL pointer dereference in team_xmit
during mode change

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [cde5c7f0286c4203d0abc7248201542aa8bf33bb]
stable/6.6: [9486377e5e971988a3add171c398eb654a866fab]

CVE-2026-64213: hwmon: (lm90) Add lock protection to lm90_alert

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [165ef777ec6f634a5e4b8d9b0dadca8ef91fa90e]
stable/6.6: [02b88fa993582b4fe228b4143b330b0bb9f28353]

CVE-2026-64241: gpio: rockchip: teardown bugs and resource leaks

stable/6.6 was fixed.

Fixed status
stable/6.6: [77b6ff33c8f5642f7e7c1ca691857218683264fd]

CVE-2026-64305: crypto: qat - protect service table iterations with service_lock

stable/6.6 was fixed.

Fixed status
stable/6.6: [11d48f777cf8fad00db044f4c15cdf821427746b]

CVE-2026-64320: nvmet: fix pre-auth out-of-bounds heap read in
Discovery Get Log Page

stable/6.6 was fixed.

Fixed status
stable/6.6: [8ae9bb92fc9a712a8d32da9c5fd657101f9b260b]

CVE-2026-64341: USB: iowarrior: fix use-after-free on disconnect race

stable/6.18, stable/6.6 were fixed.

Fixed status
stable/6.18: [30ec3025b771511625375fb3fb959aea3b45fb0d]
stable/6.6: [4e7d3c98fed73d3be84d3e146d8d9be0309e725b]

CVE-2026-64377: cpufreq: qcom-cpufreq-hw: Fix possible double free

stable/6.6 was fixed.

Fixed status
stable/6.6: [0f012938f21302c08153589c1aca0283f8d6911d]

CVE-2026-64389: ksmbd: validate NTLMv2 response before updating session key

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [f5d74c186bab26a5d5a025305e67edd0888aa34d]
stable/6.6: [a6a951416b55eaf51ea2742f7ba786f240e70137]

CVE-2026-64391: ksmbd: use opener credentials for ADS I/O

stable/6.6 was fixed.

Fixed status
stable/6.6: [2ad5509dd576ae16d252d4698daf03002f9e0234]

CVE-2026-64481: ALSA: hda/cs35l41: Fix firmware load work teardown

stable/6.6 was fixed.

Fixed status
stable/6.6: [3e339c88b8c3044919fd1936a8b23124285d0de6]

CVE-2026-64513: KVM: x86: Unconditionally recompute CR8 intercept on PPR update

stable/6.12 was fixed.

Fixed status
stable/6.12: [a7277b66511983b57e345c0fba21f1810fd07c0f]

CVE-2026-64523: net/handshake: Take a long-lived file reference at submit

stable/6.6 was fixed.

Fixed status
stable/6.6: [22e371a93563c30ebebc576db049785e0d7fc617]

CVE-2026-64539: Bluetooth: eir: Fix stack OOB write when prepending the Flags AD

stable/6.6 was fixed.

Fixed status
stable/6.6: [9174992ee1045c9c96e53eecda64f49dd7e8fbba]

CVE-2026-68081: KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails
due to invalid guest state

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [f42669f931a6f45e5918cf5e99989b9a6c65e655]
stable/6.6: [a7bf4f5b19965e4466040ad6b24919c1ed326a84]

CVE-2026-68083: ksmbd: fix path resolution in ksmbd_vfs_kern_path_create

stable/6.6 was fixed.

Fixed status
stable/6.6: [a2516be69048856e2a49a51e00975dc59431f95c]

CVE-2026-68185: LoongArch: Move jump_label_init() before parse_early_param()

stable/6.6 was fixed.

Fixed status
stable/6.6: [1d0b99ef7fcb6cef1df273872059bf854814500e]

CVE-2026-68203: media: vivid: fix cleanup bugs in vivid_init()

stable/6.6 was fixed.

Fixed status
stable/6.6: [ae6ccae32f51f788035d2c5cec898491dd7150ef]

CVE-2026-68211: media: stm32-dcmipp: Return queued buffers on
start_streaming() failure

stable/6.12 was fixed.

Fixed status
stable/6.12: [c1800238a60b0584b1924f11ce38ec8aba533238]

CVE-2026-68233: drm/vc4: Shut down BO cache timer before teardown

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [e9264ee59bd94970b80b7548f693bccf0d4628da]
stable/6.6: [cf55c6f1b62a89bf365c48bf731ccf69340e3a16]

CVE-2026-68238: drm/amdgpu: Release VFCT ACPI table reference

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [50a75929c0c5e8ab29a3ac49dc92489873d9d261]
stable/6.6: [1748043b5114ce5ee5ee874d5f821a158d70631c]

CVE-2026-68241: drm/i915/mst: limit DP MST ESI service loop

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [02ceba559412751106c0cfa5cbdb80db50303083]
stable/6.6: [fae63319ad397666a9c56a17ea1047d2bf9a1e25]

CVE-2026-68247: drm/i915/bios: range check LFP Data Block panel_type2

stable/6.6 was fixed.

Fixed status
stable/6.6: [dc30139679354860faf8ca6a0f231cd39d692db7]

CVE-2026-68258: drm/amdkfd: Check bounds on CRIU restore queue type and mqd size

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [1956aa246c65c5895589664ccb37d0710aa8d304]
stable/6.6: [2b817c0dfc653bf33d0e0ab8155ff7807a617487]

CVE-2026-68273: drm/amdgpu: Fix context pstate override handling

stable/6.6 was fixed.

Fixed status
stable/6.6: [3531910845165dcf1a213267199ccc97e03cd58a]

CVE-2026-68293: net/mlx5: Fix MCIA register buffer overflow on 32 dword reads

stable/6.6 was fixed.

Fixed status
stable/6.6: [c8a4acc19dcdc83e1303c29d9535e5c99415a2e3]

CVE-2026-68303: drm/vc4: hvs/v3d: Fix null dereference in unbind

stable/6.6 was fixed.

Fixed status
stable/6.6: [3be8dcc1a5854cf24cc332e0d6fc865c47ff49a1]

CVE-2026-68318: pds_core: fix use-after-free on workqueue during remove

stable/6.6 was fixed.

Fixed status
stable/6.6: [bac237c2aedb8225bfd2317c1361bbfce1e419ca]

CVE-2026-68393: Bluetooth: hci_sync: extend conn_hash lookup critical sections

stable/6.12 was fixed.

Fixed status
stable/6.12: [3f98e7f38e1bb761a9964a8851f9c08e9c23b3dd]

CVE-2026-68396: scsi: core: wake eh reliably when using scsi_schedule_eh

stable/6.6 was fixed.

Fixed status
stable/6.6: [4827c824a203eea2c0aa5bfdb13d5c5038cc84da]

CVE-2026-68400: firmware: arm_ffa: Fix Endpoint Memory Access
Descriptor offset calculation

stable/6.12 was fixed.

Fixed status
stable/6.12: [6e902bea625b710f8bf2f40b4ae4b14fa6a33f13]

CVE-2026-68401: firmware: arm_ffa: Fix out-of-bound writes in
ffa_setup_and_transmit()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [00bef9d0f9e787f56ff4699d3b577983ff8b7f24]
stable/6.6: [d312a71b19bb83803c8d1372bc042bd36db657f7]

CVE-2026-68408: wifi: cfg80211: convert pmsr_free_wk to wiphy_work to
fix deadlock

stable/6.6 was fixed.

Fixed status
stable/6.6: [30c67926d41c456809857976cd3cd71b2290e0c1]

CVE-2026-68409: wifi: mac80211: defer link RX stats percpu free to RCU

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [b679c1cffb2f3d0854b8b05ea9e909ad6489046f]
stable/6.6: [a5afc00280986063f1c355821544fabbb2a960f7]

CVE-2026-68412: wifi: cfg80211: Fix an error handling path in
cfg80211_wext_siwscan()

stable/6.12 was fixed.

Fixed status
stable/6.12: [f4114597b7949e90f4fa181342cf01400b8a5a75]

CVE-2026-68418: RDMA/irdma: Prevent user-triggered null deref on QP create

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [ad68e0b759f9569f0dfea84f035c91eadb979802]
stable/6.6: [d52ff592abfcd56234f266aa245c489f70b1c554]

CVE-2026-68421: sched_ext: Don't warn on core-sched forced idle in
put_prev_task_scx()

stable/6.12 was fixed.

Fixed status
stable/6.12: [6267ebee9f2f3e26f4968bf6dc29d350620fa320]

CVE-2026-68426: xfrm: fix stale skb->prev after async crypto steals a
GSO segment

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [b58731e0570bfd3989999fc2baf9ee4fecd5bec6]
stable/6.6: [4927ab8a8acc8db4fad33e803d1d35e0b16cef83]

CVE-2026-68435: LoongArch: Fix address space mismatch in kexec command
line lookup

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [eaa908d8d523b0ab75dab5ebd6662e70af5e5d7e]
stable/6.6: [3b71f51fa3a247921408879eab2ddee82da8a980]

CVE-2026-68447: drm/amdkfd: clamp v9 CRIU control stack checkpoint
copy to BO size

stable/6.12 was fixed.

Fixed status
stable/6.12: [1218c6dcec80f886372635e82f3229d5babc37d3]

CVE-2026-68448: ovl: check access to copy_file_range source with src
mounter creds

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [46c296aa678828105842eee29a147508d803d926]
stable/6.6: [7e13e5b087375f1aee1e930503d20efa7084c0fa]

CVE-2026-68453: s390/zcrypt: Fix buffer over-read in cca_cipher2protkey

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [353e442d18084b24fb3ede4e5adfca26b25f0e89]
stable/6.6: [d0951ed366710a1a303b7cb2f8eb3d866cd68fc6]

CVE-2026-68471: wifi: ieee80211: validate MLE common info length

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [22941b5c5c46e61a7053e5f32f260f2bc39da617]
stable/6.6: [181b46e76a218e9345ed7c4cf59dfa69278e4a06]

CVE-2026-72009: pmdomain: imx93-blk-ctrl: Extract PHY as shared domain
for DSI/CSI

stable/6.12 was fixed.

Fixed status
stable/6.12: [94b8a47f45f19c537964355fa539670631882b20]

CVE-2026-72073: mmc: vub300: fix use-after-free on probe failure

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [6c66653dac9b25272d5fd4ed42a34aa5249e16df]
stable/6.6: [face65f80c6946c631ca3490b4ebd2c016a4fd2c]

CVE-2026-72098: dm-verity: fix buffer overflow in FEC calculation

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [dc662eed1c432cc2fd4e9314f58d30b3a8cca7cc]
stable/6.6: [374775626c327aec2425c16b4d36706e5f8718b8]

CVE-2026-72130: nvmet-auth: reject short AUTH_RECEIVE buffers

stable/6.6 was fixed.

Fixed status
stable/6.6: [584d7d14d9b40b080b1195cec83de86ade63343e]

CVE-2026-72162: ocfs2: fix UBSAN array-index-out-of-bounds in
ocfs2_sum_rightmost_rec

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [720fb324cf0f5116318cae7f75cb393d118ffb67]
stable/6.6: [c286319746cef02bcce7384fda3a3f08989070d2]

CVE-2026-72168: mtd: maps: vmu-flash: fix fault in unaligned fixup

stable/6.6 was fixed.

Fixed status
stable/6.6: [1dc6653c47147ac754fced76b0932b8df1d2d414]

CVE-2026-72198: ntfs: reject non-resident records for resident-only attributes

stable/6.6 was fixed.

Fixed status
stable/6.6: [6626fb859f4c4772f2f59751d23937716e03f98f]

CVE-2026-72200: ntfs: detect mapping-pairs LCN accumulator overflow

stable/6.6 was fixed.

Fixed status
stable/6.6: [6626fb859f4c4772f2f59751d23937716e03f98f]

CVE-2026-72203: ntfs: skip extent mft records in writeback to prevent deadlock

stable/6.6 was fixed.

Fixed status
stable/6.6: [6626fb859f4c4772f2f59751d23937716e03f98f]

CVE-2026-72213: mm/hugetlb: fix hugetlb cgroup rsvd charge/uncharge mismatch

stable/6.6 was fixed.

Fixed status
stable/6.6: [043c509f2488033c68c46d2de2af082fcd568612]

CVE-2026-72288: KVM: arm64: vgic: Handle race between interrupt
affinity change and LPI disabling

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [77c61235d66246dd6a5f55587f0afc273d832775]
stable/6.6: [eb74f3feb68e64cf69f86cb806a15d8cfb6757f4]

CVE-2026-72320: netfilter: nft_lookup: fix catchall element handling
with inverted lookups

stable/6.6 was fixed.

Fixed status
stable/6.6: [65d35cb555f40529a9edc6bf4beaa3bee917f015]

CVE-2026-72321: ipv4: igmp: Fix potential memory leaks in
igmp_mod_timer() and igmp_stop_timer()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [40d6360ccf9bcbe17b5cb248a84e8e004aac2faa]
stable/6.6: [2d0effadf8d2cc9d006e4c4ab0ab6737aed28d77]

CVE-2026-72324: gpio: mvebu: free generic chips on unbind

stable/6.6 was fixed.

Fixed status
stable/6.6: [db2b40dc12cd6ae4704f52d62c0147ef31527f60]

CVE-2026-72325: perf/x86/amd/core: Avoid enabling BRS from the SVM reload path

stable/6.6 was fixed.

Fixed status
stable/6.6: [3b0aa139ba09a5b73c0f300e652076232f869f68]

CVE-2026-72341: net/mlx5e: Fix publication race for priv->channel_stats[]

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [acd34d24342a28794e706ce8191ca6c3114a38ae]
stable/6.6: [268869794170af37727816ad02051808adb9c9c3]

CVE-2026-72352: HID: bpf: Fix hid_bpf_get_data() range check

stable/6.6 was fixed.

Fixed status
stable/6.6: [f72176bde0cc0e709e41ab170c71e8f229232af6]

CVE-2026-72363: netfs: Fix folio state after ENOMEM whilst under
writeback iteration

stable/6.12 was fixed.

Fixed status
stable/6.12: [f75d7b10ec080cc15fe21092d9b5c6b2bc55260a]

CVE-2026-72366: netfs: Fix netfs_create_write_req() to handle async
cache object creation

stable/6.12 was fixed.

Fixed status
stable/6.12: [aee03fbc8803a40d65e20f1af816a7219048a426]

CVE-2026-72367: iomap: guard io_size EOF trim against concurrent
truncate underflow

stable/6.12 was fixed.

Fixed status
stable/6.12: [cc1d6af0bee27d6595908b497424f338161299fc]

CVE-2026-72375: afs: Fix reinitialisation of the inode, in particular
->lock_work

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [34dff35154e2fb3987ec5e0b40def14c64eadeb1]
stable/6.6: [2e7888bb635d9bc84359491347b236cc232ca4df]

CVE-2026-72383: sctp: fix addr_wq_timer race in sctp_free_addr_wq()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [d49eff15261dd62e4fa3a316c26cb1f537a60464]
stable/6.6: [5098308ad72f83f3b1a48c247dddab1695114bae]

CVE-2026-72397: hwmon: (pmbus/core) honor vrm_version in pmbus_data2reg_vid()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [125a5a4ad03c74ced4c2a55db45ef03505362ff9]
stable/6.6: [cd0e037130806d7714c356eccefac6e1b92dbc34]

CVE-2026-72398: sctp: add INIT verification after cookie unpacking

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [683a012b984fef4bc155e278742fbe01561e102a]
stable/6.6: [81892d83cc897331510f35b30d17f8b0dc285966]

CVE-2026-72405: net: udp_tunnel: prevent double queueing in
udp_tunnel_nic_device_sync

stable/6.6 was fixed.

Fixed status
stable/6.6: [f49ed02fd8c98da823fdd7b00d64a8cc1d1883ac]

CVE-2026-72420: md/raid5: avoid R5_Overlap races while breaking stripe batches

stable/6.6 was fixed.

Fixed status
stable/6.6: [158a5480d51969adeb727ff20c6fa96f063e9f9e]

CVE-2026-72438: md/raid10: fix writes_pending and barrier reference
leaks on discard failures

stable/6.6 was fixed.

Fixed status
stable/6.6: [80ac31cce55432034a9eb98262c92ace7866e494]

CVE-2026-72469: xprtrdma: Fix ep kref imbalance on ADDR_CHANGE

stable/6.6 was fixed.

Fixed status
stable/6.6: [a562485c359d0b20a99d466b042af9c2f7ff3326]

CVE-2026-72488: soundwire: fix bug in sdw_add_element_group_count
found by syzkaller

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [5c3ce6d3559ce57e6c3108aa9ecf7b32764188c5]
stable/6.6: [a2275dce05e6d1cce69bf68f23ea7a63c0c54bae]

CVE-2026-72494: RDMA/irdma: Replace waitqueue and flag with completion

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [8de303efe2ff4fcbf240dfc6eb3469e1e8f18a3f]
stable/6.6: [7d89bff21c12e543d12ad70cb0103cf815891b24]

CVE-2026-72495: RDMA/bnxt_re: Avoid repeated requests to allocate WC pages

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [00c71846874fea4917961236e49287a1850dcf98]
stable/6.6: [8e59bd37d6d63a06ed452eaffe6c9d4ad903af7b]

CVE-2026-72500: RDMA/bnxt_re: Free SRQ toggle page after firmware teardown

stable/6.12 was fixed.

Fixed status
stable/6.12: [3b6ecad5b9b0f7230ed725aafaf8c4ed9327a9bf]

CVE-2026-72501: RDMA/bnxt_re: Initialize dpi variable to zero

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [31ba386230e6093991b4800a59c42ed1766627df]
stable/6.6: [88baaa8ca3731b9d1184a0772ac44d5738d294e8]

CVE-2026-74257: sockmap: Fix use-after-free in udp_bpf_recvmsg()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [05c29e7d42926170f0595c7188d60d8ecb665593]
stable/6.6: [6b59007d95aeef6619a72f5ea51f58752c47c198]

CVE-2026-74261: ALSA: seq: avoid stale FIFO cells during resize

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [dcf784abee6df2f5c47e36a1d9e400065993bc04]
stable/6.6: [ae429220c7f9747579bc4682c574585230e971cc]

CVE-2026-74264: net: watchdog: fix refcount tracking races

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [6b2330facc90e43b6d7171a0ac12c23dfcbdc30d]
stable/6.6: [2fc2c92320272a99e18bbb102252859b6ee50881]

CVE-2026-74269: bnxt: fix head underflow on XDP head-grow

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [ff34e5a26a26c92142afea11455e259c4c4c617b]
stable/6.6: [3e8f3959a7fd28461b8cd9708c21286b4250b77a]

CVE-2026-74272: cxl/region: Resolve region deletion races

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [c478810c4ce7216261fc1b6ca5180adcda26b1a1]
stable/6.6: [441250eea84608c6c2dbd7f00c61df32836ac97d]

CVE-2026-74278: ALSA: seq: Fix kernel heap address leak in bounce_error_event()

stable/6.6 was fixed.

Fixed status
stable/6.6: [eae296065ede41a24040e6a7c909ec970f78b4eb]

CVE-2026-74302: Bluetooth: hci_core: Fix UAF in hci_unregister_dev()

stable/6.6 was fixed.

Fixed status
stable/6.6: [bce2eec05bce548b548aca52c1834540f97d5d60]

CVE-2026-74318: btrfs: fix deadlock cloning inline extent when using
flushoncommit

stable/6.6 was fixed.

Fixed status
stable/6.6: [50d1a47fb3c4f3ee6c581e6bc4f1fb8d7051c5d1]

CVE-2026-74344: bpf: Clear rb node linkage when freeing bpf_rb_root

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [ff3ab3fb956027ab40aca1fb3298cf20dc290273]
stable/6.6: [628a469d2a73e3844e5ee80aa002e232b0fd6493]

CVE-2026-74345: RDMA/siw: Fix endpoint/socket association handling

stable/6.6 was fixed.

Fixed status
stable/6.6: [ff584d3735b13a1d7f8cd072f98fea40b6062518]

CVE-2026-74347: netfilter: cttimeout: detach dataplane timeout policy
and repurpose refcount

stable/6.6 was fixed.

Fixed status
stable/6.6: [1241e459a1bd17044fa6bbb68f491ab5543c3a1b]

CVE-2026-74356: vhost: fix vhost_get_avail_idx for a non empty ring

stable/6.6 was fixed.

Fixed status
stable/6.6: [0fe5ca2d56f0122988016e415a074c95925504b7]

CVE-2026-74385: nvmet-tcp: check return value of nvmet_tcp_set_queue_sock

stable/6.12 was fixed.

Fixed status
stable/6.12: [41b63ff99e3ef37d08f3693413dae5ede5e79fe1]

CVE-2026-74386: nvmet-tcp: fix page fragment cache leak in error path

stable/6.6 was fixed.

Fixed status
stable/6.6: [fc11e3f0daaadb6e600a86e54b089d4662d0a464]

CVE-2026-74388: ALSA: seq: oss: Fix UAF at handling events with
embedded SysEx data

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [e96824274239ae4cd2f7b712644441cdc72c81a3]
stable/6.6: [bc963e193b314f1441082e8b1ffe15eb255d0a44]

CVE-2026-74389: RDMA/hns: Fix log flood after cmd_mbox failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [a6c5f5d98719e69228512390d5db3bf4b6468064]

CVE-2026-74405: OPP: Fix race between OPP addition and lookup

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [1946ea2f6b3ec00e313c78e83fc196f1f6aba2a9]
stable/6.6: [932ebfad767be1395946cbc1727a7c38eeee3d24]

CVE-2026-74407: wifi: ath11k: cancel SSR work items during PCI shutdown

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [daeb44fb8d700654f37f54d1ee36cd67645d0d34]
stable/6.6: [f82d42577ee4a191b0ad0f0a3b49fc1935dff845]

CVE-2026-74506: afs: Fix UAF when sending a message

stable/6.12 was fixed.

Fixed status
stable/6.12: [cbb0d3da042c01082f40166fdc99bf1752db72be]

CVE-2026-74513: dibs: fix use-after-free of dmb_node in loopback
attach/detach/unregister

stable/6.12 was fixed.

Fixed status
stable/6.12: [90b2166605a7476007f7c013521d30b0be557cac]

CVE-2026-74520: iommu/iommufd: Fix IOPF group ownership UAF

stable/6.12 was fixed.

Fixed status
stable/6.12: [8563099bc4b03e1894a983a394225d69b05d9277]

CVE-2026-74533: Bluetooth: ISO: fix race of kfree vs kref_get_unless_zero

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [08ac98f18c8d24cc037858dd6fba2670155e4e84]
stable/6.6: [98666d8feb514fef75fd8553f082bf7dba309d77]

CVE-2026-74537: Bluetooth: ISO: hold sk properly in iso_conn_ready

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [99b65f0ea3370c13687ff870330c425b6ca44e89]
stable/6.6: [44590dc53c9e949d2fed399a571a89c3d7d0b245]

CVE-2026-74538: Bluetooth: ISO: lock sk in iso_connect_ind

stable/6.12 was fixed.

Fixed status
stable/6.12: [0e830354c120954ccb9ca15880245912722c4031]

CVE-2026-74543: net: udp_tunnel: fix memory leak in udp_tunnel_nic_unregister()

stable/6.6 was fixed.

Fixed status
stable/6.6: [52c753b46265243406690d980faa9514d3f53827]

CVE-2026-74559: xsk: drain continuation descs after overflow in xsk_build_skb()

stable/6.12 was fixed.

Fixed status
stable/6.12: [ecd0d1cde0478c232a867f14ec99cf97aff5eb30]

CVE-2026-74560: xsk: fix buffer leak in xsk_drop_skb() for AF_XDP
multi-buffer Tx

stable/6.6 was fixed.

Fixed status
stable/6.6: [c24b3379c0ff00101b9ede54d36f7138d8a02c43]

CVE-2026-74565: netfilter: nf_tables: make nft_object rhltable per table

stable/6.6 was fixed.

Fixed status
stable/6.6: [71714a2cec6c6d79bbd425ad968f9d6a3e4a2066]

CVE-2026-74600: mm/page_table_check: skip special zero mappings

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [51e16e5adadaa78b56f31a1cb02eb7267787625e]
stable/6.6: [f6cf9832e677ec07b1675782bd2bad472cfd3cdc]

CVE-2026-74611: tls: rx: restore msg_iter before TLS 1.3 optimistic retry

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [3c4e21b1bf8e666a1c141e0f5813ece929570deb]
stable/6.6: [c71bacacd59166adbea423a04e7474b0e8245b84]

CVE-2026-74653: serial: 8250_of: clear stuck empty-FIFO RX-timeout on LPC32xx

stable/6.6 was fixed.

Fixed status
stable/6.6: [cc325ce1c40a111824827532ac132afb3d1c342b]

CVE-2026-74684: net: tap: set skb->dev before parsing virtio net
header in tap_get_user_xdp()

stable/6.6 was fixed.

Fixed status
stable/6.6: [61dd022c55c7307ec119e5672cb141cccbecf3b1]

CVE-2026-74687: watchdog: at91sam9_wdt: prevent timer rearm during teardown

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [1beb4dd6a30dea699e98990dd61f892ed1c0985e]
stable/6.6: [a9e0efcb1125e6b452c648671f15920c4955b681]

CVE-2026-74690: s390/ism: Fix UAF of sba and ieq during ism_dev_exit()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [58803870ba0841e53b630a1290c6838b091dd128]
stable/6.6: [950dac9e8c4e3cf68fa8c01f77d3ac3b7369c6a9]

CVE-2026-74695: netfilter: nf_flow_table: drop existing skb dst before
skb_dst_set_noref()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [274f544a32c08638ee887f2e27e3235b6b1237d4]
stable/6.6: [4db3b48a966ed479b99cc8319ea9e46d4f7c703b]

CVE-2026-74697: bnxt_en: Disable EOP for TPA on all chips to prevent
data corruption

stable/6.12 was fixed.

Fixed status
stable/6.12: [927e2617a36f49752cb5613900ca21f40593f07d]

CVE-2026-74711: hwmon: (pmbus) Fix type confusion in notification logic

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [1c8dd39d48494cceb2c27c1911cbf26d10ce8514]
stable/6.6: [ce443f6827b97e03a0fb34ebfddc8939c85e0500]

CVE-2026-74728: xfs: handle NULL b_addr in xfs_buf_free

stable/6.12 was fixed.

Fixed status
stable/6.12: [444ff50ece93060131ad84fbd3f378723d8ac243]

CVE-2026-74734: firewire: ohci: fix NULL pointer dereference in
ar_context_release

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [ca2fa74f3200ced6e0a940753ad99844c42ad7c8]
stable/6.6: [3770a4794a14331c8ca6a674e49c021827521c2c]

CVE-2026-74735: l2tp: fix tunnel and session refcount leak on seq_file release

stable/6.6 was fixed.

Fixed status
stable/6.6: [bd897e414451fb34dfdf08b31899180e5ab7149b]

CVE-2026-74752: sctp: validate cookie AUTH state before use

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [7f17984cfa697613800eb693e183b06884129bd3]
stable/6.6: [4a4410de8dc6903d859c9e1731fc6dcee28bd072]

CVE-2026-80576: drm/amdgpu: reject oversized IBs with per-ring packet limits

stable/6.6 was fixed.

Fixed status
stable/6.6: [67a5d905c17a5066b0f6f950da11da93d56d122b]

CVE-2026-80581: ASoC: SOF: ipc4-pcm: Continue the pipeline trigger in
case of IPC timeout

stable/6.12 was fixed.

Fixed status
stable/6.12: [96d51b8c5a909937d41f9c03495188d4190f877d]

CVE-2026-80607: tracing/probes: Remove WARN_ON_ONCE from parse_btf_arg

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [e177f1530af440d9330c149080aa3b24ddefa18b]
stable/6.6: [24a753a49d06813a156695e3804dcc11c7fdef07]

CVE-2026-80611: ACPI: processor_idle: Mark LPI enter functions as __cpuidle

stable/6.6 was fixed.

Fixed status
stable/6.6: [c17fe25dcb55ab94f6aa2930b7504ea666d5fcc2]

CVE-2026-80614: net: emac: Fix NULL pointer dereference in emac_probe

stable/6.12 was fixed.

Fixed status
stable/6.12: [90bb7164878b5e57d447f02c71c238f4f246016a]

CVE-2026-80616: ieee802154: Avoid calling WARN_ON() on -ENOMEM in
cfg802154_switch_netns()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [f300e68014cf10af9aa0c0ad958750a8509c8e44]
stable/6.6: [c67e70202cfd602f86d3e59fe6fffecaf4110f40]

CVE-2026-80623: coresight: ete: Always save state on power down

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [f58d17798882a3aa3323f9d80fe85e25a38f4b93]
stable/6.6: [31633ba13cc49017015f606d5c66eaf5052e99a8]

CVE-2026-80628: ALSA: seq: oss: Serialize readq reset state with q->lock

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [af74390983cae3e5e551a533d6fcfc9b8c1a8b9e]
stable/6.6: [bf862fdee4831fe1dbde20891db4b29b8f9972f7]

CVE-2026-80629: octeontx2-af: npc: Fix size of entry2cntr_map

stable/6.6 was fixed.

Fixed status
stable/6.6: [30e5ee98e86ad47c76695458987097e849d0611a]

CVE-2026-80637: netfilter: synproxy: fix unaligned memory access in
timestamp adjustment

stable/6.6 was fixed.

Fixed status
stable/6.6: [95cda0446f51077c343fdd8264be2737eb25a6c3]

CVE-2026-80643: EDAC/igen6: Fix call trace due to missing release()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [449ba210e6bee9ef6e69c6ab58198ffa5aa479ae]
stable/6.6: [fa9560b6d3f665eddf7a625adfc9af8c6980c3f5]

CVE-2026-80650: media: atomisp: gc2235: fix UAF and memory leak

stable/6.6 was fixed.

Fixed status
stable/6.6: [592a0e78ab08f6373c40912365759d8a066e7711]

CVE-2026-80653: scsi: hisi_sas: Add slave_destroy interface for v3 hw

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [f8bf667891e92fbe13d02671d4637775ab3118f0]
stable/6.6: [c305853027c04f34435ca4edace772709d70a4fe]

CVE-2026-80654: soc: xilinx: Shutdown and free rx mailbox channel

stable/6.6 was fixed.

Fixed status
stable/6.6: [75ed49f973d790ca3111fcabd516c0b5fd0170b4]

CVE-2026-80662: cxl: Fix CXL_HEADERLOG_SIZE to match RAS Capability size

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [e3e8f3b760bcf6a4b3aec412015b74b578729006]
stable/6.6: [d031617045dc743764ea574432e5c2a3757b4e57]

CVE-2026-80668: netfilter: nf_conntrack_expect: use conntrack GC to
reap expectations

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [02f7809a19fc88cfd9bc113a4bfe7add6305db39]
stable/6.6: [3d7b808ec35291ee75dcdb2b6fe5f587bfe9b1df]

CVE-2026-80676: Drivers: hv: vmbus: use generic driver_override infrastructure

stable/6.6 was fixed.

Fixed status
stable/6.6: [a1656234a4a2dc6e975546867887c5f63e4a90f0]

CVE-2026-80694: net: ethernet: mtk_eth_soc: pass eth to
mtk_handle_irq_rx in poll_controller

stable/6.6 was fixed.

Fixed status
stable/6.6: [a9133c4d335e48ba92f4daed10c506378924f976]

CVE-2026-80695: hwmon: (sht3x) Fix unaligned accesses

stable/6.6 was fixed.

Fixed status
stable/6.6: [c41fa44be44e452e7aec2081195488d685026761]

CVE-2026-80704: drm/amd/display: use proper context for logging

stable/6.6 was fixed.

Fixed status
stable/6.6: [07b52a41765722ec971e0cd9739b140bf4933998]

CVE-2026-80734: btrfs: initialize inode mapping flags for cached inodes

stable/6.12 was fixed.

Fixed status
stable/6.12: [e4d997a1ec1d0dbb72dde35a99fda1850fee6a53]

CVE-2026-80755: selinux: reject a permission value exceeding the class
permission count

stable/6.6 was fixed.

Fixed status
stable/6.6: [9a1bd9fd1326655dfc31b18ca92ea8433cb31204]

CVE-2026-80761: Bluetooth: ISO: zero the sockaddr before returning it in getname

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [554594d032aa4356ca4be75d0cb46e13d350dbd2]
stable/6.6: [90be10604936c9042dc6238d8836abafca471811]

CVE-2026-80847: tcp: clamp route advmss to TCP_MIN_MSS

stable/6.6 was fixed.

Fixed status
stable/6.6: [788fbbf7d61f9742298417c207c91b6db159fbbc]

CVE-2026-80864: RDMA/rxe: Fix responder UAF on
IB_QP_MAX_DEST_RD_ATOMIC modify_qp

stable/6.6 was fixed.

Fixed status
stable/6.6: [82257379061c0a7aba6c77081d988339982af115]

CVE-2026-80897: netfs: release readahead folios on iterator preparation failure

stable/6.12 was fixed.

Fixed status
stable/6.12: [9ef7c3c5cf771286f187aed199dac0972404cc0f]

CVE-2026-80905: net: tap: fix wrong transport_header when sending
VLAN-tagged frame

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [f1d297cad5c1eacd9fadfd0346ad97405ffbf97c]
stable/6.6: [c0376820922d255ae1d103c32345a6ec4c3266f7]

CVE-2026-80920: io_uring: defer eventfd signaling when queued from a
wakeup handler

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [9d984451baf768ecd9e1fdad4637b729fcb2c9d5]
stable/6.6: [d0c240f25e654442a72af5ca021a02165ccce638]

CVE-2026-80935: wifi: mt76: mt7996: bound the device EEPROM address
before the EFUSE copy

stable/6.6 was fixed.

Fixed status
stable/6.6: [4892be1ef0bbe6db6b13bf46cb79b6706bb5b214]

CVE-2026-80937: wifi: mt76: mt7915: bound the device EEPROM address
before the EFUSE copy

stable/6.6 was fixed.

Fixed status
stable/6.6: [d6774f6af3711143a93281904a928a78652c8b7e]

CVE-2026-80947: wifi: rtl8xxxu: fix use-after-free from rx_urb_wq on stop

stable/6.6 was fixed.

Fixed status
stable/6.6: [17d5ae58973122eea7625a87cd3d80a8beb23b47]

CVE-2026-80948: wifi: iwlwifi: dvm: fix memory leak in iwl_op_mode_dvm_start()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [2d593f32efa9ff1c91c508f45eb709c03dfb4945]
stable/6.6: [7be73911d979bb0f54485c2292043a5703fdc953]

CVE-2026-80974: mfd: sm501: Fix potential memory leaks during remove

stable/6.6 was fixed.

Fixed status
stable/6.6: [b78e34ed7e97763d493d95a5c1edefffbfd2f356]

CVE-2026-80980: net/smc: stop killed, freed and out_of_sync sharing a byte

stable/6.6 was fixed.

Fixed status
stable/6.6: [297e96f38d3e4f1a3b84068950dd5c7a55bbdc7b]

CVE-2026-80991: net: ravb: serialize PTP clock teardown

stable/6.6 was fixed.

Fixed status
stable/6.6: [b917f37bfcce919a969d66a044580a95b11df31c]

CVE-2026-80996: net: l2tp: do not propagate multicast notification errors

stable/6.6 was fixed.

Fixed status
stable/6.6: [7efe1c31e0903a5aa796feb96d3adab574b7ff41]

CVE-2026-81016: platform/x86/amd/pmc: Propagate SMU errors and
validate S2D address

stable/6.6 was fixed.

Fixed status
stable/6.6: [85ef9d4c384c1d143c51580933674d94dba3b8d9]

CVE-2026-89437: platform/x86: int1092: Fix potential memory leak in sar_probe()

stable/6.6 was fixed.

Fixed status
stable/6.6: [d680ce2b39f9a635365746d0ada3d6a6d861789b]

CVE-2026-89439: platform/x86: ISST: Add a NULL check for sst_inst[]

stable/6.6 was fixed.

Fixed status
stable/6.6: [f7c9370dd1d3cedb80c635528271cab1d0bcb103]

CVE-2026-89441: mmc: via-sdmmc: cancel card-detect work on remove

stable/6.6 was fixed.

Fixed status
stable/6.6: [55d71c70f11d9f92c7d2653774001e98cb509deb]

CVE-2026-89451: iommu/sva: Set handle->dev before the SVA handle is visible

stable/6.6 was fixed.

Fixed status
stable/6.6: [c4c71368bc5c5b3840590d39b4cfa12d733cadf4]

CVE-2026-89452: iommu/msm: Unwind probe state on registration failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [6a1ae472113762f794682229a0f233f1ee0f69a4]

CVE-2026-89462: power: supply: max17040: propagate register read errors

stable/6.6 was fixed.

Fixed status
stable/6.6: [bcdcbef9c5e69a1e79c6b9f6a3434da2f68724ed]

CVE-2026-89467: power: supply: qcom_battmgr: fix use-after-free

stable/6.6 was fixed.

Fixed status
stable/6.6: [35964ed01e10b61a30066b0c568aa0e0e8fb6432]

CVE-2026-89468: power: supply: lp8788-charger: fix use-after-free on remove

stable/6.6 was fixed.

Fixed status
stable/6.6: [4e3d3923976a986cc3cf960d13f1264cea8a9bba]

CVE-2026-89472: power: supply: charger-manager: register regulators
before exposing sysfs

stable/6.6 was fixed.

Fixed status
stable/6.6: [6e1645a6ee85d070c2d8dd847f1ce110dc2455c1]

CVE-2026-89484: lockd: fix NULL dereference on lockowner allocation failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [6db5af172ccc3223c8f730a9a4212f6427feee3e]

CVE-2026-89492: ocfs2: validate directory-index entry counts when
reading metadata

stable/6.6 was fixed.

Fixed status
stable/6.6: [aad3129b8e915d0ff492bb7517d825d8490cfdd9]

CVE-2026-89520: sched/core: Make core-sched flips wait for in-flight selections

stable/6.6 was fixed.

Fixed status
stable/6.6: [a2a16896ed53046f275f56a6cd8ca3fb6f12c4f3]

CVE-2026-89526: svcrdma: Validate Read chunk positions before reconstruction

stable/6.6 was fixed.

Fixed status
stable/6.6: [3861eeabaebe243050952b34063763527c44e1fe]

CVE-2026-89528: svcrdma: Reject Read lists that exceed the page budget

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [e70fdb121171c3eb0ac34eb545721828cd737717]
stable/6.6: [beb4e9801f6362436102acc4cc5304b7324f9365]

CVE-2026-89530: svcrdma: Reject inline replies that overflow the pull-up buffer

stable/6.6 was fixed.

Fixed status
stable/6.6: [8068358f445a11296328ffa7c524701596814a17]

CVE-2026-89531: svcrdma: Reject connection when transport allocation fails

stable/6.6 was fixed.

Fixed status
stable/6.6: [5bf47bbea3c22c0af2293b6c393ab04d5420f7ab]

CVE-2026-89539: SUNRPC: reject duplicate CREDS_VALUE options

stable/6.6 was fixed.

Fixed status
stable/6.6: [4b5ebb4f91a6152a0f7b1253f701197e5710d4da]

CVE-2026-89543: sunrpc: fix use-after-free in __rpc_clnt_handle_event
and __rpc_clnt_remove_pipedir

stable/6.6 was fixed.

Fixed status
stable/6.6: [f99fedfd1dbffe8d20b421c9a7d4655a135d4fcd]

CVE-2026-89544: SUNRPC: fix gssx_dec_option_array error path bugs

stable/6.6 was fixed.

Fixed status
stable/6.6: [8c56a46db3b7523f13e167c3e2c6e3c47a87dcb3]

CVE-2026-89552: params: fix charp corruption on allocation failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [31b41ea8383d51992d6b0dfe3a99da1dec8ce1c1]

CVE-2026-89561: ipv6: rpl: fix NULL dereference of idev in ipv6_rpl_srh_rcv()

stable/6.6 was fixed.

Fixed status
stable/6.6: [62b63a505c10e8db76017ef73c0b243e0dc5d288]

CVE-2026-89564: ip: orphan prefetched skbs before multicast forwarding

stable/6.6 was fixed.

Fixed status
stable/6.6: [882212d317a7c16ab70d20656f6b1c42abada9f6]

CVE-2026-89566: jbd2: check need_resched() when skipping busy checkpoint buffers

stable/6.6 was fixed.

Fixed status
stable/6.6: [dc7ece0b827fe3b748db685fb85cd2fc3710c3f9]

CVE-2026-89567: jbd2: bound shrinker scans by examined checkpoint buffers

stable/6.6 was fixed.

Fixed status
stable/6.6: [6b5366ba63a58819396045ab146bd37ff9e503c6]

CVE-2026-89572: cpufreq: apple-soc: Fix OPP table cleanup

stable/6.6 was fixed.

Fixed status
stable/6.6: [12b54e5aab7c0850d39a51a32200f76d5e15040e]

CVE-2026-89574: dm array: validate array block headers on read

stable/6.6 was fixed.

Fixed status
stable/6.6: [0e3b8f371c385c212b6e6f76c66f5b3f5bcfea62]

CVE-2026-89580: bpf: Disable preemption in __bpf_get_stack

stable/6.6 was fixed.

Fixed status
stable/6.6: [719e69421de28829c72bf8a2722ab48a1c5a59ad]

CVE-2026-89622: HID: mcp2221: clear rxbuf after I2C/SMBus transfer completes

stable/6.6 was fixed.

Fixed status
stable/6.6: [bd146a8ff107c6d77e75597decbcd1df0d7900d6]

CVE-2026-89624: HID: universal-pidff: stop the device when
force-feedback init fails

stable/6.6 was fixed.

Fixed status
stable/6.6: [66358f5789c9a7e28809985a83c01e6ad933849e]

CVE-2026-89625: HID: sony: fix UAF of ghl_poke_timer / ghl_urb at driver unbind

stable/6.6 was fixed.

Fixed status
stable/6.6: [56ef23198bdd51644372b1a9917802544b30987a]

CVE-2026-89631: smb: client: reject a tree connect response whose byte
count is too small

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [2ae219762ebac929bf6ab3473681f10ed566af08]
stable/6.6: [d837645a719151ed392d4d9cab4571c2753dab12]

CVE-2026-89632: smb: client: fix use-before-check of ReparseDataLength
in reparse_buf_ptr()

stable/6.6 was fixed.

Fixed status
stable/6.6: [b70bc592afd19732e2e4563300ebe8f974280365]

CVE-2026-89644: btrfs: fix extent map leak in NOCOW direct I/O write

stable/6.6 was fixed.

Fixed status
stable/6.6: [cb732d302245b14943a5017015fffa8e6db7a6c0]

CVE-2026-89645: btrfs: drop recovered reloc root refs on recovery failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [7b8c6af17287899a5d00c70566831feac237d192]

CVE-2026-89647: ceph: do not repeat ceph_trim_dentries() if no progress possible

stable/6.6 was fixed.

Fixed status
stable/6.6: [dd2e9824e5e7dba406005ff779a107f773175a76]

CVE-2026-89648: ceph: cap delegated inode count in ceph_parse_deleg_inos()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [7fc55e8e6b6b50f217b1728415578704baf4d0a2]
stable/6.6: [8194d8e61ef0b49baddf660c7e88fc1c563a5e55]

CVE-2026-89659: NFSD: Prevent client use-after-free during delegation revoke

stable/6.6 was fixed.

Fixed status
stable/6.6: [94f0c73797c30a35812ffb32d11b8737d245c405]

CVE-2026-89666: nfsd: reject out-of-range nseconds in NFSv3 SETATTR
and create ops

stable/6.6 was fixed.

Fixed status
stable/6.6: [98fc1d21a7b80324ba64b949ac6bcc00364dd068]

CVE-2026-89676: nfsd: fix stale s2s_cp_stateids IDR entry for async COPY

stable/6.6 was fixed.

Fixed status
stable/6.6: [bdce362f49410b9def65d76c21f6259cd89696d8]

CVE-2026-89680: nfsd: fix nfsd_file leak on inter-server COPY setup failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [ab949252fdf102ae74329a0caa7995a849d0dafa]

CVE-2026-89682: nfsd: fix fcache_disposal UAF by inlining dispose
state into nfsd_net

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [9c8ac7c2b9b150e13b7ad0d0fae54f17747dce67]
stable/6.6: [e6c3a43d0a41f03abae3764fc82a59369360c7e0]

CVE-2026-89685: nfsd: fix clock domain mismatch in clients_still_reclaiming()

stable/6.6 was fixed.

Fixed status
stable/6.6: [04c3e4456fe76e8d7c94171009df3165c3262c51]

CVE-2026-89686: nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on
racing delegation revoke

stable/6.6 was fixed.

Fixed status
stable/6.6: [d12af460df27876661707efab3a8532146cb961f]

CVE-2026-89693: nfsd: check nfsd4_acl_to_attr() return value in nfsd4_create()

stable/6.6 was fixed.

Fixed status
stable/6.6: [2d8a8ed4f9d8637ef0f18d47d19193e7b780e90e]

CVE-2026-89702: nfsd: size fh_verify server sockaddr slot by xpt_locallen

stable/6.6 was fixed.

Fixed status
stable/6.6: [1c6a4d6c20fd42552ffc2c3dfaed2139c9477ee5]

CVE-2026-89713: NFSD: check truncate permission under inode lock

stable/6.6 was fixed.

Fixed status
stable/6.6: [52d0c5bdfe232c9974d4b11f97078b9c7814f05d]

CVE-2026-89717: zram: set default primary compressor in zram_destroy_comps()

stable/6.6 was fixed.

Fixed status
stable/6.6: [a5fda7def04d98ab7c5cbb2394714fb1f8c56cb5]

CVE-2026-89719: zram: fix out-of-bounds access in read_block_state()

stable/6.6 was fixed.

Fixed status
stable/6.6: [f5e9f3a75efc774f17ab3f33826630d7fe30c7ea]

CVE-2026-89738: usb: gadget: at91_udc: drain polled-VBUS timer/work
before udc is freed

stable/6.6 was fixed.

Fixed status
stable/6.6: [723d73b245843d4fff4c3f42e857c78c2b2d414e]

CVE-2026-89740: serial: imx: serialize imx_uart_ports[] lifetime

stable/6.6 was fixed.

Fixed status
stable/6.6: [abc17fd508a511669997e48f8b014d8aa043abdf]

CVE-2026-89755: mm/migrate_device: clear stale mapping after freeing swapcache

stable/6.6 was fixed.

Fixed status
stable/6.6: [92db780dd644590c751246187e1229d5ac2e5544]

CVE-2026-89757: mm/mglru: fix and remove redundant unevictable folio handling

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [49193dac48d30eee2a21da88a7262d52a7feefae]
stable/6.6: [b1d7c69e6c7d3ec47513b911ce7529e56d183dad]

CVE-2026-89759: mm/kmemleak: avoid soft lockup when scanning task stacks

stable/6.6 was fixed.

Fixed status
stable/6.6: [f1cd6c4c35243377882c47236281d03ee3be6eeb]

CVE-2026-89761: apparmor: fix out-of-bounds write when null
terminating a label vec

stable/6.6 was fixed.

Fixed status
stable/6.6: [b17c8f5dcb36a032688847b2bce4bd813b4baad1]

CVE-2026-89762: apparmor: fix cred UAF caused by
begin_current_label_crit_section()

stable/6.6 was fixed.

Fixed status
stable/6.6: [089f10b47843a86fa03a8c20799c9353660e5288]

CVE-2026-89763: KEYS: trusted: Fix TPM teardown ordering

stable/6.6 was fixed.

Fixed status
stable/6.6: [81dfc6c665547a4e41721b6716f894f263a5e03f]

CVE-2026-89788: ksmbd: fix tree connection use-after-free in smb2_tree_connect()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [bd58a52738f7576ee5f5eb74243df13f902c8051]
stable/6.6: [ca3a3984bf445aaec69f6937f11e560d4b849365]

CVE-2026-89794: ksmbd: zero pipe read compound padding

stable/6.6 was fixed.

Fixed status
stable/6.6: [134d980491b435e5cdb3171225e2506ff17867d1]

CVE-2026-89795: PCI: Allow per function PCI slots to fix slot reset on s390

stable/6.6 was fixed.

Fixed status
stable/6.6: [b4a80e9e639cf09ef5c66b7f262c9cb5ab37bdde]

CVE-2026-89799: bpf: Disable preemption in bpf_get_stackid

stable/6.6 was fixed.

Fixed status
stable/6.6: [e79a70c2e97ae36bbdd371f0ce88a525f7b49f01]

CVE-2026-89802: drm/nouveau/uvmm: fix NULL deref unwinding an OP_MAP_SPARSE op

stable/6.6 was fixed.

Fixed status
stable/6.6: [d8ec34618e71018fd7a3f73c57c6b92d71a6c7c3]

CVE-2026-89803: drm/nouveau: unsubscribe the channel-kill event before
the fence context

stable/6.6 was fixed.

Fixed status
stable/6.6: [5db663fbff7b88aeeeecaf5220e177e524165101]

CVE-2026-89806: drm/sysfb: ofdrm: Fix integer overflow in fb_size calculation

stable/6.6 was fixed.

Fixed status
stable/6.6: [0cec951667a624fafaca2695c46042f45851caec]

CVE-2026-89808: drm/amdkfd: Fix the case that vm range is hole at
svm_migrate_copy_to_vram

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [bd1adb2e5101db649121b59e601c92773a302a70]
stable/6.6: [6e1a6f3ddb87d7f89a775c55fb399680c02bdcc2]

CVE-2026-89810: drm/amdkfd: Fix error path at svm_migrate_copy_to_ram

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [872b7427e64f3e84b16c62577cbf3cd09a3401a2]
stable/6.6: [44cad7ea3532f14999008d899daacc4ce4b633bf]

CVE-2026-89811: drm/amdkfd: Add TLB flush after MES queue eviction/suspension

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [bbf5ad5268f36d7ebb7e99ae78fc73cffe98d372]
stable/6.6: [5bbd7f283312d0209a0fedcc9d2d33b5afa5a7b1]

CVE-2026-89827: drm/amdgpu: avoid force-completing uninitialized UVD rings

stable/6.6 was fixed.

Fixed status
stable/6.6: [668cfb8ab3e22c10fe74307aac86b3cf456d6923]

CVE-2026-89832: f2fs: fix to clear dirty flag on folio in error path

stable/6.6 was fixed.

Fixed status
stable/6.6: [21b7f66716b4fd0dffac4fcd06602b888f3c4531]

CVE-2026-89833: f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [bdc06381d590ad5833ee7a2c56b8b685d80ee9b5]
stable/6.6: [58ca9f06480457eb9c9513e1ae2b75316d4ed1e5]

CVE-2026-89834: f2fs: fix to migrate all curseg types during free_segment_range

stable/6.6 was fixed.

Fixed status
stable/6.6: [d358d2fc6be11eefde5eb1286f1c43a6d0330db6]

CVE-2026-89835: f2fs: avoid NULL checkpoint thread access in sysfs

stable/6.6 was fixed.

Fixed status
stable/6.6: [22760e3e9cecbddc475edc91600787abf407a302]

CVE-2026-89837: f2fs: fix dentry folio leak in find_in_level

stable/6.6 was fixed.

Fixed status
stable/6.6: [b6c0e77d950bf80ab357e2b4b9667f4389ed417c]

CVE-2026-89838: f2fs: limit recovery filename logging to stored length

stable/6.6 was fixed.

Fixed status
stable/6.6: [e754120f8ede55cc773ade108cf7e5b17c859c46]

CVE-2026-89840: f2fs: validate MOVE_RANGE destination size

stable/6.6 was fixed.

Fixed status
stable/6.6: [54c587f3f95ce2d6932a16566db83f73cc4313e1]

CVE-2026-89859: scsi: qla2xxx: Zero dport diagnostics buffer to avoid info leak

stable/6.6 was fixed.

Fixed status
stable/6.6: [2ecc30066c2284d2ed11bbd576ec97156b384054]

CVE-2026-89884: media: platform: mtk-mdp3: fix NULL deref on failed SCP lookup

stable/6.6 was fixed.

Fixed status
stable/6.6: [7cdb1e2d3b0e56385610b6e47e88783e8c4effc4]

CVE-2026-89906: LoongArch: BPF: Refactor jump offset calculation in tail call

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [89819868cde78cb2f748533785a46a3430873f20]
stable/6.6: [50fbc294e4e96246d60cd66f98acf043a362e3a0]

CVE-2026-89913: KVM: arm64: vgic-v3: take an LPI reference in
vgic_v3_save_pending_tables

stable/6.12 was fixed.

Fixed status
stable/6.12: [4000462866bc71f16d1bfb3cf8e969f95150cd64]

CVE-2026-89920: KVM: s390: Fix memory corruption by not reinjecting CK
machine checks

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [b7631982fb65dd355acd18e62b384bc8125e9c44]
stable/6.6: [5c63e2ed840c85e27172ab78e7db3ac77fba281b]

CVE-2026-89921: KVM: s390: Zero initialize data structures for
inject_pfault_token

stable/6.6 was fixed.

Fixed status
stable/6.6: [ab1a8a3c9971200938093370da4c67d4427c25f2]

CVE-2026-89929: KVM: nVM: Ensure INVVPID is emulated on the correct physical CPU

stable/6.6 was fixed.

Fixed status
stable/6.6: [1759a565a25c814ced9281a708749c71fa69d6fe]

CVE-2026-89934: iio: light: ltrf216a: fix runtime PM reference leak in
error path

stable/6.6 was fixed.

Fixed status
stable/6.6: [4bf5525c6ff4a9f8df35bcc227a918b6396b2cb5]

CVE-2026-89944: ASoC: hdac_hda: Fix hlink refcount leak on component
registration failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [60b5824ae259ad15f7878e4e763ec31ba4db55f2]

CVE-2026-89956: s390/vfio-ap: Fix missing lock required to access list
of ap_matrix_mdev objects

stable/6.6 was fixed.

Fixed status
stable/6.6: [22dc712c170efc1a549e3f872467c880be995ac7]

CVE-2026-89962: powerpc/kexec_file: Prevent kexec range truncation

stable/6.6 was fixed.

Fixed status
stable/6.6: [ffbdc2a3834a3e47bac7236a71bbc82b45c83832]

CVE-2026-89972: nvme: add missing SRCU grace period in error path

stable/6.6 was fixed.

Fixed status
stable/6.6: [3868476cd39161f18720582df17a1b621e805b5d]

CVE-2026-89975: nvme-fabrics: fix DHCHAP secret leak on parse failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [3ce0e9b43f355dfa0bdc0e0dd889795752285791]

CVE-2026-89987: mm/huge_memory: transfer the pmd dirty bit to the folio on zap

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [fd720d3906877b3d2118cd480027e4bc6648f0c5]
stable/6.6: [6e904f9e8cb0e39f60e1cdbea679f89346a563c2]

CVE-2026-89995: dma-direct: return struct page from dma_direct_alloc_from_pool()

stable/6.6 was fixed.

Fixed status
stable/6.6: [7801e616fbe3661f9471b2e9bfcb1ed35460bf16]

CVE-2026-89996: dma-buf: dma-heap: don't publish fd before
copy_to_user() succeeds

stable/6.6 was fixed.

Fixed status
stable/6.6: [ad61defb3e66ac0c598ad6f39b57f15784543d46]

CVE-2026-90002: ftrace: Take trace_array reference before accessing
its ftrace_ops

stable/6.6 was fixed.

Fixed status
stable/6.6: [29266da8ee1d9be656b1f22460c49538e1930658]

CVE-2026-90013: tracing: Take trace_array reference when opening options file

stable/6.6 was fixed.

Fixed status
stable/6.6: [8cc9c5a8c559d655c32d2190486e89574c14ff52]

CVE-2026-90016: staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()

stable/6.6 was fixed.

Fixed status
stable/6.6: [716850842d2f103f915fe7c857ff1a0a036491b4]

CVE-2026-90021: usb: gadget: f_midi: initialize work in f_midi_alloc()

stable/6.6 was fixed.

Fixed status
stable/6.6: [13e9f5a91360952b9b5bbc2367fc29d4a4ff2824]

CVE-2026-90023: usb: gadget: f_mass_storage: fix null pointer
dereference in fsg_common_set_num_buffers()

stable/6.6 was fixed.

Fixed status
stable/6.6: [f4f0fe3ab47ed57ee4974fdd3e9dccb7839a7ebf]

CVE-2026-90029: usb: storage: realtek_cr: fix use-after-free on disconnect

stable/6.6 was fixed.

Fixed status
stable/6.6: [c1e7e35100efffba7c9e1dfa76519d6cd323ba3d]

CVE-2026-90030: usb: dwc3: clear forceRM when issuing EndTransfer

stable/6.6 was fixed.

Fixed status
stable/6.6: [7a50e138fa28e5ba76b11af66ed41cc300c0f2be]

CVE-2026-90036: NFSD: Prevent client use-after-free during blocked-lock reaping

stable/6.6 was fixed.

Fixed status
stable/6.6: [0d53a47c913d0bce3b5ec35c28cbcca4d015f33d]

CVE-2026-90037: NFSD: Prevent client use-after-free during close_lru reaping

stable/6.6 was fixed.

Fixed status
stable/6.6: [adc34b5df5c5d87043cb500b0867fc1c4ad0117e]

CVE-2026-90041: HID: sony: clean up device list on probe failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [7ee50d42a6d5c8cf3d8afb3285273bcc58452214]

CVE-2026-90042: ceph: properly decrypt filenames in vmalloc() buffers

stable/6.6 was fixed.

Fixed status
stable/6.6: [23c5cc9652c6ee85617002cb66e1068395045de6]

CVE-2026-90044: usb: gadget: f_fs: Fix Use-After-Free in AIO error path

stable/6.6 was fixed.

Fixed status
stable/6.6: [0a2f71ccf9c2053de725e9a7922d081f3f3a3804]

CVE-2026-90045: USB: gadget: ffs: fix mm lifetime handling

stable/6.6 was fixed.

Fixed status
stable/6.6: [aee2fde0f39e2b667084f4d5cc323a5c5543d733]

CVE-2026-90052: [REJECTED]: dm-integrity: fix buffer overflow with keyed discard

stable/6.12 was fixed.

Fixed status
stable/6.12: [d147391c3b952ab21d9b487c879566ef8611fcbb]

CVE-2026-90060: ALSA: control: Don't add invalid kcontrols to LED layer

stable/6.6 was fixed.

Fixed status
stable/6.6: [3b8a540b36aa064822c701e4e0a1dea2cd4ec5b0]

CVE-2026-90076: net/sched: fq: add overflow bounds to quantum and
initial quantum

stable/6.6 was fixed.

Fixed status
stable/6.6: [fd63409b669f9951f1cc6b02486a5254103800d1]

CVE-2026-90083: net/sched: act_ife: Only operate on Ethernet frames

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [13dddf87a1f89557920f9b437a21ea0b7225f828]
stable/6.6: [b951dd2fd5ede007474fc134ecb5639e1f86f5de]

CVE-2026-90084: octeontx2-vf: fix workqueue and netdev race in probe/remove

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [00dda563f4963f28fab46d09b912d68268b8e7a5]
stable/6.6: [bdc530baf079eee104f9ea5d83815e798ea155df]

CVE-2026-90086: xsk: honor XDP_TX_METADATA in zero-copy path

stable/6.12 was fixed.

Fixed status
stable/6.12: [8ba0d143e471c85f8a116707c0b42bf046b0a7b3]

CVE-2026-90097: Drivers: hv: vmbus: Skip VMBus module cleanup for
non-nested root partition

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [ca1f4a926d08035c52c735a42200e4e5ea548f32]
stable/6.6: [4cc1ba2b31065a48fde14e9d53ad399a3ca32e35]

CVE-2026-90109: net: sched: fix 32-bit backlog wrap in gred, bfifo and
plug enqueue

stable/6.6 was fixed.

Fixed status
stable/6.6: [c5ca77024812563fe15c4f7aa906791c3683e9fd]

CVE-2026-90112: net: qlcnic: validate unified ROM sections before loading

stable/6.6 was fixed.

Fixed status
stable/6.6: [43451ec94fb67ae1715faf29e9e6ab20ecbd42f4]

CVE-2026-90116: ALSA: mtpav: shut down output timer before card teardown

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [de75857ce374671712e1d9528844e3c0543dcef6]
stable/6.6: [793163e134028e7136c9dd9e30f7f656de1eabba]

CVE-2026-90135: net: add missing ref_tracker_dir_exit() to alloc_netdev_mqs()

stable/6.6 was fixed.

Fixed status
stable/6.6: [45be87c5195f34c0a51598bc91186f600be5c4c9]

CVE-2026-90138: vsock: don't check the listener's sk_err in vsock_accept()

stable/6.6 was fixed.

Fixed status
stable/6.6: [64348c55dd7596ca2c033dcd102af44bdd7e8acd]

CVE-2026-90148: NFSv4: Fix incorrect argument passed to
nfs4_delete_lease() in nfs4_add_lease()

stable/6.6 was fixed.

Fixed status
stable/6.6: [e25e5b4a764638ec9e2dc6c9affe080c922ea1f2]

CVE-2026-90149: NFSv4/flexfiles: fix NULL dereference for NFSv4.0 data servers

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [5527af72b0100c94287bfec901b6313eeac567ca]
stable/6.6: [336b6da10021c69a8f273bbacdf7432fdc89a06f]

CVE-2026-90150: pnfs/blocklayout: Fix device leaks on parse failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [51d162dfb618f6cf3aa5e331c0305e27771ad884]

CVE-2026-90152: smb/server: fix session leak in ksmbd_session_register()

stable/6.6 was fixed.

Fixed status
stable/6.6: [988f99bfddda4e2d1da5f6e98b237dd85e123cee]

CVE-2026-90161: erofs: fix interlaced ztailpacking pclusters

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [cd59f91cbc1e715cb5dc65773ee22123d70cb8f2]
stable/6.6: [795dca34a41545d377d19bc492b10bc789772410]

CVE-2026-90166: smb/server: fix null-ptr-deref in
ksmbd_ipc_tree_connect_request()

stable/6.6 was fixed.

Fixed status
stable/6.6: [5ffd180307a5ea34dae7f90ff9573ebed6b7fb12]

CVE-2026-90179: apparmor: fix deadlock in complain-mode change_hat

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [91fce09d89b2d397996226216820f0e8b8149e22]
stable/6.6: [5f1fedccf3f7add5e2a1205ac4938fa3893c5874]

CVE-2026-90187: null_blk: free zones array on device power-off

stable/6.6 was fixed.

Fixed status
stable/6.6: [08a31a2cc3d1cea67ccd292d01511cd0a72d4656]

CVE-2026-90204: ocfs2: validate DIO orphan slot during inode read

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [8f7a2c5cf23d437acab7f3e739bfcad0f443c554]
stable/6.6: [eacdd27ca829747d4372fbae8617151072a4d1e5]

CVE-2026-90205: ocfs2: validate orphan slot during inode read

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [dea50e8049b0db2eb3d468e2505034962e81d8cd]
stable/6.6: [f535a34831f8325950933b401c76bfa99624419c]

CVE-2026-90213: firewire: core: fix memory leak in error path of build_tree()

stable/6.6 was fixed.

Fixed status
stable/6.6: [45c534c5bf43a094805a79510d1ea3ca261ea042]

CVE-2026-90231: apparmor: fix unconfined user namespace restriction forced stack

stable/6.12 was fixed.

Fixed status
stable/6.12: [fdd341654471cae4fbd9635d32b848cd0c8bc437]

CVE-2026-90232: amt: Don't support cross-netns setup.

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [5ebaad6cf2a639afbf0b265f9a7d1fb6f656a37e]
stable/6.6: [a457ff1189f22c2f15f69df55dc910b8b6d7a77d]

CVE-2026-90240: iommu/vt-d: Flush context cache with correct SID when
tearing down aliases

stable/6.12 was fixed.

Fixed status
stable/6.12: [3eb6ad14ef359e426cff14942e220de101cdbe84]

CVE-2026-90247: bpf: Fix mmap_lock leak in irq_work path

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [931f62311c058d79f29548f20943969bb441ce87]
stable/6.6: [b6c9daf6097f9b39162b8e736a6ac7caf5ef6fc8]

CVE-2026-90250: bpf, cgroup: Fix storage null-ptr-deref after replacing prog

stable/6.6 was fixed.

Fixed status
stable/6.6: [16c8321ee40c420f8e02e09515a5126682ddf4ea]

CVE-2026-90256: Bluetooth: L2CAP: use proto_lock for l2cap_data to fix
l2cap_disconn_ind

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [7c032b6d48a46634cbd58aaebad2638c00ad3b51]
stable/6.6: [0fa448369c87e20b2aeaeaca0187d698dd61f791]

CVE-2026-90259: btrfs: qgroup: fix a wrong length calculation in
qgroup_free_reserved_data()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [34adc843c28e5cd1f533a1d64f51b0f756fdf945]
stable/6.6: [202ac9e469b78817512921c5db05cc2140e4ca43]

CVE-2026-90260: btrfs: zoned: don't clobber the extent buffer when
zeroing it out

stable/6.12 was fixed.

Fixed status
stable/6.12: [efa5084d08030aa557fdefa3e4a73b2501b7d207]

CVE-2026-90264: btrfs: always wait for ordered extents to avoid OE races

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [de8f5cb3cb611f96909797b4b017831f5141cbbe]
stable/6.6: [043b6fd9706e4335851f317352d2717ad40e6d83]

CVE-2026-90265: btrfs: defrag: fix deadlock between defrag and
delalloc space reservation

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [37614074596827a5f292243673b699c90ff63e7d]
stable/6.6: [c97277aa6ce8ac725642aced0fe20cd8d31f6e09]

CVE-2026-90291: module/dups: Fix use-after-free in kmod_dup_req
lifetime handling

stable/6.6 was fixed.

Fixed status
stable/6.6: [a3205bd1f218053575589b14caf8df667f344134]

CVE-2026-90308: RDMA/erdma: Hold QP references for AE and CM processing

stable/6.6 was fixed.

Fixed status
stable/6.6: [233f1b7fe2980e4e238fe03dd3ceddfd082cb4c8]

CVE-2026-90320: ocfs2: validate external xattr entries when reading metadata

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [ee4ef26927e967ea699b3f0d7ecf97ce044fbc79]
stable/6.6: [dc5778dbd0b6c411107a0e37e913a94b3c2f2728]

CVE-2026-90321: ocfs2: validate inline xattrs during inode block validation

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [8138d06e7a1d9a0b0481dc015c67b34e8bb60a58]
stable/6.6: [7dec19f6bafe4e1503007141c9f5eb7eb10e5578]

CVE-2026-90322: ocfs2/cluster: keep heartbeat local node stable

stable/6.6 was fixed.

Fixed status
stable/6.6: [d64708cc119db01fbc55017ee6e987b680ebd59c]

CVE-2026-90324: ublk: check import_ubuf() return value

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [27ff6e8703f7a7160c728501da2f8ef8e7bb6b2f]
stable/6.6: [7f97c762b5f6e0005c5c7d040ded73bf7fb3587e]

CVE-2026-90326: blk-cgroup: fix race between policy activation and
blkg destruction

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [91062e3a9ed251726df4e20ff9a1113f1c8ded59]
stable/6.6: [17c18a0df70c2b89ff7fcd74622f1540e98d00fd]

CVE-2026-90328: HID: steam: Reject short reads

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [cbcc9b0ccbbd33125ffc9479fb8f69ac969fe55c]
stable/6.6: [37cb84b992718924dc334ce584c703333a6a4217]

CVE-2026-90333: dm-integrity: replace forgeable discard filler with a
keyed sector marker

stable/6.12 was fixed.

Fixed status
stable/6.12: [388c3f6496bb8083576d989e6d249ba9807c6b0b]

CVE-2026-90343: wifi: cfg80211: stop PMSR before P2P and NAN teardown

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [dc1e41df6e683ff9522bf40dd3125ed7ccd8a4e4]
stable/6.6: [9374943fc5a45915e4ea8b597b6a17d3b571bcbf]

CVE-2026-90351: wifi: mt76: mt7996: do not attach hif2 WED when the
main WED attach failed

stable/6.12 was fixed.

Fixed status
stable/6.12: [9d1fd637336588d8118c104a025eca1341d9ec85]

CVE-2026-90358: bpf, x86: Fix trampoline stack size for 128-bit arguments

stable/6.6 was fixed.

Fixed status
stable/6.6: [7f96bf0d24b2acc0732906b60a10f06783f2470d]

CVE-2026-90363: drm/msm: don't tear down KMS twice when KMS init fails

stable/6.12 was fixed.

Fixed status
stable/6.12: [54437ace956dc7b758c0219d6f76654b3ead8d69]

CVE-2026-90367: wifi: mt76: mt7996: hold dev->mt76.mutex while
disabling tx worker in SER

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [69f23622533a4f054b5c8fdb226c3319ffa017b6]
stable/6.6: [bc4f4389f439e808185778d298da36976d13d415]

CVE-2026-90368: wifi: mt76: mt7915: unwind state on add_interface failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [7198d8fcfdd3ebef3dfbb6073267a053b09f6a05]

CVE-2026-90374: wifi: mt76: mt7996: validate RX band_idx before
dereferencing phys[]

stable/6.6 was fixed.

Fixed status
stable/6.6: [493a029c205a994644327d554f0cfeb9651aba7c]

CVE-2026-90375: wifi: mt76: fix non-AQL packet accounting for MLO stations

stable/6.6 was fixed.

Fixed status
stable/6.6: [2c321f86846ead00552bc65f73f5b5f1f81d4023]

CVE-2026-90383: misc: sgi-gru: remove interrupt-context page-table walks

stable/6.6 was fixed.

Fixed status
stable/6.6: [5a540ced720b4397306337cab34af1af4b30827c]

CVE-2026-90385: md/raid1: create serial pool adding rdev to array with
serialize_policy=1

stable/6.6 was fixed.

Fixed status
stable/6.6: [0b187e14dab458d54425fc400f1e1e8d481d9bcf]

CVE-2026-90397: firmware: qcom: scm: Fix NULL dereference in IRQ
handler before __scm is published

stable/6.6 was fixed.

Fixed status
stable/6.6: [c9c1e3da0a206270e5df470ca1c82de52190d68c]

CVE-2026-90398: wifi: ath11k: fix stride mismatch in mac_phy_caps_parse()

stable/6.6 was fixed.

Fixed status
stable/6.6: [b2ecd548f89a4a6c14b5eb4abc825f92b3068dda]

CVE-2026-90399: wifi: ath12k: fix stride mismatch in mac_phy_caps_parse()

stable/6.6 was fixed.

Fixed status
stable/6.6: [79c6f4f7d16eea1bcb8bc5c8fd6ec04a01b0614f]

CVE-2026-90422: clk: mediatek: pllfh: Fix IO remapping leak in
register_pllfhs error path

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [111235106099019b8a8d1947dc5c2674e0329ffa]
stable/6.6: [6e3e93bc718c4fea556d7ca5fba07ab3511c9918]

CVE-2026-90424: iommu/tegra241-cmdqv: Fix VINTF0 leak on the init-failure path

stable/6.12 was fixed.

Fixed status
stable/6.12: [05a1405d0cba3d8253261b02eb65e5cd3ca09ab3]

CVE-2026-90433: spi: oc-tiny: switch to managed controller allocation

stable/6.6 was fixed.

Fixed status
stable/6.6: [9265fa8190312b87637def1382d36fc16de3b8e8]

CVE-2026-92488: RDMA/erdma: complete object teardown when the destroy
command fails

stable/6.6 was fixed.

Fixed status
stable/6.6: [3886d944b506e0cc681646beb03c3024cb375a68]

CVE-2026-92519: riscv, bpf: Fix memory leak in bpf_jit_free

stable/6.6 was fixed.

Fixed status
stable/6.6: [7285f004293e7dc043c55369c0dbe8350b28cc45]

CVE-2026-92520: bpf: Zero queue and stack outputs on lock failure

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [23b4bcc79bab5285275912b94e98c286f281de75]
stable/6.6: [a6090eeb289c5fa45f7b629befac2bd3c19a6dae]

CVE-2026-93058: drm/msm: Only fini scheduler after successful init

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [aafc9258efeec98fcb7e3998356b4b25bf1ad159]
stable/6.6: [bd2a5a876904eaf688a093cd73986abc3571f26b]

CVE-2026-93083: firmware: arm_scmi: Unwind TX receiver mailbox setup failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [d4cf99c7ea95accde58df34bc8636bbebb3066c2]

CVE-2026-93090: firmware: arm_scmi: Clean up channels on setup failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [e835bd88ce9ddd858c186317f79e76ffa689c8db]

CVE-2026-93093: firmware: arm_scmi: Publish channel state before callbacks

stable/6.6 was fixed.

Fixed status
stable/6.6: [50e38091a657ad81385e2aea7e2575e17ac23d79]

CVE-2026-93100: fs/resctrl: Prevent use-after-free in rdtgroup_kn_put()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [828ff461c136b95d13b8d712c0a7a06a640e313a]
stable/6.6: [971b40e3ca1279ca4917889e0195d33b66d071a4]

CVE-2026-93128: platform/x86: lg-laptop: Fix LED resource handling

stable/6.6 was fixed.

Fixed status
stable/6.6: [fc45f6e4b86c2fa1cf742c23a373d777d066aa25]

CVE-2026-93146: time/namespace: Validate nanosecond field in
proc_timens_set_offset()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [b20d7085ab314672447322c10cc5d1ba443e3b8e]
stable/6.6: [5b8a40de738b7c4896c2edbc6262bd1b3462ded0]

CVE-2026-93150: cgroup/cpuset: Make nr_deadline_tasks an atomic_t

stable/6.6 was fixed.

Fixed status
stable/6.6: [642648fa7595241e4d491add5007bc33f11defb5]

CVE-2026-93163: hwrng: core - fix rng list on registration error

stable/6.6 was fixed.

Fixed status
stable/6.6: [e37c67f768234e14cd6ea3b081568dd915c5b67e]

CVE-2026-93172: mm/mm_init: handle alloc_percpu failure in
free_area_init_core_hotplug

stable/6.6 was fixed.

Fixed status
stable/6.6: [4dda09e7ca0bf0c3fa7c5c8f134d9804b67f455c]

CVE-2026-93181: perf/x86/intel/uncore: Fix uncore_box ref/unref ordering

stable/6.12 was fixed.

Fixed status
stable/6.12: [3cfd351602e6704cce9bc766a974afb9f745d44b]

CVE-2026-93186: cxl/mbox: Clamp mailbox output allocation to the payload size

stable/6.6 was fixed.

Fixed status
stable/6.6: [d2d40574b9b272ade32d0d77b140d990e7547f5f]

CVE-2026-93192: drm/v3d: Clear queue->active_job when v3d_fence_create() fails

stable/6.6 was fixed.

Fixed status
stable/6.6: [1f661f42beb558b2d21882f0cd527ed6c8e7e749]

CVE-2026-93196: nvdimm: virtio_pmem: refcount requests for token lifetime

stable/6.6 was fixed.

Fixed status
stable/6.6: [41b2025709ec104a07d15540399809ae5851246e]

CVE-2026-93199: i3c: master: Do not treat master device as a duplicate target

stable/6.6 was fixed.

Fixed status
stable/6.6: [7b25b755d59077dd9484ba1360b8fe6396e5ccfb]

CVE-2026-93200: i3c: master: Fix use-after-free of master->this

stable/6.6 was fixed.

Fixed status
stable/6.6: [027679d613ea73b8a00831369ec34eea804ce1bd]

CVE-2026-93202: i3c: master: Fix recursive locking during device registration

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [0200dc55e68cc0177b6e60919de415cc96fdd4e1]
stable/6.6: [6640f778aa3d430e67171f8d17fe4a35bb44b578]

CVE-2026-93205: iommu/arm-smmu-v3: Manage teardown with devm

stable/6.6 was fixed.

Fixed status
stable/6.6: [64b1a9384db9cabf1bde378a2d5c1923fd67ea0d]

CVE-2026-93216: mm/page_owner: use memcg_data snapshot to avoid TOCTOU
in print_page_owner_memcg()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [a4c940ab3f794f221a338c9431ad1ce0d73a2bea]
stable/6.6: [e7c1923c5f30a6953f0540e3171d882ec17b05d3]

CVE-2026-93228: svcrdma: Reject Write/Reply chunks with segcount 0

stable/6.6 was fixed.

Fixed status
stable/6.6: [28c5a3a572f6cf81ac304459cfd515480995d62a]

CVE-2026-93230: mm/hugetlb: initialize gigantic bootmem hugepage
struct pages earlier

stable/6.12 was fixed.

Fixed status
stable/6.12: [326de479ab5942fb4a4aa4f20c716045434fcd6b]

CVE-2026-93231: lockd: fix swapped arguments in nlmsvc_match_ip()

stable/6.6 was fixed.

Fixed status
stable/6.6: [4fe2db296c9cd897dd1fe06cc0ae9cbc13beefc5]

CVE-2026-93240: memcg: make the v1 soft limit knob inert

stable/6.6 was fixed.

Fixed status
stable/6.6: [bf75f14d755f9cfbb246e6cc011b53cdd5142de3]

CVE-2026-93244: drm/sysfb: simpledrm: Improve stride validation

stable/6.6 was fixed.

Fixed status
stable/6.6: [110dd054fd4af97fc3f47d7df9a016b07122cc04]

CVE-2026-93275: perf/x86/intel/pt: Fix stop/start with no update

stable/6.6 was fixed.

Fixed status
stable/6.6: [190f3bdfaef8dc6660c474499bf132a3f35e7504]

CVE-2026-93285: f2fs: embed f2fs_gc_kthread in f2fs_sb_info

stable/6.6 was fixed.

Fixed status
stable/6.6: [cc004a1107e2c44cbdd2f1b1c2c85d32adc8f731]

CVE-2026-93793: wifi: iwlwifi: mvm: validate TX_CMD response layout

stable/6.6 was fixed.

Fixed status
stable/6.6: [5e871c03506c529d5fe372d099c1ad1465c7bc38]

CVE-2026-93796: wifi: iwlwifi: pcie: null RX pointers after free

stable/6.6 was fixed.

Fixed status
stable/6.6: [c422d5d53f135ea987f745773953a91f9fe30c3f]

CVE-2026-93801: smb/client: zero-initialize stack-allocated cifs_open_info_data

stable/6.6 was fixed.

Fixed status
stable/6.6: [2c5db82778f560121efda9e052e2f19c2d807c1b]

CVE-2026-93804: wifi: mac80211: ibss: wait for in-flight TX on disconnect

stable/6.6 was fixed.

Fixed status
stable/6.6: [8e4a07ed82bae5d13525770880dc6dfd27f9bccd]

CVE-2026-93817: perf: Fix addr_filter_ranges lifetime

stable/6.6 was fixed.

Fixed status
stable/6.6: [1d8e1e99b063de4179cc8af14d08115d74a37abf]

CVE-2026-93828: exfat: fix handling of damaged volume in
exfat_create_upcase_table()

stable/6.6 was fixed.

Fixed status
stable/6.6: [29723256fccf46e55c2a44bd6b8345bef7ba079b]

CVE-2026-97412: pds_core: quiesce DMA before freeing resources

stable/6.6 was fixed.

Fixed status
stable/6.6: [84fc3f30b87e06a11d1807cd385603522610ed40]

CVE-2026-97422: drm/amdkfd: fix SMI event cross-process information leak

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [470319a893f616ef661a63e825a8e1b9b6eddb91]
stable/6.6: [6fc7ab7fcd7eefb2f371a1d43cf7a860a08f922a]

CVE-2026-97424: drm/amdgpu/ras: add ras_suspend callback and use it
for cp_ecc_error_irq

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [5b761927dbb170df4716d9c0ef85e178a1856e64]
stable/6.6: [c1f2f34d681a0b354e1218b83245d1f2d2139a8d]

CVE-2026-97428: drm/amdgpu: harden FRU PIA parsing with bounded helpers

stable/6.6 was fixed.

Fixed status
stable/6.6: [567d7c3f93f8d6bdc946a557a160ee1c42cfae91]

CVE-2026-97432: wifi: iwlwifi: mvm: fix P2P-Device binding handling

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [8575514a979490c9d4517fcf19b4e19119c27702]
stable/6.6: [50bf37362362c8f03ab1aeab866b7fb08b262204]

CVE-2026-97477: RDMA/counter: Fix num_counters leak on bind_qp failure
in alloc_and_bind()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [1bcdeddddffadff9993657f6b0e5535d66ebd10f]
stable/6.6: [7c9fee40fc8d8d928f44e99bc6e6adf93f9f2c2a]

CVE-2026-97478: virt: acrn: Fix irqfd use-after-free during eventfd shutdown

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [0e1152f689847b9db2f05454775d34610c1424c2]
stable/6.6: [6e9e007ee1dfb54bc2d070550308077ec28dbaec]

CVE-2026-97479: driver core: Avoid warning when removing a device
while its supplier is unbinding

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [da22e4bce2a8cbed32dcda407b7d06cb5feec8e3]
stable/6.6: [d5eb39d6178ca88db706c7b82dcd19a77f30aa9e]

CVE-2026-97480: tty: serial: 8250: protect against NULL uart->port.dev
in register

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [9c78f89cf2fbae18b14c78bf172ca15d832aff15]
stable/6.6: [68059b6e9f7292714286e2b0f5185ed2a43fccc5]

CVE-2026-97492: wifi: mac80211: don't call
ieee80211_handle_reconfig_failure when not needed

stable/6.6 was fixed.

Fixed status
stable/6.6: [d2ea99884793c0a8d940073c3dddbb887590718f]

CVE-2026-97493: drm/amdgpu: Bound GPIO I2C table entry count from VBIOS

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [6db45123306c7167c6867ca3d24924bd7960d947]
stable/6.6: [0786b38af822fcd153d565cc85be7dbd9fed4d25]

CVE-2026-97494: drm/amdgpu: validate and share PSP fw_pri_buf copies
via psp_copy_fw

stable/6.6 was fixed.

Fixed status
stable/6.6: [8ddda06ae356fda0418b7017e658d976dad6214e]

CVE-2026-97501: pinctrl: mediatek: paris: bypass pinctrl GPIO layer in
set GPIO direction

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [3c4897861759fd8bd81dc2ada92121ac76332592]
stable/6.6: [482ba972f9638f467df2d498b46384a1d1f80529]

CVE-2026-97503: genirq/proc: Size interrupt directory names for
10-digit interrupt numbers

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [488bcd7fd3e9a2ad647b71b505a269fdb28753c4]
stable/6.6: [a8adf64fe7fd5d7c476769a043ee56eda7b775ce]

CVE-2026-97505: PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()

stable/6.6 was fixed.

Fixed status
stable/6.6: [d02dd7ce8e52b66b7d3b6eca2a7d81e7f5b10a62]

CVE-2026-97513: media: chips-media: wave5: Release m2m_ctx after
Instance Removed from List

stable/6.12 was fixed.

Fixed status
stable/6.12: [0e6bdd437a3c7a5d8846d7f58fe9645a60ec0933]

CVE-2026-97515: i3c: master: svc: Prevent IRQ storm from false
SLVSTART on NPCM845

stable/6.12 was fixed.

Fixed status
stable/6.12: [335f72b1f9bbcf0f4cc5a505443b15f1af563b4f]

CVE-2026-97518: wifi: cfg80211: reject duplicate wiphy cipher suite entries

stable/6.6 was fixed.

Fixed status
stable/6.6: [d12e92e72db914e1ea777c6f246f6be75985438e]

CVE-2026-97527: scsi: qla2xxx: Serialize NVMe unsol ctx list with a
per-fcport lock

stable/6.6 was fixed.

Fixed status
stable/6.6: [6c71726cdfda93ae169a75c7b1697eb870303125]

CVE-2026-97528: scsi: qla2xxx: Unlink NVMe unsol ctx before freeing on
LS reject error

stable/6.6 was fixed.

Fixed status
stable/6.6: [925a9129a514b7c3bc0a8af01e51868adbb9a83e]

CVE-2026-97529: scsi: qla2xxx: Validate BSG request_len before reading
vendor_cmd[]

stable/6.6 was fixed.

Fixed status
stable/6.6: [5f33efe04658968b6b3f432f904d5f1f74c12286]

CVE-2026-97530: scsi: qla2xxx: Fix soft lockup polling continuation
IOCB signature

stable/6.6 was fixed.

Fixed status
stable/6.6: [428e244dd4066abd40ca1ec525b7aab9a9db8296]

CVE-2026-97531: scsi: qla2xxx: Skip vport under deletion in report ID
acquisition

stable/6.6 was fixed.

Fixed status
stable/6.6: [40dcd4a71a52414b47fbba2f956387f1077c6c15]

CVE-2026-97532: scsi: qla2xxx: Null out freed pointers in
qla2x00_mem_alloc() error path

stable/6.6 was fixed.

Fixed status
stable/6.6: [5e0d6ffabbbd86b3fb9168b9dbb62190ecb20d84]

CVE-2026-97534: f2fs: accurately adjust free_sections during free_segment_range

stable/6.6 was fixed.

Fixed status
stable/6.6: [64a7ed42e9766886dd7300597d90366dfb7a1e53]

CVE-2026-97535: scsi: qla2xxx: Bound VP index against VP_CTRL IOCB bitmap size

stable/6.6 was fixed.

Fixed status
stable/6.6: [674d783f2e80d0d7c1c86bf36dc0a09033e704de]

CVE-2026-97536: scsi: qla2xxx: Fix use-after-free of qpair work on
queue teardown

stable/6.6 was fixed.

Fixed status
stable/6.6: [9bd063c082ef0475dfc28c46f607aa3e90fe13d7]

CVE-2026-97537: scsi: qla2xxx: Fix queue teardown NULL dma_free and
bitmap locking

stable/6.6 was fixed.

Fixed status
stable/6.6: [2e6f60adf609c77e828f64e0cd371920bef91c12]

CVE-2026-97538: hwmon: (asus_rog_ryujin) Validate HID report lengths

stable/6.12 was fixed.

Fixed status
stable/6.12: [995f22b2881835b518b3f99240d00781c9df0235]

CVE-2026-97559: smb: client: fail DACL rewrite when the new DACL exceeds 64K

stable/6.6 was fixed.

Fixed status
stable/6.6: [284877c6189fda1ac3d81771dd8482660a0c7dc1]

CVE-2026-97566: mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0

stable/6.6 was fixed.

Fixed status
stable/6.6: [189d60057e5f3d6a62e3d71a3cc428c9150bc14f]

CVE-2026-97587: perf: RISC-V: store available counter mask as bitmap

stable/6.6 was fixed.

Fixed status
stable/6.6: [5a1b6379eed5b13eac0228b605b0bed988e547e9]

CVE-2026-97594: landlock: Fix use-after-free of the source's parent directory

stable/6.6 was fixed.

Fixed status
stable/6.6: [48fc1c74052c956c59d5b16b5e18e0dd36b76aa2]

CVE-2026-97597: ipv6: flowlabel: cap duplicate leases per socket

stable/6.6 was fixed.

Fixed status
stable/6.6: [0159f716d8adbe85951cdf008d0afe27d874eaa6]

CVE-2026-97600: ieee802154: cc2520: fix FIFOP work use-after-free

stable/6.6 was fixed.

Fixed status
stable/6.6: [4a1ba62a486a4c43af91d01661a95e82dc4aaefa]

CVE-2026-97605: erofs: preserve LZMA decoders on resize failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [db0c3465b54a16debc089b2b3bda251d26c953d0]

CVE-2026-97609: netfilter: cttimeout: prevent UAF during module unload

stable/6.6 was fixed.

Fixed status
stable/6.6: [f664e06699829a31e95675a6864655a6c5f9904f]

CVE-2026-97615: net: bridge: use option bits for CFM/MRP frame handlers

stable/6.6 was fixed.

Fixed status
stable/6.6: [260f99b355a44f6ce67971ebc9223b22c8f93957]

CVE-2026-97616: net/sched: act_api: release all action references on
NEWACTION failure

stable/6.6 was fixed.

Fixed status
stable/6.6: [1b5730a1c7def8993b3feba764008d1ff5c9dcea]

CVE-2026-97619: io_uring/rw: end write accounting from ->ki_complete

stable/6.6 was fixed.

Fixed status
stable/6.6: [ed1cead97afb9c398bd7ab344a3c1ee34ab73af9]

CVE-2026-97901: genetlink: pin family module during policy dump

stable/6.6 was fixed.

Fixed status
stable/6.6: [1a345d95e59a99e25404138b5a1ec2edcb03269f]

CVE-2026-97906: bootconfig: Fix integer overflow in initrd size check

stable/6.6 was fixed.

Fixed status
stable/6.6: [97be05f33f79342ea65d9b99c9ad07a93b8eef5a]

CVE-2026-97908: Bluetooth: btqcomsmd: destroy RPMsg endpoints before
freeing hci_dev

stable/6.6 was fixed.

Fixed status
stable/6.6: [aaa7f676418e1eb2c4ef0d4e4b07812b25e7b404]

CVE-2026-97915: accel/ivpu: Limit firmware log name prints to field size

stable/6.6 was fixed.

Fixed status
stable/6.6: [3d9365093f16b069908e610d17da172bf006bbde]

CVE-2026-97916: accel/ivpu: Validate firmware log buffer metadata

stable/6.6 was fixed.

Fixed status
stable/6.6: [07d4190d75021c38b7994045179aa29131634d4f]

CVE-2026-97917: accel/ivpu: Validate full buffer range in ivpu_to_cpu_addr

stable/6.6 was fixed.

Fixed status
stable/6.6: [962e565f45dbea77d12a7ed5ef34df8f0c603e28]

CVE-2026-97918: tracing: Undo the registration when enabling the
histogram trigger fails

stable/6.6 was fixed.

Fixed status
stable/6.6: [880712b6f48103ba3a04b154ff076d45fe86dcec]

CVE-2026-97919: tracing: Take the reference before publishing the
named histogram trigger

stable/6.6 was fixed.

Fixed status
stable/6.6: [e5c5dad169fb569161d3eed6c3f6a59e65db1830]

CVE-2026-97929: ALSA: usbusx2y: validate URB actual_length in interrupt callback

stable/6.6 was fixed.

Fixed status
stable/6.6: [c3576cb77b527f223cf2b9fc2b2e9af5e7adee25]

CVE-2026-97934: tracing: Fix memory corruption from a "STACKTRACE" histogram key

stable/6.6 was fixed.

Fixed status
stable/6.6: [c94985e4fd77eb8634f44fb42e551563c68c55b3]

CVE-2026-97935: tracing: Set the trace clock before registering the
histogram trigger

stable/6.6 was fixed.

Fixed status
stable/6.6: [578d39ab420b18b76a12fc8d0573ec041a84da28]

CVE-2026-97938: reboot: fix cad_pid use-after-free race

stable/6.6 was fixed.

Fixed status
stable/6.6: [0c1a966bc047af2801a70b8eb13f9df5d7ab925f]

CVE-2026-97939: ipmr: account multicast table and route memory

stable/6.6 was fixed.

Fixed status
stable/6.6: [21e0749e8ef272ac7e3eefe0fa488a5983f4b038]

CVE-2026-97949: configfs: unhash the dentry before dropping the item in rmdir

stable/6.6 was fixed.

Fixed status
stable/6.6: [b315d865660766d45ecdbf7433a4e3d36a554b3b]

CVE-2026-97950: configfs: pin the symlink target's dirent instead of
chasing ->ci_dentry

stable/6.6 was fixed.

Fixed status
stable/6.6: [a44744454eafbc158e8c8e3ef8d207076410b195]

CVE-2026-97953: net: stmmac: fix TX descriptor availability check for
TSO traffic

stable/6.6 was fixed.

Fixed status
stable/6.6: [09c30547da2c45bb79f7d3adffc860af332c2d42]

CVE-2026-97960: perf/x86/intel: Prevent drain_pebs() reentry

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [999e482fdf89400cc1ae937680fc05096b4c915b]
stable/6.6: [9882068ed242fcd4743f53027e8c790e88dcafff]

CVE-2026-97961: perf/core: Allow list_del during perf_event_overflow()

stable/6.6 was fixed.

Fixed status
stable/6.6: [fa360a018369f3eb4fe4f4792238adfc1f6fd5dc]

CVE-2026-97962: net/mlx5e: Move representor vnic reporter to eswitch
devlink port

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [fb52d58f7d6abc2f956d9c1ac472c709f7bb33c2]
stable/6.6: [d552beb9d278aeb180d26c3889b6bd21444ad11e]

CVE-2026-97965: vxlan: initialize _md in vxlan_xmit_one()

stable/6.6 was fixed.

Fixed status
stable/6.6: [fb78beb64e0e79557e4cd7cd17fea744bb6f01d9]

CVE-2026-97975: Bluetooth: hci_sysfs: Fix NULL pointer dereference in
device_del()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [66cc55b69928b742d24b4c5b66d195ae96900e48]
stable/6.6: [55b76500546e5f2e7fdd7ae7283530b620de6e61]

CVE-2026-97978: eth: ice: don't dereference pointers from TP_printk()

stable/6.6 was fixed.

Fixed status
stable/6.6: [385aa7dbc6af11d90a5dd1261dbe75950eb7ca93]

CVE-2026-97985: af_unix: Update last skb marker in manage_oob().

stable/6.6 was fixed.

Fixed status
stable/6.6: [bd91dc313afe21e9d6b31ca6a47606a33ca5e35c]

CVE-2026-97992: vhost-vdpa: protect config_ctx from being freed under
the config callback

stable/6.6 was fixed.

Fixed status
stable/6.6: [914c7cc2e3d10dddd3c5529cbe56557c9e01702a]

CVE-2026-98003: iommu/amd: Do not reallocate GA log buffers on resume

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [ff85cdc2889e1c885eed218ee5bc0b59e0235b3f]
stable/6.6: [8b95269d7a43b737c2c0e2fa77bf00cc8a3a4434]

CVE-2026-98021: net: reject oversized tx_queue_len at netlink parse time

stable/6.6 was fixed.

Fixed status
stable/6.6: [26ee5f99ffe7ab98e635071290eff14192e9e34a]

CVE-2026-98041: bpf: Don't predict JMP32 pointer vs zero comparisons

stable/6.6 was fixed.

Fixed status
stable/6.6: [6e1544986536734166176c3add504add23bcbd15]

CVE-2026-98044: bpf: Reject legacy packet loads from callbacks

stable/6.12 was fixed.

Fixed status
stable/6.12: [cebda2a2bb4183550eae9dcf888c16407b4fffda]

CVE-2026-98047: bpf: Check ancestor frames for rbtree callbacks

stable/6.12 was fixed.

Fixed status
stable/6.12: [252e9b476af723edd299a5c71c389ec018e46656]

CVE-2026-98053: ASoC: Intel: avs: Refactor and fix init_config access

stable/6.12 was fixed.

Fixed status
stable/6.12: [70ffcaf86a053be99daaf3b103beac0ad7136ca3]

CVE-2026-98056: nvme: remove stale namespaces by NSID range during scan

stable/6.6 was fixed.

Fixed status
stable/6.6: [e6a94b2c4c80a38002346ce915a9b9a3d478a3e6]

CVE-2026-98062: bpf: Mark signal tracepoint siginfo arguments as scalar

stable/6.12 was fixed.

Fixed status
stable/6.12: [05757377fa0447163d07c43a119f81abe1eef8dc]

CVE-2026-98067: erofs: disable LZ4 rolling decompression for now

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [d923e53472b468a50a6cf41341531d5170c68371]
stable/6.6: [dcc5e6c9e4d06fe73fc61e730ee3e51dd115a4d8]

CVE-2026-98073: net: Remove conflicting altnames for dying netns in
__dev_change_net_namespace().

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [119ac1716705af17fb74b3e33058a938a87eecd4]
stable/6.6: [54772bf503dd0e81e8b8db537fee6946de81e717]

CVE-2026-98079: btrfs: zstd: fix lost wakeup when waiting for a workspace

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [844603cf842ee67640d33f350e3fa60f3de7fad3]
stable/6.6: [14d982762945d9945c60bbd48b77df194dd8e28d]

CVE-2026-98081: btrfs: zoned: finish active block group cleanup if
call_zone_finish() fails

stable/6.6 was fixed.

Fixed status
stable/6.6: [433d52b196a689b18dcfadc7cf6c784f0e5cc7c9]

CVE-2026-98097: tipc: Dont send random pad bytes in RESET/ACTIVATE messages

stable/6.6 was fixed.

Fixed status
stable/6.6: [3dbb628cfc592a4148d8136dcda1f706cdcad4f3]

CVE-2026-98103: igmp: convert struct ip_sf_list to RCU

stable/6.6 was fixed.

Fixed status
stable/6.6: [01131daffc4b64f1652e23dc3e6e2f601eda781d]

CVE-2026-98107: Bluetooth: L2CAP: fix out-of-bounds write in l2cap_ecred_connect

stable/6.6 was fixed.

Fixed status
stable/6.6: [fabc5e04f123225daf980d03f2c5a05e7f0f0a7f]

CVE-2026-98114: ksmbd: propagate DACL parsing errors

stable/6.6 was fixed.

Fixed status
stable/6.6: [99ae165acf633b13df34105815110fec332a2cdc]

CVE-2026-98124: smb/client: invalidate fscache for fallocate range operations

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [dd8b1e808f5c19479e6ed47e2f88a1fd46f8b0e5]
stable/6.6: [cc7202a51b8777a757bda9dcfbf339f828c6a130]

CVE-2026-98125: smb/client: fix stale page cache in insert/collapse range

stable/6.6 was fixed.

Fixed status
stable/6.6: [52dd721b3de57e41261e08485b2bc62b22b80ebe]

CVE-2026-98126: smb/client: validate new EOF for zero range

stable/6.6 was fixed.

Fixed status
stable/6.6: [5fbd8848f2e25c8163896ec52863df2305a3bb63]

CVE-2026-98127: smb/client: validate new EOF for insert range

stable/6.6 was fixed.

Fixed status
stable/6.6: [b7f2e33d9f5db7b8e6e5e0a5a93d0c5e31870356]

CVE-2026-98148: drm/gud: validate GUD_ROTATION_0 is present in
supported rotations

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [962cdf2eedb2708eb99c25ffb56c6d6981d41ed6]
stable/6.6: [ce7da178f1af4e9cbac4d0440c4002785546bfb5]

CVE-2026-98156: drm/virtio: use the DMA API for resource backing on Xen

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [3f130cc6826fabf50e01fe8e4ff3ed1fcae50d36]
stable/6.6: [32e999ccf5f6453b3b4df8264ff1b03c6720292f]

CVE-2026-98161: nvdimm: pmem: keep PREFLUSH before data writes

stable/6.6 was fixed.

Fixed status
stable/6.6: [22d1f4dcdc9c6d0295c6db0c8933126098b14e05]

CVE-2026-98168: smb: client: fix reparse buffer bounds in
cifs_query_reparse_point()

stable/6.6 was fixed.

Fixed status
stable/6.6: [aa00eead258e4fe8158a3a3e2d65facf06274abd]

CVE-2026-98170: smb: client: fix OOB struct field reads in
move_smb2_ea_to_cifs()

stable/6.6 was fixed.

Fixed status
stable/6.6: [61812323c037a94e2e7f0db7ee740c34b126bffe]

CVE-2026-98173: smb: client: fix use-after-free of iface in
cifs_try_adding_channels()

stable/6.6 was fixed.

Fixed status
stable/6.6: [ee0d8f83d68f6e6509f092c997ccab3c8c801538]

CVE-2026-98192: wifi: wcn36xx: Fix potential use-after-free in TX ack
timer teardown

stable/6.6 was fixed.

Fixed status
stable/6.6: [15e59e377facc87ce82228279d88efaa89fdbca5]

CVE-2026-98193: wifi: libipw: reject TKIP frames without a full MIC

stable/6.6 was fixed.

Fixed status
stable/6.6: [f448b267968d0ee985e5927c868c8f858169ab34]

CVE-2026-98198: hwmon: (pwm-fan) Stop RPM timer before freeing tach data

stable/6.6 was fixed.

Fixed status
stable/6.6: [d073d306e587c1f35aaf9c07c42e54a3d5895d8f]

CVE-2026-98245: btrfs: take commit root semaphore when iterating in
mark_block_group_to_copy()

stable/6.6 was fixed.

Fixed status
stable/6.6: [93a025166495c63ba5b8ac721c7040d5312e8335]

CVE-2026-98265: ALSA: usb-audio: Clamp implicit feedback packet count
to URB capacity

stable/6.6 was fixed.

Fixed status
stable/6.6: [8b637ab10e40e01b452f4aff66dad335a9b89a16]

CVE-2026-98297: Bluetooth: hci_core: Fix queuing tx_work after
workqueue is drained

stable/6.6 was fixed.

Fixed status
stable/6.6: [8010212197d4a3ee714f78ed77048d0b712ff925]

CVE-2026-98353: RDMA/erdma: Use IRQ-safe XArray helpers for QP and CQ tables

stable/6.18 was fixed.

Fixed status
stable/6.18: [e32aa1d85126e6d5ef6efd594ced3f75178886ce]

CVE-2026-98373: mm/hugetlb: preserve mremap address delta when
skipping page tables

stable/6.6 was fixed.

Fixed status
stable/6.6: [cf73ef2a761df9329af116c905a7a94b317921e4]

CVE-2026-98377: vlan: require the MAC header to be present in
__vlan_insert_inner_tag()

stable/6.6 was fixed.

Fixed status
stable/6.6: [3d531429524df2c7116579306640283fea68bcf0]

CVE-2026-98386: scsi: qla2xxx: Use memset_io() to clear QLAFX00
request ring slot

stable/6.6 was fixed.

Fixed status
stable/6.6: [2df8c8630904794100189fa3d70598642e1877ce]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com
