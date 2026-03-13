Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BFF106FD91
	for <webhook@archiver.kernel.org>; Fri, 13 Mar 2026 06:51:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10202.1773384688657578701
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Mar 2026 23:51:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=tOMOHjYV;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1773384675;x=1774594275;bh=
	EpqQMyZC2Ch6nq/mNjL6AP2tsLH4vpXPvU6Nus9sa9A=;b=tOMOHjYVLBcy9TOwRQtwrMPcrESiVl
	RsT14fowp17eSTyr/NnX8tqR59B5dw151gtq6py/joH772uQwmzKx8P7tNtCrwc5bMNjIXFxknQh+
	omhDGpPFqAu7iRnhQbi3rqziY/+9aDp4h1fEkxrdKVWw84g6SThyDmWnF35PkPxg2ru9auXvrjZBs
	o/m28JhpFibk5/x2k0fZthNBPCK9eet+klUNN93420NHlq/mg+9lx8kiAe8/YvWO8FpNb4RMMTImi
	K3EuZxs4LAlUCscnBd/rzXxTuhvda2QSKIvBnZv4NHoNZ4avoPeqVzPsJ6qIyzzEX9T7R+PfmZj9W
	lEGg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 62D6pEMv794188; Fri, 13 Mar 2026 15:51:14 +0900
X-Iguazu-Qid: 2yAarcJNbAB1xTRPke
X-Iguazu-QSIG: v=2; s=0; t=1773384674; q=2yAarcJNbAB1xTRPke; m=PxPbbzv6qI47s35vHs8YZRa2EsjV2poQGLxJofxzaKE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fXFWP3QHDz1xnZ; Fri, 13 Mar 2026 15:51:13 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cn/za+27lu22wz7raYZ6Y4UXMgzUM6RGYbahhhqX2mpkq5ntH8pfImn5b9B4JDS3WuuwcnLebcgvvG1cXtL0bIOqkCIaN9AeZKOb7tUsZ2GJHnLKmm3WkV0GuDdeqcz7YwQni28uy/21yU932f+V+JWEr2iwx+1ifRZfZf2bS0VSrvO0HhOmJnUcH3EyaokC342a3dz5kS9ENaP5cQM1LtSPwWWWVm71oQtWA/LKCm5aN22VmKHqGTLQeC18LyzaIbe980h1LrxYKMXPK5yCkD5AIoDtmrv18EJSa871DbbGwKUu82vzPXsT4X7jf5lNySWwxFNw0aEvG8fAhxy/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GR/Hy6m11Z3arB72cQk2IN/+FpjnPlRXU7CP5rcgxHk=;
 b=o0x3UMfvpCJL4XqC5+nKU97VuwJhwWFZ3sRerdThOb4QInIjT1MscZ/AccSHGIMAmSK1hJpPI6f0L631pMkmbVFIdm7daLPyUq8KaGUHDQkuUMsp93d5xtkx8EqfCEsIiuL7g75Hex483oCjy501O7Se6MoYzVlKvMMrv6lQEf7bla151m4/SGYRN3ddkBnBjekBoW+074agUEB5hKEvqQj5XTpYF8xcZ9gXitH60SBQWCH5xYLV8hP0fftqEyDDAmqrJGAmyQXC4gwX0RZjoL05tfp+SxSAlUigY48gOGjbAoDiYI3eOgD/kT3sAB5+qQnkGJTThOsxPSDSvE40dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@nabladev.com>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v5.10.251-cip70
