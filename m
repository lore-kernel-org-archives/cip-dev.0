Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29267C25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 09:07:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.23571.1716800867630151888
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 May 2024 02:07:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=sJD6iYU8;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1716800846;x=1718010446;bh=Fp
	NvAxjQSRMBb45lannoaFL8/wMZllLzh0WjM+xtlH4=;b=sJD6iYU8NA4mRrsybXMdipcmr1/hQFsC
	LszuL63960vGsle5rrMmTElMwI6vv1bubsHOUgP9SDNAYI8rpgf2HdZZ58ID1efmv6R+qDY/6Revv
	MdcQ4Ul4tLPrC0/nFmiJ7h6r8VxqRn5ffemwyhMPP64HcpxhofCw1NvvhEA9iTqOx0LIDarm0XeDQ
	ioRU/5unS3PnPdo2O6Q+BjUcYe8O3ksegBCYDqIEI03w89SxCbCNW7p2KYC1soHzUXRSp/795RXXI
	6LNcXnLM2BwdDOVZUFUYwQroWeYSuFiL4OQXroYsYNqSIzuFW59UGBsyqxrnGFg3kX/2/D6ZsYok1
	Zw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 44R97PO61021737; Mon, 27 May 2024 18:07:25 +0900
X-Iguazu-Qid: 2rWhclmqRny1uR8GXK
X-Iguazu-QSIG: v=2; s=0; t=1716800845; q=2rWhclmqRny1uR8GXK; m=CM+dy251gNjgdQzfHgC/n5QbuVEhsb33mCA6/rJmKcg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 44R97NrV1025186
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 27 May 2024 18:07:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPD3D9Is5yNvaS0SHtw7HRtkR1XfBnFvJqB4Tcb/GJ0Xda0He6dfq8qdp85d6/m8oJ5nzmFOQyIRLQM2fKZQtROmGGF67rfrpcr+FS1MzNpfuhBj3B/t0qqdloq6GBJCFq18BOIa0n7OQXvymkKZ7DpgK7Ekdw6XZcrEXUIVk3R0njjICuBFGgecVdqI/DXKSuKAGKP7MU7WVTMfaX15tgOlmbtaZSZOwK+eec6hirKEp5/UqvgODP6LLb8X364Z/ehyp3OYmnn/IztK1bb1nt64rFPv1Xvsj7v6Yr3yOWUWUjMzEje3xHwy1yOeCptdgUp3HN0OiP0wPutf4SHbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVs1oguEPuW0u/gAEE3AD/4ASR79nwW3HQhZN6xc5jc=;
 b=QjbmLKiLdI0MAGhhU05scozh/AedPCZatsLX5WtWVEHTh1l7YRaFWYnEZzfrfiga8PUoZvle5kjcfs8Nhat3jencYeWGFF4PLIm0i3ImNkxh1B1DjB+53s/nPqPjy9PWqi2g5QgSVAR+TnNN7GsUECXryA3NirPyJU0l7hlLMX5poxvyEK0wXtC5xWKnoetKjOrphPf+tvEGRpa8WBnoupRjtQ57A7YhBTTY45CkucWTLJY6mPvcfXdStZGUr23k8Vvt3AzpOucwsiJKBVjYnS4NErKG18rKPd+3wtzkGeW2EpPEuwY0YxR9YFv4fctSBDPOi/CjUvwhP3UIhYIW/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <Chris.Paterson2@renesas.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.1.91-cip21
