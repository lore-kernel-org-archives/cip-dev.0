Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD3C10854CB
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 02:04:14 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5254.1773799448306799558
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 19:04:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=D8jnbakn;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1773799431;x=1775009031;bh=
	WPw+00rB11VOOSELztaS5F5q9tGPvChgXyALxYtSv0Y=;b=D8jnbaknTDNjcdnu5wrRximkzNgHNM
	4Pm7XLJYmcHAmUTLRQVf5KWRktbX4cpI8DkKFIkwsaXbfQea3Idx3g0FL5XtpU8D5ClNE6zcSdHj1
	h8OsXIJaKDIHE3YTk79Pa/LnmDUiAYFs8/phXBZ/Wa69j32MbpWKeJPkuqAB/EKJEZbRaAB+3r0gk
	lLrVRgDEXBU9TBvL9MU0uzYXnEyEG+dwbKoY0H43ryfx/ikcK2I3I1wfBYwPhVRZ0rHC5KH1JCfMS
	kTAAAEP+rLOj52qmKkYj/netTuMvzrPvfbRILkNolzn/r8E6YCutZKzsDwJvG4Htk9BkwJ1AKMvAe
	179Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 62I23o3i2740209; Wed, 18 Mar 2026 11:03:50 +0900
X-Iguazu-Qid: 2yAazS63SmRwUqWYOi
X-Iguazu-QSIG: v=2; s=0; t=1773799430; q=2yAazS63SmRwUqWYOi; m=GasUfqnVNC7T2u30t8yQbdUfhkkhWn/5Ymi5q0jdMFo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fbBvV1s3LzyPZ; Wed, 18 Mar 2026 11:03:50 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgdmDZVUljz+OkXdvPCaXDBGlmVZiUY97SVpOZrBRKv8jMKhcrs5DsUAFMvKwKxd5LJcIc10ul1MU//FUP9EczDE31c/PoMEqFTEDxVCtwmuKHrxHjyXEJZdbaFc6Ypr6yiR6FJF9RX4IEiq15k9ERQbVNvIy3aPPKhteZYot//Yo9P5H2cJKFUKGboQZ3EJY5gNFVxoYuLtgCwVe83MghN87PaRidLgcXJkFvuMZicGTFt3aiDz92wtlJwC0Gpyo6aF04FUfrWxTYXqnmsrX4m5VqIhXwmgra1hF4bieYlH6+RwcyNcxmAPFb2jABJhcZMjwJhhI2FS5s0xar1/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/tO6ezaG/Jbexz8hxtA7dXAG0bKRxAeO27ccRgIVp8=;
 b=BPMTHYj7CywZHNSDSdqzE8/2k6u5N1HMofFM9eAEOK6aqMjG9Mib4gk6cDtNGoah7dZXCnITNhnSaEJ71J5sJf+OF/FgomqGGb1ONnNpx8USNJ3W633PdikAXzTX8CiK4bRw3rYmLOpRDR7MKN+ZpKA2PvOtkAbfyFpETiPHtVSNvmYrJLBPE/e7OPJMzVM9RkZ55tj7/I2IrjS1nCJf3/wfNMKx4074t5Nq/4rpWHnzF9Qf584rcTd52ISONcm9pKlT1N7qzkvFNuW+aGd4u2qG+Xge/j60cKZdNce1nUVt7Aiv5Et+mgAfNbqcM5p7j5WkShBgvR/RPw3gFsgCJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <gregkh@linuxfoundation.org>, <sashal@kernel.org>
CC: <stable@vger.kernel.org>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>, <chris.paterson2@renesas.com>
Subject: [for 5.10.y] Please revert "8af1c121b0102 riscv:
 Sparse-Memory/vmemmap out-of-bounds fix"
Thread-Topic: [for 5.10.y] Please revert "8af1c121b0102 riscv:
 Sparse-Memory/vmemmap out-of-bounds fix"