Thread-Topic: [ANNOUNCE] Release v5.10.251-cip70
Thread-Index: AdyysicQDBmKBhleQPmTXOq74MpVEg==
Date: Fri, 13 Mar 2026 06:51:01 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818C5A866AAFB66A71EA103CD45A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB9752:EE_
x-ms-office365-filtering-correlation-id: 4796cac4-d95c-4925-5ac5-08de80cce3bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|7142099003|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info: 
 hmtKNIdeQj2rAza0WusfMvnQRQlYSoipNoIo+jxFa+gnhaFsYA0Dd+IJElz4dn9ucjRkyeT22PfcygTFUNOukTZHcMuNpEBkmg6SxSGggjGMB54Py30/vWI9t6kMx57X8NAhkN3pUVn/fo3+lml0YtTKXukoRIhnb9LqgeQzij21ZidvuPmTkiQ94nkHndqtStWq1awZSmjeBgO1qg8inWMpbBoZo7YjopVErXkdhNNijcLQnXFxMzpRAztg5EkzCjDznAoBRZpk3eAb7Dm0glSqxCojIGaS+sJNW5xkH1NTPOQDLkw18UVvCWYt4niKkpKoka/Oq4Jhuve65y6xGLHSz6cw2wRxIiD2bSb272ukNB+Fv9jkCAgsoCkWfQCUhNI09ErnFgfk2Yc5IOMLzXnTSf2qYVc2noZDF835xsP6YhPu2zKeod+DAAy8iCsg94e2b0v7X4kVfUNKczFtBn7HkPxQcgxi6hCyms0S7mpphhOvUGEFjigq2MWazW8w+vh56e0IsMlFo46tf86e9WIQlsUQ6OitgKGa6l/p0/sFM9g3MEEZ7SG8MxBXBRDQwFAcgUDwwcC0nY7Lyha1X861W6y+ZgyMPfHBy03579lf/R+PZiuMjsDTSo0VYUixfVAWjcTtto9gMVttcCR4Yol8oQF+CB/CkwsbXI8rtBEayg4xTcLjP4BEGbQMAMDibQanOAyv9sOCwuLKO3JOZAxM8sRuL0g0ANtc80TKf1UoPOJxf3z8F6HXbzg1n6jrjTOAoIQ2QoLw3uttajmodS4kYZQxG80pH5R3PvP5VVo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7142099003)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TkpIQ21xdjFhQ04xNGM4d1JFOVcxZzdka282S3BYbmczNytaWU1wNlpP?=
 =?iso-2022-jp?B?Q3JQUDZFS04wY3BLUnR0N00zMVRyYTNValI5Z3JrdFdXWE1DbGJMV3Vl?=
 =?iso-2022-jp?B?cTZNZ2ovZTFtZ0xTWWZqSVV6Q3N3YmxPeXhRd3RUZHlUT09HSlhhTnZt?=
 =?iso-2022-jp?B?by9HV1hPVTV6U2xHSllRT09ZNTc3Z3hVQkl5OHlYTnBUdmIrajNIQk54?=
 =?iso-2022-jp?B?Ri82bWdHZWhYUVJDS29CSTVvdWFhWFRwZHlqeXJiSWF2aHljeXFiV1VP?=
 =?iso-2022-jp?B?bVM4VjAzclBURE1nREorUVRKdzBMTTg3VUtoVVV5NlFueFJlU2Uwa293?=
 =?iso-2022-jp?B?cWUwYlA4dGRDM3d4aUNqaG9RcVNMbmhNbkVBYVVDUDRuSkFET3VJVkow?=
 =?iso-2022-jp?B?c0RYb0I1TGtzSW5oSCszZlFDZFljNmJyd0J3WUxPb0dMT29BdkNrZW83?=
 =?iso-2022-jp?B?QmMzVFM4SGRxMUZMYXpqYnhNUWsvQzdhYnJvak9WSkxnZnlsRklCUm03?=
 =?iso-2022-jp?B?RVRSczZkQ3M3K0tEOVcyZUQ3VkdxNXFrV2dhemZld0xZckFNaURFMUxY?=
 =?iso-2022-jp?B?THkrY08zU3VEZjBtUEtsa2dlQ0RGV1J1ZHYwQTVCUFZ4Uk9NSlA4Q0ZK?=
 =?iso-2022-jp?B?NnlDdTBOSlk2b0pKNG5PaFBFTkFNUi81OTd6cWxqWHV5V2oraVZrbWZs?=
 =?iso-2022-jp?B?K1B6V2NKMDYybzlvU1dDMGpZWjF4cFZhNTR1RUdFNWNzelI1OC9pdjc1?=
 =?iso-2022-jp?B?MkdQUkMvNjJ0WUlZeHRTUmJRbXlsS3lXQ0lpQVNPR2FZTGMzZ2o2MXR0?=
 =?iso-2022-jp?B?WkdaV09OMU5vRkxiTnRBQXJYUEVZWktBNUZJazVSTWUxY0s0dHcwbHRh?=
 =?iso-2022-jp?B?bUF3SVdEYnBRalhTTHJUM2hLSkpHelBlUTVuTGM1MjVLYUM0Vmw4OTMr?=
 =?iso-2022-jp?B?eURWc205MHVrVFd1RUd4VlBCQWdvTkRnN2krWitJWTFycjlpKzlTM0pC?=
 =?iso-2022-jp?B?SUxDaGNIcnNqZkF0K1hWS2FtbThraWk3N3pxMG5qazdMVzhFRWluWlIr?=
 =?iso-2022-jp?B?M3VqbVozY0lNR2VaZy9FcjZ4ekt4WGljR2owVkFtdi9BbFBUdDFWVEdn?=
 =?iso-2022-jp?B?c0YxNHlkUXhhb1F4S0RVQ2JFN2tWdjQrS0lCTHYwc08xeExBaG9ESUdJ?=
 =?iso-2022-jp?B?NjBJakVuUjdLdlYvSDYyWDhpS1NlQ3ZzQWV4dUpScmcvQ3liWmcyMlpT?=
 =?iso-2022-jp?B?bEZHcFp2SnBtVjdIdUhNL0ZWeFkzOURmN2ZWWTZoUlBwVWRzNndOaXFr?=
 =?iso-2022-jp?B?Z09JcERKaDNTKzlFZkJKVnZkMkwyVmUwU3ZMb0dNcGFleU51M3gwZzQz?=
 =?iso-2022-jp?B?dlBBQUxKcGlOR1NpeDY2LzZtL0NiSTJMY2lmanBycjU1YWRsK0MzaG8z?=
 =?iso-2022-jp?B?bVNlcm1CMVFUcTFkdWZXc0I5N2I0MlJLbyt6VmQwdzFpMVNISjh5N1Ba?=
 =?iso-2022-jp?B?SzYyUytucGxLWTdBVnIrWE41bUlJY0NWLzIwR0tVbEhwVFRnZ1lVa3kx?=
 =?iso-2022-jp?B?bjBJRUxEbG5uR3AyTmNDb01STmprbS9ZNEpkVFFZdWtZNjBMMlk1dGdN?=
 =?iso-2022-jp?B?ZW9ENTVEUU9jSG1xWHZUUjdtS2tzSWhtUmRXU2p6RXNxYVZKdlVwQ3pz?=
 =?iso-2022-jp?B?cWhzSWhqa05RODJxbjJxc2JOeHNPamNQaDNNQ0J4Qlhsam1MVlpMM1Bm?=
 =?iso-2022-jp?B?cnZ6NnJjR1EzekJ5VjVmWjZxcWovS3lDaHdvakJlM1pmRDVvZXhqdkFi?=
 =?iso-2022-jp?B?ZjhhT0xKR2VITlNjWSsrOE9GM0tXUXlVdENlY2xCUWk0L2hTVVVMQkV2?=
 =?iso-2022-jp?B?bkpZL0g0VS9MUmhBM2t6K2ozcHR3OVlHdjBkTktWM0FnMkpycFZNa1Nh?=
 =?iso-2022-jp?B?Q0ZnTURXT1pjdzd3VWJ5VnpuY1JvZFd3Wk1DNnhoeXNidThQWkFOOHJC?=
 =?iso-2022-jp?B?ZjBGYnp5bnlyai8vZXN3Rm5TTm4zZkxKWnRES2M0cEFhNUFxWHM3YmRL?=
 =?iso-2022-jp?B?UWkraHlYNDhDWWd3b2xUMGQvUWY5bUdld0hkUUpZZkljZ0RzRURaZnZz?=
 =?iso-2022-jp?B?a2REdUNjaGNWR0p3d2FUSWY4dmpNQzBFZXdKWnpEdWNrR2tEMUFoUG9O?=
 =?iso-2022-jp?B?YmxBMWlrbTgvQlFBeW5PUkQwTEVsMmhqaHI4a0lTbkllTml0OFEvZnd6?=
 =?iso-2022-jp?B?RTlpc1hhQmw0N3JqVVJPVDZkTUxCbU1LNHMzWHVLcFFlRU9lRTRKYVNB?=
 =?iso-2022-jp?B?SDZnNGFadVRMQ0JhQWtUSm9OMnNHYWtRUHMzTjJsdndwSlFvNEJaaW1H?=
 =?iso-2022-jp?B?KzhjbUpGdVN5TnJRQm1xU1o4Y05yRUhMTkR0ZHFzVzdqWlhVSTlaM2Iv?=
 =?iso-2022-jp?B?bnkrYy9oUWRjYmlmRkpZUjNHdTI2SW16WWtENFhCWS9oT0FVbVpIaFk4?=
 =?iso-2022-jp?B?aEJ4T2F1S1E2ajRUTUVOQUpkWUsrZ1FQOGZGcUtUU3VZMi9oTmVmQXpU?=
 =?iso-2022-jp?B?NmcwRUthST0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	ZFEIKupvbyFp77MxV84sDsgtd07KonYt8wM6nuzYQrj531XdrUc4+SeRjjZi5gkbyO23xjua6gih0NPsZ52SlQWWfrCYwHI5s9PIxZ1TQughBQaxK2AmLsAzjZ4NMkBwW6DoUBU27pP4/9LCSvd4Vfo2tRXgIH1O1zoXdFewGiuhd9YDSjWEx1dCwEEXOBQJ1p2sDrqIUw9TcjJGQz9ac0NATRdi3aYqQf3LC8zTEWct8UzxlvyRzdOMsXmsvFgZzn/qJneRkgREIblnR82x6Tnq6LO3fdsMo/HXnJ8Dxd9InibmWLDdTnFrvp+pkjj3+2b3TOQrph+7GEqdHyPZYw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4796cac4-d95c-4925-5ac5-08de80cce3bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 06:51:01.5817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5L1uZMjVQtmLzZUBiVohGbmEHd601V87zCZi/98vnwhMtTv6O1lhW7bDEO/T8mY2X6ecr5vvuyfH3FgMkyObtrY69dNJgX3UgZ71u+Kioi7MVGBpoq9JzBvseAb0Eeci
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9752
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Mar 2026 06:51:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22368

