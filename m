Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F08C67800
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:11 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by mx.groups.io with SMTP id smtpd.web10.15324.1650499250966420406
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Apr 2022 17:00:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=xNmJCXuZ;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.47,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f47.google.com with SMTP id
 k29-20020a056830243d00b006040caa0988so2198738ots.6
        for <cip-dev@lists.cip-project.org>;
 Wed, 20 Apr 2022 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=WAYV8VhavnFI2VxM4KYdSGgQCIq0508qF8GFQBinB8s=;
        b=xNmJCXuZT3XjUDgG/XQegYo+xWF8v/WrS0CLQZuyuLgp/cGWPDdoZQ3IEZImFU6Scr
         N5gva7LJBeDnr5ob5ylip8fVZhG5UFKg+E3fMdEmz8OcwPAXHhpNGDvkKm0qz7y6mQgv
         0cGL0Qhwbl6DAJaLKG3aPVYRDTuc2PHH7BPMx/LRlOrS3XNPfHNdkwbbORuOI9gFINlg
         mNtii1Ux1KQPOOUYJM1Eid3aiySRjvCJ7SYfCilyC+2KtQHKdlLsvBUTsWdhMfZybrMQ
         0NR9qeWGGwyIiViceQ8xVyqNgP68hh+IzwN5S2bHbcnNo55JohKAz7loS4W/DdaeAUPw
         m2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WAYV8VhavnFI2VxM4KYdSGgQCIq0508qF8GFQBinB8s=;
        b=6DEnkbpLX4nYj8n4H/DDt5bQryw4GFlRnvlZx2CgNnOymyrtz4oNjzWByIKtOam4vf
         oJ7hNkvoYGRCAkcZpKeQAeFCPWjUm9+LXPVHV6JYr9ADmm9wjcwjmPtMeYIbef33Cw9P
         jT8ch8UpEhHToQE5BvBenxiTF2XYgKMcxSmehVpKfMByZuCiGg9aPYZcBZOVon/SGUJh
         885oUO+WPvqwNO0bQl+vB7IL2t+Fih5WN37hyofcN/dfNpZShzFy42g6vkWXdLm9isJp
         Okn+BGuKo9DuaucvQ/TGt76bjqhlacUpE50mtSr9KaOVCG2TQDrpLR5y3+kqmxNE8rr9
         k1rg==
X-Gm-Message-State: AOAM533lztDSroe97wK4R5e+qwLR47m0K4RLuKxT/nqOxDTcWlOcCgI+
	LP+n+pLl8ArTUt2JpdP6FomrVa5bDyv0jJKH/DFm+Sxr9OEWgg==
X-Google-Smtp-Source: 
 ABdhPJy5voI2dLtRBSi/KCpHCFrTa1S3V5la0DFwMXR5lolKtD0Ffc2gpG8f1CIYTHjBuKlmHGnneMo8GHn55m1InE4=
X-Received: by 2002:a9d:7296:0:b0:605:6e0f:22fc with SMTP id
 t22-20020a9d7296000000b006056e0f22fcmr1206808otj.127.1650499249703; Wed, 20
 Apr 2022 17:00:49 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 21 Apr 2022 09:00:13 +0900
Message-ID: 
 <CAODzB9rt1iL6Ft349DfKXFPHfKvNR+FiH+9S=6ucfO7iQEcGCg@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8147

Hi !

It's this week's CVE report.

This week reported 2 new CVEs and 11 updated CVEs.

* New CVEs

CVE-2022-1353: af_key: add __GFP_ZERO flag for compose_sadb_supported
in function pfkey_register

CVSS v3 score is not provided

An information leak bug was found in pfkey_register() in
net/key/af_key.c. A local user unprivileged user can read internal
kernel memory by this issue.
Patch can be applied to 4.4 without any error. This patch hasn't been
merged to 4.9 as of 2022/04/19.

Fixed status

mainline: [9a564bccb78a76740ea9d75a259942df8143d02c]
stable/4.14: [fcdaaeb7eb5d52941ceb2fdcec0e2170c9bf3031]
stable/4.19: [693fe8af9a2625139de07bd1ae212a7d89c37795]
stable/5.10: [8d3f4ad43054619379ccc697cfcbdb2c266800d8]
stable/5.15: [d06ee4572fd916fbb34d16dc81eb37d1dff83446]
stable/5.4: [ef388db2fe351230ff7194b37d507784bef659ec]