Thread-Index: Ady2el02gK+YDzd5RYq5PYUOV/kTSA==
Date: Wed, 18 Mar 2026 02:03:44 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481866BE80F41418D964AE61CD4EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB13879:EE_
x-ms-office365-filtering-correlation-id: 3f6bce0a-bfb1-49e8-afea-08de84929602
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: 
 z64L26l3eC6b21wSEZOy9x7Sx0Bx6/rlgv0wEgxmr/1xpQV++pnL5/W82Xy/gSMYQ/Q3tHJonewyUEu8T049a87TSgbgS2ZavE4CH4FA8r7p2jWW6/G8THOaLbxt/fqfN/HYpDXAA2kizi61TgiExDFB7li5xMPOouJvSVy3SEy6fgyBx6kkr+PQ+HuAPajfwSCQiZCy7aq0/AHZQ6BREgMxSqwpleQ7X5ez36lJm+lD7tVRwLKWwC5qI+m+qF4Wlqb6Hnh+O+srTmgLxhEbl8u8+zEXfD7DOMKQFl2qTq6wwpWnn8RmPajG8d8Qufue4cW6Yp+0g7wCKao74LOyFbOxf40Oi3GeYmyHi5D32h6xLKeXxcxeTMW0ulNaq+5zQBbaQ7N/9eHNSMuSY1QFygmqEkbD4YUAgxtdHbj4W0OO0A70QrZbhhV495AAWohA/qyf4IUHCBU7fIG1yyc5+lwZUqVPB/ka+6HwfNnxhiCHXJCx5G5/IJ6wey7CMCegNVhakqvaZcx81lJekct9Kd6FRafI+vansVpahtxOaLiIhDInMz9CnZ0haddWeDGCjHD1OdOI8OSPWw/LP0Z7BvXKWfbD9NwjJk7xSyaRsC62X/31GBc0bmjkUTkvC+q+7i/gGzI/KTXEAwGohvdb7K3O7IzFpQn2bY1GN5Yndp6JOd0F1PcxH4ICPmeZ7r4jw5f9Srw9w9xFVsuBVza8m9Xs483VWKQ3LF6hdA6DOMUd60M0xCUX5UpIXv9/Hp5jNdPcOpUuB2+oaoUJ+qbZt4nY40BoAn5z2zMWxU/J7kY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?R3JTNVcwY1JVN2RCNDNmdzFlR2Vad0xaYkErT3FqRGxoR3E4aWFyMWFY?=
 =?iso-2022-jp?B?TmdTd204R1doOFlkd1lZRWY5S1FkRUU4KzBNbE1oamFPQmdvUHJNUERu?=
 =?iso-2022-jp?B?dUx3aWlsNkt5MmRmU3FiWWNlbHh2SlA4RElZUGNrTmxrc2FXNVd2UGJn?=
 =?iso-2022-jp?B?V2RIYW5qNEdkYnRYQXVlUEl0MzU4dzhnVjVNQkxTZ3BNdkFXRGxFMWhC?=
 =?iso-2022-jp?B?bCsyUGx6cDd4WmcvMmFEN0dLKzh4aXM3VDA0cmhtVHkvVEE1a3dubU9Q?=
 =?iso-2022-jp?B?TmN4R2ExVVFDOWs4d3kvektIeFhuREJsNk5uWWRkR3UwOU4wWGYzbVUv?=
 =?iso-2022-jp?B?d2c2UnlWZnJrUktobzQrdS9qSCswNEY3d0JaaFZGenBOd2o4MmpOUVBY?=
 =?iso-2022-jp?B?V2hlOVRzZTJxaDI1clliOC9GMmYxeFVYVmhyNmNYM3BMMjZDQ1ZNRzJ6?=
 =?iso-2022-jp?B?cG9kdHB6SzZSWUo4Q0lOdUlCNVRYR2krUXVVclhSTGZhRXkyMzlzSlVZ?=
 =?iso-2022-jp?B?dG1qNXduYU5ROGFZRjBBWDNlVTdRcVA1aVJLcjhMeXVSMTVSbG5Nb1hx?=
 =?iso-2022-jp?B?bDB2c0ViZHJRb2dEQXAzeVByZjhQb2F6SzFqL1p6bDQ1RndOVk1qRUhp?=
 =?iso-2022-jp?B?R2FLT295TW9QVk1qYXM3RjhTQmtJanBKVXBWVG1kbFZOdWRLYnlsZFFr?=
 =?iso-2022-jp?B?NTBNQjRNNWRSSEl6RW04OExkcnh3V3l1UGM1SXVUUmY4K3NXeXhwRXBW?=
 =?iso-2022-jp?B?UzR6U3ZNeG1BZEhxY0QrWVNJTGdXU3BtWjd2RXhwYXNqR215V0lxaHRG?=
 =?iso-2022-jp?B?aklzbm1MNEpZQzJrTkNJME1YZlZVZ1hUVmh0MGFsTGVMMW1UQ3BaeEpl?=
 =?iso-2022-jp?B?NjhxQnRKcVpDY1BXeHhqM3hwb0VZZm1OTWZHN25uQ2lnKzJ4VDRaYzM4?=
 =?iso-2022-jp?B?NlVUeFNlRmFuOTRXcWJ6Vk54TVBaYmJlaGMzZDEzdEZRd0pVZTh3dUJS?=
 =?iso-2022-jp?B?MWdVdHcwOUl2c3Ziem1ZNm8wejgzaGg4MTJ0V2tCM0dSbkxMNENNT2tT?=
 =?iso-2022-jp?B?MG5hbnJoQmNaMTdlWE50S083UEQxZU1idml1aXRsWXZiZTdJbU1sVU9D?=
 =?iso-2022-jp?B?dklsbWpEb3ozM010RTFaYTZ1eVp2VXZ4ZWd0d1FmcWJMb2Rhd0FEelFj?=
 =?iso-2022-jp?B?S2FQSys2d050TDZYNzc3ajVSTW9WS1Jya0UwZmlyQVRFcENvOHNGV0JM?=
 =?iso-2022-jp?B?dlhIWjI1cTJEWXlONndPNW1EbHpsb0k0N1ltMmhSN0tMK09jV1hPNzlv?=
 =?iso-2022-jp?B?THdUR3h3bkNVL3hxSXVlN1NtR0ZkWVZtUUdCbGs5NnhqVHN3Q0RBUjdm?=
 =?iso-2022-jp?B?K2FrNTFDUUtIL2RjelVRVE9ZZWM0a2dtZFovTDNqQUFSSWxtNnRIS2pj?=
 =?iso-2022-jp?B?NEJPTVBuOGp5TFlrS094bUpNakRUSWhhNms4MzROeExnbEJkdWM0cVVz?=
 =?iso-2022-jp?B?RUlmeUliNkg3aGZHYTBEbUVPRENTMWhrbTd1OXNPU25ZUWRKeWU0Wk1T?=
 =?iso-2022-jp?B?UW1XZmFBOTB4cEJDelBMOU5DUTVpT2tCZURvZ2lZV29FMFozRSs0Z0lV?=
 =?iso-2022-jp?B?RDNrbEhSSi81ekRxZDNnb0hEb3dnUmZYRlU3cGxwblQvTklaUVphbis4?=
 =?iso-2022-jp?B?bGk3cFp0bWpvMDhaOEc5NEZ1eFBMZkhUQzBEaW1YV0x4NXFTcGdNcVFy?=
 =?iso-2022-jp?B?cmc5WElhdUc0N2loZ25lQmhEUUptdDgrazluVS94OWdlSDFBMVN2TjJw?=
 =?iso-2022-jp?B?L0h1dElLUG8zVFpTRjlQMktSaCtXZnR2MllYRDhrcTJQSzZGbUd3aHJJ?=
 =?iso-2022-jp?B?cGk4cmN2OWlZU29nelRBaVNVckRvWGI3bHQ1T2VKV2hqN01lV3pidUpR?=
 =?iso-2022-jp?B?aHUwYjRwSGJjRjQ1OGZnbHBxS3dNVDVHWWd5dDJQTTJibWY2dS94V3VN?=
 =?iso-2022-jp?B?anFCZFZWNDZwWW5kZDAxblhYMnpSdWErTm5MY3JSYTBha1RjZzVHdEtK?=
 =?iso-2022-jp?B?cWhmbXh4U3hobzE0VS9vMUUya1dtbkRqUFQxdXBnMnEyekl2N0lTTHNU?=
 =?iso-2022-jp?B?bXhWUWZCR29iaHB2YTFUQlg5M2Y3VGNqMGx3bTIwSy90QS9ETnJlaDNM?=
 =?iso-2022-jp?B?Vi85TXhOUzhNRjZzeHVCclRGSUhwQ3RiUFc2elZlZU13UTBOY2E2Qkpz?=
 =?iso-2022-jp?B?cHJPSDIvTlhaVUVLajJ6V0xsUEFZTTVLNVlXRWd0UzNkYzZ2SWcxdzFr?=
 =?iso-2022-jp?B?dG5RRDFXcnlqaFN6WUgyRldYSUJyV0NPcGdpVDNMVXR2WmlDUnJNeFdM?=
 =?iso-2022-jp?B?cE1MMSs1aEI1eUlWWEJwbGJCa1VRRkxDWllsaFhFaHROYW9uZWkvenMv?=
 =?iso-2022-jp?B?VmJORVZWeUVOK3BVcE9rSTZZbnBNd3JsZWZ4QldOOGlsWUJOZmRDdDRk?=
 =?iso-2022-jp?B?Vk1SMENGUWJya3hjUjNvYlRBSUVZSmMrTFUvczlqQW1obHZWMDVid3k2?=
 =?iso-2022-jp?B?eW01SjFRQT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	uFX66OWJtZT3zM6tYPbr1/XksZhgg75QSgJWgmeMk2q/OASu4hT33AQj6hygLCnsZgXeNLWvgspAazmLxsQiM9RwxJ7PDRSSEaTYEv3qaGt6T/tCTCuu8SCExLDiRK/y2Hw3n+0Dfg0cDT2Cnvgm0o0zcS40gPZXjOXud7tBPkul7cnz7g54xRykUimuBP5S9ch1RJH6YE5D/MnofzxjGWgep/gNq4pdpw1uOOm8omgoqDI44bkfYjgiSQIirhA/n25jfMvHZ9LNTrnAj0URvHGHiVBzHW07PH2e8QknU0OemCC4ufciz9THKsk7x+bDX9eZPYc5Y/zsBBwsE5orDg==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6bce0a-bfb1-49e8-afea-08de84929602
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 02:03:44.9576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JnVIbElUOpnUlpjwVZE/N/Qs77ZZmTvLD7MWMsFbsQlwPEvGz5N2Ep2UlTlGAGHFN3VtBw+nq8SL55sn5egt1qZakloU8vZLcyOczDKg9AViKofJ8hlpD8IEL70B0/ut
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13879
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2026 02:04:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22494