Thread-Topic: [ANNOUNCE] Release v6.1.91-cip21
Thread-Index: AdqwFR7vznFsxsdDT3C3nn+G0mXtCw==
Date: Mon, 27 May 2024 09:07:21 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638820F6155812159F65E30292F02@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYWPR01MB7203:EE_
x-ms-office365-filtering-correlation-id: fce8f0c8-22c0-4154-8317-08dc7e2c6af2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|1800799015|366007|38070700009|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?dGdZQ1ErMEtQbHJRM3U4SXI0NnlzV1Z5THp0cDVpSDBQaU4zN3U3bzNO?=
 =?iso-2022-jp?B?d3pSc1hOenRxSU1NeTl2NzFQdnpGcXBSNTFBS2puYUM4TFVGa2trQzJE?=
 =?iso-2022-jp?B?TnlYem5tc0M2eUkvNDlwLzdHRmFTakV1b0VEWFMrbkg3dmNiNGhSbXZN?=
 =?iso-2022-jp?B?YzlzM1p5TnlnaGVKV0lOemw5c0VwUC9yd0RsVzNUZ0hCZzJxUXN1WnBR?=
 =?iso-2022-jp?B?OUdSLzgyaXFrUXFYYzAzUDVFZ1hPdnlUak9IWWZLZDc4OW5BdHM1aEFL?=
 =?iso-2022-jp?B?aE1rRWIzWnlTTFRpQUNLUllRS1hNU1FxQTdBL3ZRcnJuUGxTZUtMU0cx?=
 =?iso-2022-jp?B?RFZUaVU2RDBiY0dpU2NWK0M0MVIyeUtvcHQvY1JzKzZIaHRUVnNPMDlV?=
 =?iso-2022-jp?B?YWNVU2w1T041WVlvbngrN2lQV21NZThXSG5oY1ljZGdVTjN0VjBoaVFG?=
 =?iso-2022-jp?B?RWVDM3lnRmoyMFMybDVpZFc2NVVJSnVjSEQ4M2JNcjZGU2xpYk1kelN4?=
 =?iso-2022-jp?B?VG5FV2Vpb0lZR1M1TmxNaHVjTlBYUTNRZnVhQzRJdS9NbXgxeVJzU0Jl?=
 =?iso-2022-jp?B?UlNOakcyOUluUVNDcUliaGlVSTNvOEZ3dXl3ak5PbTFnTnZwTkZyM2tU?=
 =?iso-2022-jp?B?cUxJcTVtYWR6T3Q0NDVVQ1RTcHNnSUp1YW5VV1hHM001STZaVG5lQUVp?=
 =?iso-2022-jp?B?OFFQaEdqT2dPeGdRN0MvWnZGQ1VZTnYxYjIxRGdNajJLOG14ZC8zTUE1?=
 =?iso-2022-jp?B?WXRscUc4Um5wU1pJM3pBalB1NThiZ1lCN083QnZuTHFKQlR3eHZ1WUFE?=
 =?iso-2022-jp?B?QVZVbUVKRG1BUUFuUDQrZWtRODVpVFp5NVVuRnA4eHZzNGRrT2Ezb014?=
 =?iso-2022-jp?B?OXJZTnNzNWdBZHU4U0RPQlNnVmZlU0R2S0VXbXVKNXo1NEVSRjZBSXFG?=
 =?iso-2022-jp?B?eWllUHV3NmxuRUJyWS9kQTIrbmZRdFdYbjVSUWtqS2ZXMVF5SytuQk1U?=
 =?iso-2022-jp?B?akpDQ05DNTBIUjFTTkZ6YWhyemt6ZE8vcGhYS2w5Q2ZqT256NHhEYkVa?=
 =?iso-2022-jp?B?TjZxODlCblY3TFlOM2lYWjdXNkZuekY0RjVqYXR3RGZ0ME0vUE5XcGVQ?=
 =?iso-2022-jp?B?Sk45SzBTeURkZ1QrN1YzeTFxeUpLamtHZm5PazNIMlhMaE9GVXlkUzRN?=
 =?iso-2022-jp?B?NEUwb2ZqU2JvcEkzZGpwNWdVY2lIWVRLNFBzSjNMMW9QM3YzMnNVVWVp?=
 =?iso-2022-jp?B?WWVFdUd2ZnlPMzhLWW9IWVdTUEZJZkJ1QmZ1ZWo3d1pZcUVuLzhSSmtw?=
 =?iso-2022-jp?B?QjNXdGY1MU02SmtEVlRUckM1Y1NscVZKTEg2aWtKUlQycXhpUlNHMko4?=
 =?iso-2022-jp?B?KzFNSG5DRTJsc3IwUlNFQkJwRmpWZ2VQUHFQZHJ0QUx6SW1ORGNCc1BQ?=
 =?iso-2022-jp?B?Umh0RmRjTkRiVTVGWlg4N2xNMnF6YXBVU2RIemZuREl6NmpoaHAwMFln?=
 =?iso-2022-jp?B?S1VXWTFHYzYydENXKzBTMm9WeVVPRldlSVluOE1xS0lnaEkrZVdnektN?=
 =?iso-2022-jp?B?Z1krSUE4NExLNHV1bXhadDl6Q2xlakVGWHVDQjBkNUF1YkZJN1FpOUdK?=
 =?iso-2022-jp?B?SmlvUTdKcWQxQ0pucUJNUUFTWmpEdEdMellNNVIxVFJOSmczZDA1M2da?=
 =?iso-2022-jp?B?bVBKU3RNMFJDNVRwaHAvS2JJcGVUSWhST1pPUHBGSW1nN0ZNc2Q3R2Jz?=
 =?iso-2022-jp?B?K1pyUjVhMVdtT2tLb1NNOUM5VkcwTzBjN3BtQm1PNEdLSkRaWHdmSHVp?=
 =?iso-2022-jp?B?VWtjTFBYZzRta1YzTjM4QWNGTnVHS2JZYkx2Mkw1aG15eFI1NFdPMWVx?=
 =?iso-2022-jp?B?WnRLTkpCU2E4MHZqU09pRDUvZTlPOWVzb1hWMzA0Z2V3Ry9PWksxeVlj?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aDFBUnBFdWw2dzE2RThZdzhEc3Z2b2dWaGJ2UVdkOWpjMkhlVW95T2h0?=
 =?iso-2022-jp?B?Tjd6ZnJrYms0QWtWR1p3YXZyNHpyc1p6ZEVFbEVLczE3MkZPZkdEUUYy?=
 =?iso-2022-jp?B?N2hUTXZadFhRZFBmTjNRbUZEWUdDNzNhb0JuUFIwdk9yaWNyeU1veVFY?=
 =?iso-2022-jp?B?VWtvRTgzU0plbkNPZE9EeGFzcXBuRHExc1I0S2pZN2JPZ09JN2JGMTRR?=
 =?iso-2022-jp?B?UXpkRlpsVlFIclQwL2ZVVHFlUml2OGRwalRxTHMvTW9zeGxXSk9nVldX?=
 =?iso-2022-jp?B?bFVra3pjRW1QZjFJUVVlRE1FYkpaSHhmMUowRG5xSVhXMWU4dDlJRjBW?=
 =?iso-2022-jp?B?amtTckNFM2RvVjhoS255K01hL0kxak8xbGlZbnN1bU15aE5BTEZGcWt2?=
 =?iso-2022-jp?B?akgydmxRMWYvMmgwbHZiOXBERllzTmttWHh6QW9oSkU5bnhQNmY4UEha?=
 =?iso-2022-jp?B?ZFYyWlVxbGhLMkdZbmRkVTkvT2ZFOWYyM3Z3bzVHYWhMaFYrOW5YWnBK?=
 =?iso-2022-jp?B?VlUzazRlTGJjdi9FMUZvaEtwc0NBTHBBVUxITTdPajFrcHc5b2RlZnVG?=
 =?iso-2022-jp?B?NXdoOGhmbE5sa3MrYkFZazVwUUIrVVF1bmZMU25qaFJ4NCtrbWtjakxB?=
 =?iso-2022-jp?B?MjlvVUMxOXIyUnJnME40K2NBYXZNa05BZUV4Z3poWklGTjlCL3FSM2Mz?=
 =?iso-2022-jp?B?NTl1dTFXemFjOUNnY2kxYklNdWdRWXl4d2ovcGZOWWNQb2dzYmdLcDVV?=
 =?iso-2022-jp?B?ZThYNExMSTZiU2ZvY1F6NlU3Z2tTQlYyaUdHYVZ6dEkwbDhxZG5pMzR3?=
 =?iso-2022-jp?B?VVVaRENCS0kxYkZaVU5QSXZsUFp1TThXN3JaVzVzMHM5Mjdya3NkSWpa?=
 =?iso-2022-jp?B?dzNFeVRaSnpBQlFBSURVb0lJcWJVdVp6ZWZBTFpNc0xYWjVHUXV4cUty?=
 =?iso-2022-jp?B?SGJDOEUzMGY3SmhUQTM1N2J4OFVuSnhDcHFHNXVpSzZWZmJWclczektZ?=
 =?iso-2022-jp?B?dEx6bHloT21tNFd4Vm5YVEZ0eFdJNURxbWNJYXF2SzFnTEVVTGNITFdz?=
 =?iso-2022-jp?B?ajdWeWs1S08zb1kxM2p4bGsxc1N6OC92dll3OHdZUEl6VG4ybnVmYkZw?=
 =?iso-2022-jp?B?T1h4R0l6RVBuemRXajVwcmRLWmpSb0x1NnRNTmloOWdTU1B3a0hYclF6?=
 =?iso-2022-jp?B?UC9BcVZKRitFenF2ZFRBeWZWOU1WUmJnOTl4dXZuSERsZ0cyOTlqcDMw?=
 =?iso-2022-jp?B?ME1keGZ1Qk5SWkttYnhtTWltb1I0VGk2RDVYYndab2I1ejVyNjIwTjhC?=
 =?iso-2022-jp?B?SHN2eUhsak9pQmhJR2R0WVZYbWpjdFNQcEY1OHY4MEUvQm1tWXZUUkpH?=
 =?iso-2022-jp?B?akVWMU9SMzI1NnVydGYzZlhYWTNUek1aQTlBN0tSTHZjcEZvYllGYXFK?=
 =?iso-2022-jp?B?TllmcUgxckVtNnM3WXJHYTlWQ0QyQ3ZLYWZ2NU5udkpKbjM3SVVaOFJY?=
 =?iso-2022-jp?B?cHVuUnZDSzg1Tys2WHhOSkhyMkFEdW5ZRW9Tb0l1WEtHSXdWaXM2RDV3?=
 =?iso-2022-jp?B?YjVrY3kxQ0trM1l0YlBtR1g3WlNrT2VndXV6Z00xcGJFWXAxTVFUS0ND?=
 =?iso-2022-jp?B?YXdXRklXVVNDWnJDMENnVmF3R09GM2NOWHlMQnpadEM0QStvVWsrNTFC?=
 =?iso-2022-jp?B?MjRMUUUvRko3ekxZZzdhV1hrS05UK0ppYzNHUEF0SXFGbHNtdEVrZDA0?=
 =?iso-2022-jp?B?ZkJXNFdhNU9Fa28vYkUzVXJOWlZZMHpXNUpVbWg2c0YraWJhV0hpeSt0?=
 =?iso-2022-jp?B?bnh1a1VVb3lwS1hZZUZOaGZ6ZlIwTWVjTDdQRGxOV3Rydk5KMHlUNll0?=
 =?iso-2022-jp?B?TXMwMC8wcG13Nkt3a0U2b2c2RzFuRStaMWJyNDZaWngzbmhCSGFrbDlQ?=
 =?iso-2022-jp?B?Q2U3TDQ4TGNDSjk0cERyZVhlazNxeTNNYnFLSnE0TElPN0tiNzd6TndC?=
 =?iso-2022-jp?B?bmgxdTkzUWxYN2ZzVVNvWDlNaDNsRE4wMWtGY0hZZjAyYzMrRmQyS2w4?=
 =?iso-2022-jp?B?blZUYktUMm1Fb1RXTUlkb3FVNzlNK0daOUlZY0ZHRm1RRFAwaXNONVYw?=
 =?iso-2022-jp?B?b3NzUWRWLzBHZ1VHNHU5Njk1Rk8wNEVMNWg1bEhwRFJCbzRGYWZwOFQx?=
 =?iso-2022-jp?B?MCtVdGRhYkZrTG5Rd2VEQXNTdXdzOXNOeUhZNnc0MmgvWW5iU3dJbnJQ?=
 =?iso-2022-jp?B?UVlhNFprYXFMNG1CVXFkS0lqNUVEUXR3RGE5MVFhaVNKS0s5Ulo1bFRz?=
 =?iso-2022-jp?B?cW1qRGVkODBGQlN5aGJsMExOVkM3UTdqQmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce8f0c8-22c0-4154-8317-08dc7e2c6af2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 09:07:21.7244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xs09lkAcING132eYh78lac/mQzPzfbRKw5JW+4Ar7oPNQH5gD1f/2geXLu1PyGDO3XKsJ2Hx/vnDxd6wDH4xwdUnlPu3bQ0XiJDo2AD7VFdKasLxwIFEA9yWxakw1wMI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7203
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 May 2024 09:07:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15952