CVE-2022-1184: use-after-free and memory errors in ext4 when mounting
and operating on a corrupted image

CVSS v3 score is not provided

An UAF flaw was found in dx_insert_block() in fs/ext4/namei.c. It
causes a local user can crash the system.

Fixed status

Not fixed yet.

* Updated CVEs

CVE-2021-4197: cgroup: Use open-time creds and namespace for migration
perm checks

4.14, 4.19 and 5.4 were fixed this week.

Fixed status

mainline: [1756d7994ad85c2479af6ae5a9750b92324685af,
0d2b5955b36250a9428c832664f2079cbf723bec,
  e57457641613fef0d147ede8bd6a3047df588b95]
stable/4.14: [a70bcf9ed08f3628a9324f054b0e041697b26853,
f1ce7855afe6310f8cd9a472f6d52c872feb578b,
  2337c8257cd2a4f01bef92288458483955605bd1]
stable/4.19: [0bd407959f7d6671ba0617e2dbda3e89d8a0419f,
de37e01dd20e3228b010fe5fbd3e205747481b96,
  74ac12c718e7d3f7eb346ee90a4c9904a8b6b6d2]
stable/5.10: [f28364fe384feffbe7d44b095ef4571285465c47,
824a950c3f1118eb06b1877c49ed1b2eca8e236d,
  4665722d36ad13c6abc6b2ef3fe5150c0a92d870]
stable/5.15: [c6ebc35298848accb5e50c37fdb2490cf4690c92,
50273128d640e8d21a13aec5f4bbce4802f17d7d,
  43fa0b3639c5fd48c96b19d645d0c7ff2327651a]
stable/5.4: [691a0fd625e06c138f7662286a87ffba48773f34,
9bd1ced6466e71dcb08b24b59b8dd87bb2369d07,
  8a887060af61b451c46938149c426defe16add77]

CVE-2022-0854: swiotlb information leak with DMA_FROM_DEVICE

5.4 was fixed this week.

Fixed status

mainline: [ddbd89deb7d32b1fbb879f48d68fda1a8ac58e8e,
aa6f8dcbab473f3a3c7454b74caa46d36cdc5d13]
stable/5.10: [d4d975e7921079f877f828099bb8260af335508f]
stable/5.15: [7403f4118ab94be837ab9d770507537a8057bc63,
2c1f97af38be151527380796d31d3c9adb054bf9]
stable/5.16: [270475d6d2410ec66e971bf181afe1958dad565e,
62b27d925655999350d0ea775a025919fd88d27f]

CVE-2022-1011: fuse: fix pipe buffer lifetime for direct_io

4.14, 4.19 was fixed this week.

Fixed status

mainline: [0c4bcfdecb1ac0967619ee7ff44871d93c08c909]
stable/4.14: [0ab55e14cf5fd40c39109969c8b04a25870f5d1e]
stable/4.19: [99db28212be68030c1db3a525f6bbdce39b039e9]
stable/5.10: [ab5595b45f732212b3b1974041b43a257153edb7]
stable/5.15: [ca62747b38f59d4e75967ebf63c992de8852ca1b]
stable/5.16: [58a9bdff32fde29137731e574b17c42592875fd0]
stable/5.4: [a9174077febfb1608ec3361622bf5f91e2668d7f]

CVE-2022-1158: KVM: x86/mmu: do compare-and-exchange of gPTE via the
user address

5.4 was fixed.

Fixed status

mainline: [2a8859f373b0a86f0ece8ec8312607eacf12485d]
stable/5.10: [e90518d10c7dd59d5ebbe25b0f0083a7dbffa42f]
stable/5.15: [8771d9673e0bdb7148299f3c074667124bde6dff]
stable/5.16: [9a611c57530050dc359a83177c2f97678b1f961e]
stable/5.17: [5051c04d70c6e035c2c923c04fbe015a4468b08d]
stable/5.4: [1553126eccf4fad17afaeaed08db9e5944aa2d55]

CVE-2022-1198: use-after-free in drivers/net/hamradio/6pack.c

4.19 and 5.4 kernels were fixed this week.

Fixed status