Hi Greg and Sasha,

Please revert "8af1c121b0102 riscv: Sparse-Memory/vmemmap out-of-bounds fix=
" in Linux-5.10.y branch.
Since `phys_ram_base` is not defined in riscv, a build error will occur if =
`CONFIG_SPARSEMEM_MANUAL=3Dy`.

```
[...]
                 from arch/riscv/kernel/soc.c:7:
./arch/riscv/include/asm/pgtable-64.h: In function =1B$B!F=1B(Bpud_page=1B$=
B!G=1B(B:
./arch/riscv/include/asm/pgtable.h:47:58: error: =1B$B!F=1B(Bphys_ram_base=
=1B$B!G=1B(B undeclared (first use in this function)
   47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram_b=
ase >> PAGE_SHIFT))
      |                                                          ^~~~~~~~~~=
~~~
./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =1B=
$B!F=1B(Bvmemmap=1B$B!G=1B(B
   54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
      |                                  ^~~~~~~
./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =1B=
$B!F=1B(B__pfn_to_page=1B$B!G=1B(B
   82 | #define pfn_to_page __pfn_to_page
      |                     ^~~~~~~~~~~~~
./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=1B$B!F=1B(Bpfn_to_page=1B$B!G=1B(B
   70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
      |                ^~~~~~~~~~~
./arch/riscv/include/asm/pgtable.h:47:58: note: each undeclared identifier =
is reported only once for each function it appears in
   47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram_b=
ase >> PAGE_SHIFT))
      |                                                          ^~~~~~~~~~=
~~~
./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =1B=
$B!F=1B(Bvmemmap=1B$B!G=1B(B
   54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
      |                                  ^~~~~~~
./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =1B=
$B!F=1B(B__pfn_to_page=1B$B!G=1B(B
   82 | #define pfn_to_page __pfn_to_page
      |                     ^~~~~~~~~~~~~
./arch/riscv/include/asm/pgtable-64.h:70:16: note: in expansion of macro =
=1B$B!F=1B(Bpfn_to_page=1B$B!G=1B(B
   70 |         return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
      |                ^~~~~~~~~~~
  AS      arch/riscv/kernel/vdso/flush_icache.o
./arch/riscv/include/asm/pgtable.h: In function =1B$B!F=1B(Bpmd_page=1B$B!G=
=1B(B:
./arch/riscv/include/asm/pgtable.h:47:58: error: =1B$B!F=1B(Bphys_ram_base=
=1B$B!G=1B(B undeclared (first use in this function)
   47 | #define vmemmap         ((struct page *)VMEMMAP_START - (phys_ram_b=
ase >> PAGE_SHIFT))
      |                                                          ^~~~~~~~~~=
~~~
./include/asm-generic/memory_model.h:54:34: note: in expansion of macro =1B=
$B!F=1B(Bvmemmap=1B$B!G=1B(B
   54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
      |                                  ^~~~~~~
./include/asm-generic/memory_model.h:82:21: note: in expansion of macro =1B=
$B!F=1B(B__pfn_to_page=1B$B!G=1B(B
   82 | #define pfn_to_page __pfn_to_page
      |                     ^~~~~~~~~~~~~
./arch/riscv/include/asm/pgtable.h:181:16: note: in expansion of macro =1B$=
B!F=1B(Bpfn_to_page=1B$B!G=1B(B
  181 |         return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
      |                ^~~~~~~~~~~                                         =
               ^~~~~~~~~~~~~
[...]
```

Best regards,
  Nobuhiro


