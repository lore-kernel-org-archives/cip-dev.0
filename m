Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0C6CD1288
	for <webhook@archiver.kernel.org>; Wed,  3 Apr 2024 07:30:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.5680.1712129423452208577
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Apr 2024 00:30:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 4337U0Gp2353641; Wed, 3 Apr 2024 16:30:00 +0900
X-Iguazu-Qid: 2yAaAnXleGBPweawPm
X-Iguazu-QSIG: v=2; s=0; t=1712129400; q=2yAaAnXleGBPweawPm; m=kpRv1s3QK7dcND0+tXobcUL+UBCGqeZ5jNuT7JsaZe4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 4337TvSj1082923
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 3 Apr 2024 16:29:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKu+pQamhOfXuMkJrjQqg0R42hatNKcmh1dFitfqsc2++ZxYErSUTyt1BxumI9xMsTY6yTJQq1a/P0Q5TXmwBmGsLJbv8fSx0I/4g7qJ4xcTP1ytG1B+NvnIuV1MNVWcDCVecIGg88O+98eBqcldl41hYZ6iSbPhet3aHgchzdDr2mA+ctSZ31T9hK5Ly657eUIQ2Z+gj68qwu0JOCrxUcYRsfl/iz6CRYAf27nB39cyQS3sujk6YRC/5ex9wB4DaktaHh80iY20LRMhS/mzgZziNnnVtorPIZ9e8Y2uVCSvZ/Ejh+k9wDWFdFwnN290U7dT54d1S+ATljjOQNWEuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qbOk3R07uYX1gZ+yvQvKdyLGRwJGswxqYfZ6P4zfDg=;
 b=N7ddJnFvuBGQbocKVeo912pvWByyOub+y/0yj62rmeKQFIzEDnA6RtMujWacM7K57q/2BYMgK45wPUSo0OQE2gue3jSMWEw9134KNCdenQSjIWpgePpo5WFeNzLV10TK/38XdAWPQsSvoCHpvYJ9ZxFWi7/JrWTyDjq1fAWzk8DJqBfBuPeeMXeRpZiv/PvwFe0Rol+oMJWfwv5XBPELhpNl/HYzu9Nm7z+wh4kF2t3ORJg0Qifw8doYcekgYCUc9O5qQvr8LaYvu/PxAxqjZxKaFuPZzYOQDCm25lO1JQ1as3plEcg9c9zAsf7+BVVY2hsG88bA9tS6gz2iUdGFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>,
        <Chris.Paterson2@renesas.com>, <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Release v6.1.83-cip18