mainline: [efe4186e6a1b54bf38b9e05450d43b0da1fd7739]
stable/4.14: [a2793cb58444d4411810cc555eb45b8f4a228018]
stable/4.19: [79e2f40c210a47f283bca352745068207798fbb9]
stable/4.9: [45d1a63bacf2b6ab27f9b11b5a2431e19d34d01f]
stable/5.10: [f67a1400788f550d201c71aeaf56706afe57f0da]
stable/5.15: [3eb18f8a1d02a9462a0e4903efc674ca3d0406d1]
stable/5.16: [4356343fb70c899901bce33acedf4fede797d21f]
stable/5.4: [28c8fd84bea13cbf238d7b19d392de2fcc31331c]

CVE-2022-28389: can: mcba_usb: mcba_usb_start_xmit(): fix double
dev_kfree_skb in error path

4.14, 4.19 and 5.4 were fixed.

Fixed status

mainline: [04c9b00ba83594a29813d6b1fb8fdc93a3915174]
stable/4.14: [cdced1015a63a7f100b5867ebb9a40271f891411]
stable/4.19: [a8bba9fd73775e66b4021b18f2193f769ce48a59]
stable/5.10: [0801a51d79389282c1271e623613b2e1886e071e]
stable/5.15: [37f07ad24866c6c1423b37b131c9a42414bcf8a1]
stable/5.16: [f913412848defa326a155c47d026267624472190]
stable/5.17: [42a4b0dfd365c4f77f96fd1f73a64b47ae443a38]
stable/5.4: [2dfe9422d528630e2ce0d454147230cce113f814]

CVE-2022-28390: can: ems_usb: ems_usb_start_xmit(): fix double
dev_kfree_skb() in error path

4.14, 4.19, 4.9 and 5.4 were fixed this week.

Fixed status

mainline: [c70222752228a62135cee3409dccefd494a24646]
stable/4.14: [29d967c18737ce04f372831c4542e71da1a8d5c8]
stable/4.19: [dec3ed0c76483748268bf36ec278af660b0f80ba]
stable/4.9: [e9c4ee674586ff0b098d17638af719aa56c9c272]
stable/5.10: [b417f9c50586588754b2b0453a1f99520cf7c0e8]
stable/5.15: [459b19f42fd5e031e743dfa119f44aba0b62ff97]
stable/5.16: [41f6be840f138c7d42312d7619a6b44c001d6b6e]
stable/5.17: [3f71f499395545119383f10760b8b19703d2a7dd]
stable/5.4: [e27caad38b59b5b00b9c5228d04c13111229deec]

CVE-2022-1195: kernel: A possible race condition (use-after-free) in
drivers/net/hamradio/6pack ( mkiss.c) after unregister_netdev

5.10 and 5.15 kernels were fixed this week.

Fixed status

mainline: [3e0588c291d6ce225f2b891753ca41d45ba42469,
0b9111922b1f399aba6ed1e1b8f2079c3da1aed8,
  81b1d548d00bcd028303c4f3150fa753b9b8aa71,
b2f37aead1b82a770c48b5d583f35ec22aabb61e]
stable/4.19: [896193a02a2981e60c40d4614fd095ce92135ccd,
b68f41c6320b2b7fbb54a95f07a69f3dc7e56c59]
stable/4.9: [8a1a314965a17c62084a056b4f2cb7a770854c90,
83ba6ec97c74fb1a60f7779a26b6a94b28741d8a]
stable/5.10: [450121075a6a6f1d50f97225d3396315309d61a1,
7dd52af1eb5798f590d9d9e1c56ed8f5744ee0ca,
  80a4df14643f78b14f1e8e2c7f9ca3da41b01654,
cfa98ffc42f16a432b77e438e2fefcdb942eeb04]
stable/5.15: [cb6c99aedd2c843056a598a8907a6128cb07603b,
c799c18a287e024e1c885da329aad8f719b255c3,
  9873fe0f3857c500fa21f92fe43b2a177e8de208,
03d00f7f1815ec00dab5035851b3de83afd054a8]

CVE-2022-1199: Null pointer dereference and use-after-free in ax25_release()

5.10, 5.15, and 5.4 were fixed this week.

Fixed status