Hi all,

CIP kernel team has released Linux kernel v5.10.251-cip70.
The linux-5.10.y-cip tree has been updated base version from v5.10.249 to v=
5.10.251.
This release includes updates to the ASoC for Renesas ARM SoCs.

Information about this release is as follows:

  v5.10.251-cip70:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      99e8b9912822c35e388d236d0aadca61195f75e6
    fixed CVEs:
      CVE-2025-38201: netfilter: nft_set_pipapo: clamp maximum map bucket s=
ize to INT_MAX
      CVE-2025-71235: scsi: qla2xxx: Delay module unload while fabric scan =
in progress
      CVE-2026-23222: crypto: omap - Allocate OMAP_CRYPTO_FORCE_COPY scatte=
rlists correctly
      CVE-2025-71232: scsi: qla2xxx: Free sp in error path to fix system cr=
ash
      CVE-2022-50516: fs: dlm: fix invalid derefence of sb_lvbptr
      CVE-2025-71237: nilfs2: Fix potential block overflow that cause syste=
m hang
      CVE-2025-71236: scsi: qla2xxx: Validate sp before freeing associated =
memory
      CVE-2026-23229: crypto: virtio - Add spinlock protection with virtque=
ue notification
    added commits:
      CIP: Bump version suffix to -cip70 after merge from stable
      ASoC: renesas: rz-ssi: Add support for 32 bits sample width
      ASoC: renesas: rz-ssi: Add support for 24 bits sample width
      ASoC: renesas: rz-ssi: Move DMA configuration
      ASoC: renesas: rz-ssi: Remove trailing comma in the terminator entry
      ASoC: renesas: rz-ssi: Use dev variable in probe()
      ASoC: renesas: rz-ssi: Fix rz_ssi_priv::hw_params_cache::sample_width
      ASoC: renesas: rz-ssi: Fix channel swap issue in full duplex mode
      dmaengine: sh: rz-dmac: Fix rz_dmac_terminate_all()
      iopoll: Do not use timekeeping in read_poll_timeout_atomic()
      i2c: riic: Move suspend handling to NOIRQ phase

Best regards,
  Nobuhiro