Hi all,

CIP kernel team has released Linux kernel v6.1.91-cip21.
The linux-6.1.y-cip tree has been updated base version from v6.1.90 to v6.1=
.91.

You can get this release via the git tree at:

  v6.1.91-cip21:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      a0a19bca3e017d2d199551cdc0aa8e1ef92e48db
    Fixed CVEs:
      CVE-2024-35947: dyndbg: fix old BUG_ON in >control parser
      CVE-2024-27400: drm/amdgpu: once more fix the call oder in amdgpu_ttm=
_move() v2
      CVE-2024-26900: md: fix kmemleak of rdev->serial
      CVE-2024-27398: Bluetooth: Fix use-after-free bugs caused by sco_sock=
_timeout
      CVE-2024-35848: eeprom: at24: fix memory corruption race condition
      CVE-2024-35999: smb3: missing lock when picking channel
      CVE-2024-27399: Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_ti=
meout
      CVE-2024-21823: dmaengine/idxd: hardware erratum allows potential sec=
urity problem with direct access by untrusted application
      CVE-2024-21823: dmaengine/idxd: hardware erratum allows potential sec=
urity problem with direct access by untrusted application
      CVE-2024-21823: dmaengine/idxd: hardware erratum allows potential sec=
urity problem with direct access by untrusted application
      CVE-2024-27401: firewire: nosy: ensure user_length is taken into acco=
unt when fetching packet contents
      CVE-2024-36000: mm/hugetlb: fix missing hugetlb_lock for resv uncharg=
e
      CVE-2024-36012: Bluetooth: msft: fix slab-use-after-free in msft_do_c=
lose()
    added commits:
      CIP: Bump version suffix to -cip21 after merge from stable
      usb: xhci-plat: Don't include xhci.h

Best regards,
   Nobuhiro


--
Nobuhiro Iwamatsu