mainline: [4e0f718daf97d47cf7dec122da1be970f145c809,
7ec02f5ac8a5be5a3f20611731243dc5e1d9ba10,
  71171ac8eb34ce7fe6b3267dce27c313ab3cb3ac]
stable/4.19: [3072e72814de56f3c674650a8af98233ddf78b19,
5ab8de9377edde3eaf1de9872e2f01d43157cd6c]
stable/4.9: [851901d339b2ba766ffcf754d37a6f52fa07cea2,
cad71f1094834eb69f7ceec8100d300c26b43053]
stable/5.10: [b9a229fd48bfa45edb954c75a57e3931a3da6c5f,
e2201ef32f933944ee02e59205adb566bafcdf91,
  145ea8d213e8f46667cd904ae79d17f298750f00]
stable/5.15: [4c958f0c5714812461da7785393315b35145ac8c,
da6509fba636f7f8b2e902b1e4742fdbf1bf059f,
  46ad629e58ce3a88c924ff3c5a7e9129b0df5659]
stable/5.4: [cfc8b37ef0418529e3719c2d128e59e74a3114b0,
d2be5b563ef391f684592a28440067f4fa3735f4,
  0a64aea5fe023cf1e4973676b11f49038b1f045b]

CVE-2022-1204: UAF caused by binding operation when ax25 device is detaching

5.10, 5.15, and 5.4 were fixed this week.

Fixed status

mainline: [d01ffb9eee4af165d83b08dd73ebdf9fe94a519b,
87563a043cef044fed5db7967a75741cc16ad2b1,
  feef318c855a361a1eccd880f33e88c460eb63b4,
9fd75b66b8f68498454d685dc4ba13192ae069b0,
  5352a761308397a0e6250fdc629bb3f615b94747]
stable/5.10: [5ea00fc60676c0eebfa8560ec461209d638bca9d,
5ddae8d064412ed868610127561652e90acabeea,
  57cc15f5fd550316e4104eaf84b90fbc640fd7a5,
b20a5ab0f5fb175750c6bafd4cf12daccf00c738,
  a4942c6fea879972a7fee50f7e92e2e10f3fc23e]
stable/5.15: [9af0fd5c4453a44c692be0cbb3724859b75d739b,
bc706d89199b0d8ee5e2229e18fdb9c0720f6ba8,
  b982492ec3a115e0a136856a1b2dbe32f2d21a0e,
452ae92b99062d2f6a34324eaf705a3b7eac9f8b,
  1bf8946d5826788c82971977245bcd3313678eac]
stable/5.17: [d01ffb9eee4af165d83b08dd73ebdf9fe94a519b,
87563a043cef044fed5db7967a75741cc16ad2b1,
  feef318c855a361a1eccd880f33e88c460eb63b4,
534156dd4ed768e30a43de0036f45dca7c54818f,
  01619aa347d35ac8b79751757784ec6f507a3215]
stable/5.4: [418993bbaafb0cd48f904ba68eeda052d624c821,
1db0b2c55c934a33b6fa4d4a4865f5a5be641344,
  7528d0f2210c3a1154186175516ed37aa970f2b1,
9e1e088a57c23251f1cfe9601bbd90ade2ea73b9,
  eaa7eb23fa76db45f7da1b6192518705863d0ebe]

CVE-2022-1205: Null pointer dereference and use-after-free in
net/ax25/ax25_timer.c

5.10, 5.15, and 5.4 were fixed this week.

Fixed status

mainline: [fc6d01ff9ef03b66d4a3a23b46fc3c3d8cf92009,
82e31755e55fbcea6a9dfaae5fe4860ade17cbc0]
stable/5.10: [f934fa478dd17411bc6884153dc824ff9e7505d8,
5c62d3bf14100a88d30888b925fcb61a8c11c012]
stable/5.15: [43c107021d9160f6a1610bafba6dadc0323ae548,
85f25bb9a0051198af48ac2f3afc9f16f2277114]
stable/5.17: [a45dba71849a963c427637b3330e2ccf098f42d1,
76ff66bb3b22f202c226ddbb0a811f8fb8aab2fa]
stable/5.4: [40cb8b3b19c087a4e20f6740701e53fefbe19a7b,
a83a18c4c9033fb6604c587f52a2d78857cf0ac2]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information.

Regards,


-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