Thread-Topic: [ANNOUNCE] Release v6.1.83-cip18
Thread-Index: AdqFmJPOCRmCelBJTmmeZtIoOQDPgw==
Date: Wed, 3 Apr 2024 07:29:55 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63888D201DA1B36074EDC0A6923D2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB11199:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 kK77bMZ0QM4dBTMNEOORQquJvFWhvoVTOCt2UqKJzA/o/5yMaNMI/7nCciJ04k8kxaj6QYVFi3GrEJK/LarKQoSlSk0Yfp9zryj+p40f6EN3ksKWGfxLBE62adBRYVnDsenfUhPP/LYn+dSWs8uaT0TMHqELfu8CBNaROoi8O4YCwmfMTFtH6+Qu1toPUJ/G9NlwxJo6r01yhUfkjKdDun3zml7cZnONLczKgs3AGIUA/Tdkcp1XIQPkfq2XLoDZzUek7kZVVp+CFx9ozQ+G9eL+pDOT/w3AwZl2FsRdA1g4Z4wQ0PPhgryTHf905VtnUqhOskA56bWpGVX+SqMBLOpPnn5AnHed9dMGKc+qEiacwBGH8Mi+66YTu2yUnR4r1X1UFxNdw8h6pW7f2kjCexnbPfNQHwxy8PCZrHp4jCnaeTA0DcbbuVcag7gI0kH3keFQNE4ymmKft2xqfSNUIP08U/FzLxA3aW+rl8WuilWEoFFYOa0pPzIaRjxNt6Xdlcx9okT4bfvheyUzGb0Pnix2g/7SrN+gYMW4xpx5uIhfzc4ckytKy+P6/R9kXYYVWBF/vWsnFfKu9WyWKPcOTmRAuVIUZKY+gO55ZMq+IUBhek0/gNTr08Yt5kAydICs1vQhUe702bsOUz60YzMBW1XFAPVaYef6vKBoS2sscq9QCbxR4w7arIgdyHSQKBlict2WszBaW6Xxmht9G7lDCw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(95630200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SE1qWllsclJCZ1Z4RWpwQXlCODNXblhaeU1jRkpxTWtkVEdLS0JpL0Jh?=
 =?iso-2022-jp?B?L3FGSTIzbVkwSThxeDZGQW10cC9wS3kxUDJGK1QwUk1Ob3R0SWRIYVNM?=
 =?iso-2022-jp?B?OGk2NlZ4cWE0VkdsVC9YWlYzZkNrQlUzR3RjNEdaTVZzRnRKdHc0bnBB?=
 =?iso-2022-jp?B?cmhTNHhaQitWbzZPRnMzK3JUSzV6TlBFeXQ2a2I0ekNmR3BEZmRHWTBi?=
 =?iso-2022-jp?B?MmF5STJsS0xrZEo1SUh4T3ArelRNSW93ajIrMlFISUFIclpGZXdtMjQ0?=
 =?iso-2022-jp?B?T1V5cGExQkJMaW9scU1NNDg0NitPVlQ3akpadTdSYldIQjR6WnNBYUxt?=
 =?iso-2022-jp?B?dlVUaDRNSDFnUlJNUmtBOThCaWFLTm0wNjcwQk9Xb0hTT2l3M1h4TGNV?=
 =?iso-2022-jp?B?d0VLUTJOaU9iREh1SkRlTkVMZ1RLelV4b1FqZ0FyNkord1dJcUNHWHlB?=
 =?iso-2022-jp?B?S0JCOUtGcU0yM1Rpa2FOcDNlQ1BHWG12NmkyZmJKMUwxWllFMkE5T3Vz?=
 =?iso-2022-jp?B?SUx5T0x5ZVdyckYzNnJXNlhWK1RDdWMvQzM1T1pJN1JUWnZuRTBvMzAr?=
 =?iso-2022-jp?B?RDc2b3dUTkx4K28rTVp0czhuYkdaZSt5UWxUZzhuMlFCR1o3OWd0SGdy?=
 =?iso-2022-jp?B?RkNlZHdJbmUzSFNRMUZDQ2tWY2FyU2NWVGh2Wk9sMU1lYkJybGQ1SVd1?=
 =?iso-2022-jp?B?L3lZUy9VVCtQcmdZSXZCeVUyamxnT2h1Uk1seHdCYWNwbXQ3QmhIQTJs?=
 =?iso-2022-jp?B?M0xTMlhMSytqNVRrNzl2S1VRV0pCV21SQmk5d2VDUjhnM3NCbjhXN2pj?=
 =?iso-2022-jp?B?MG5kdk1hbFZ5YUUzQWNENGNwSnBFbDRhNmRDQnFVZUhydzRUNWZUVE1U?=
 =?iso-2022-jp?B?Qm5Fei9ickVRT2RITWJSb1FHTEhkZWJPaFpMais1UVFSQWRkang3ZG5R?=
 =?iso-2022-jp?B?a1VnR1pPNzR0Y0wyQktjdHN5RnJSbW0rcGxMeXJSdEVzYzIzdU1IZWd5?=
 =?iso-2022-jp?B?MlBQdk1ZR1NaZjhJbnhhT0dwMmpjRTkzeVh3d3A5Q1E1Y0l0ekhodk82?=
 =?iso-2022-jp?B?ak12RmZ6WDN5N3h3c1NQQTFaeDZJeTdWaEtqZ0hQWVJ1NFhCbG1IaVVn?=
 =?iso-2022-jp?B?bkN5eEs5a0h0V3J1Q1luYUZkcGc5cG1WM09zUm5sY2xTUGxTWWxvSjd4?=
 =?iso-2022-jp?B?em9qdittRGlPRWlGMTZsY215Qy9udGtuR3ozUEVUc0dGTkp3Z3p4VjE5?=
 =?iso-2022-jp?B?bzdqQmRqOFlJN3djYTQwckVITnBJdUpWMy8yUjFQUHlNY2I3TXgxZXdp?=
 =?iso-2022-jp?B?ZitRZ3c2eVlxZUk2d1dRREEraGdZSUJDTVFleFlOeUltWHRvTTdRaEw1?=
 =?iso-2022-jp?B?dGlFZi9ZQjNyaEUrbHgwRWdBeHFQY01SeDZXemE5MGhIWlVuTjVUb2hh?=
 =?iso-2022-jp?B?SFEwSzU1MXpjU3hQWW1PampvUnZZd3AxeHIrUTBRdUVQUjBTMjVHTWVr?=
 =?iso-2022-jp?B?dDAxdjJEWjQrdmtMektva2hkNXZhNU5WMFZRWWdiZitnRGU4YjJZaldM?=
 =?iso-2022-jp?B?MjRDSGlSeUhUblJWTWtNSWpiR3A4bjFqMW9xcWV3SlBac1V2QnpSYXJn?=
 =?iso-2022-jp?B?T1VNbnJhY3NMY0xraFFlWUx0SzVlN2w3RmZqN3hhWXVsclJNVVMzNndr?=
 =?iso-2022-jp?B?dm0zZ21NTUUvOTZLUTVSWWZzN0EvVmZoOEtmUmsvZ2F5cXVSWkZ5azRQ?=
 =?iso-2022-jp?B?dytMZTh4RXRMa1pPdFozL1dGR21GZzRCeGY2bklvTXZnYzRvRFBkUnVZ?=
 =?iso-2022-jp?B?Y0d0NEJpVlpnRDJoL09LZUw0Yy81Z1ZJNSt4eHo3QnRXY052V1BodXNR?=
 =?iso-2022-jp?B?V0VrUG4xSjB4WS9OOU4xMUFlY1hZR2ZUdkxYZGxzc1gvYTF5OFBuRlZl?=
 =?iso-2022-jp?B?eFhZdkh2ZkY4aWJ1eDdRc2tUbGxTQVVjdE5LNFgzUS83d3ZBZVVTTVBt?=
 =?iso-2022-jp?B?L0IzV21NZXREaHAzN24wMVBCOVpkS3BGbThXY2s0NXlaRlpYdzZwdWti?=
 =?iso-2022-jp?B?ZTVhL25ZUEVveThLSkVTd25hazdWTUNPWXU0bk8veVM1enhIQkVpbHdC?=
 =?iso-2022-jp?B?d0d5ZWFNdWN3dlhiaG8yRTh0bXhqc01KUXpQeVdoK0ZXNkIvdTJxSkNT?=
 =?iso-2022-jp?B?MFlRU2JmUGwwZFNXNXlUc2tzVE5HeFB2RExHejJwVGtNMm9SMTNaUGxX?=
 =?iso-2022-jp?B?TTUwamFNaDhwNzQ3M0VUKy9UckFLZ1BHdy9ZN3VxUDVaUU1oWlVaU0Rv?=
 =?iso-2022-jp?B?a28zNG5rbVJXaFhkdlFkcUREQ1ZpS0Nzbnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d484becf-0696-429b-734b-08dc53afdc47
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 07:29:55.9799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGGw5IldhodR5SbztBtFqGpFp1DFHYX5FkaY9yMk7Mjzr81oFIundF0aozxwtvwFNcTUcHqVVDFyaDmxgfPIpQnJd6UHb/FY30piEeFPtAhfppfnsriTxwUUw7y1GJbr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11199
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Apr 2024 07:30:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15483

Hi all,

CIP kernel team has released Linux kernel v6.1.83-cip18.
The linux-6.1.y-cip tree has been updated base version from v6.1.82 to v6.1=
.83.
This release also includes an updated patch for irqchip of Renesas RZG2L.

You can get this release via the git tree at:

  v6.1.83-cip18:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      f9ab8e7cbe8c82ae2816e96b065638c1dbe70158
    Fixed CVEs:
      CVE-2023-7042: wifi: ath10k: fix NULL pointer dereference in
ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()
      CVE-2024-22099: NULL pointer dereference bug and buffer overflow vuln=
erabilities was found in the bluetooth subsystem
      CVE-2024-26651: sr9800: Add check for usbnet_get_endpoints
      CVE-2023-6270: AoE: improper reference count leads to use-after-free =
vulnerability
    added commits:
      CIP: Bump version suffix to -cip18 after merge from stable
      irqchip/renesas-rzg2l: Do not set TIEN and TINT source at the same ti=
me
      irqchip/renesas-rzg2l: Prevent spurious interrupts when setting trigg=
er type
      irqchip/renesas-rzg2l: Rename rzg2l_irq_eoi()
      irqchip/renesas-rzg2l: Rename rzg2l_tint_eoi()
      irqchip/renesas-rzg2l: Flush posted write in irq_eoi()
      irqchip/renesas-rzg2l: Add macro to retrieve TITSR register offset ba=
sed on register's index
      irqchip/renesas-rzg2l: Implement restriction when writing ISCR regist=
er
      irqchip/renesas-rzg2l: Document structure members
      irqchip/renesas-rzg2l: Align struct member names to tabs
      irqchip/renesas-rzg2l: Use tabs instead of spaces
      irqchip/renesas-rzg2l: Convert to irq_data_get_irq_chip_data()
      irqchip: remove MODULE_LICENSE in non-modules
      pinctrl: renesas: rzg2l: Use devm_clk_get_enabled() helper

Best regards,
   Nobuhiro


