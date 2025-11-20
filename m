Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA11CF64A1
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 01:04:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22562.1763600656240089778
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Nov 2025 17:04:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=gU9Z2Wg0;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1763600639;x=1764810239;bh=MKVm4ukkTIyZG/381SUjBtWGmZTY+nzGTPsQ5
	8PHL7k=;b=gU9Z2Wg0GRKu9UkghLbfGwbKtanXHLpyOxga/3AA+DE0ClWjnaZmONz01EwvfvBTtks
	r2wUVRtAB3mi0M2l8WPB+mB3+26X/PEDrqUL0qf4TFSSdo0/blkKXAy6RCZENOHaCi9Gs1cS7ns48
	ELnrcEC8NBN86wPnEPyqy0xy/Y9IlWiXh+aRDeIXoQnULF/Qr2888ubvkcjahRBdhGf7LqbncsICu
	RKKrUmraQWhYKKKAuWZEkpZW2WUcsEyaNmD84G4zc1IWN8+X4pdcHgLcfKX5iBBopusNyGokfwwIn
	/R89h3DL0cFpEP+wQpifwMdkleNZ54izVJPGX+v5qBTA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 5AK13w8R2364241; Thu, 20 Nov 2025 10:03:58 +0900
X-Iguazu-Qid: 2rWgIwSDDWlpvJXbsX
X-Iguazu-QSIG: v=2; s=0; t=1763600637; q=2rWgIwSDDWlpvJXbsX; m=Seil7yMrohll7gv/3QYBcweEaM2eunvtoY9+SQ1ao8I=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dBg8s0cy9z4vyh; Thu, 20 Nov 2025 10:03:57 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaQ5H5FKtYCdEshKa3tXtqyGruPvt+FT1V4OIHB+qBPbL2eKP+HZFVgHOQZEmaVEKr0y0Yocca/DzpQXoWmRBsQS9QMMviwl2cVmmmQbOpzpyJjoTtuw3nJNZLSj3+LV1IwrKqvZ4DbOC3RoWM3giXVdsuitwhJHopDshZ4uLZBHlKErkGlbvUtGTrLKngSsQySwDVblqL2sdNoSMK7FanNkjb1hTkFAGudqsgo4011oMmpVYbI9qkfSvel8sBrhymf/NMRdUu8VSuiv5Kzn/3dxMUTLlL0qv3JvsCBLSkNYEhuBDYFn9k2zn209WXPqiHjljmhoz/tQKAcQeApxKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKVm4ukkTIyZG/381SUjBtWGmZTY+nzGTPsQ58PHL7k=;
 b=l1/u8T0/kKxRGAmBaTBbv528DHJmgU5AX8cjP20fR8YNUBqnjFTsR5dlTkxLoXevfT7p3LdBOVOd1pHj84uqvsYLbxliS0+HEq0AVHNdIAD1HT3xJ/cfd6DQUKs9/0+aEOfFdjCkRHufjY00djvdLSjd6rb30adk98+2fo+j4fW2tQ+lBJ541X5ZRUsCxHxsmO+pz1m3He/C6iRJdPBXfTB5DlGliZL7XmPcToMD/Jc21CcAp+FZpWbW+OvqDSsrJ+0cqQGQvWW+5RIGqN7mS5X59eeqkI47IaV6JnI6IjZ9n37cF0LJOeYCuLtXOIu2SXWMmGrpgyBV2MypZtSjTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: RE: [cip-dev] Request for review for 4.19-st10, 4.19-cip126
Thread-Topic: [cip-dev] Request for review for 4.19-st10, 4.19-cip126
Thread-Index: AQHcV7MvnGUICkhdIEGBJZhDDdE+N7T6w48Q
Date: Thu, 20 Nov 2025 01:03:51 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818FD636AB317A4B87F4051CDD4A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <2007204340.35590.1763377975626@webmail.strato.de>
In-Reply-To: <2007204340.35590.1763377975626@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYYPR01MB6941:EE_
x-ms-office365-filtering-correlation-id: ad8fdb00-5154-4763-27c9-08de27d0ab7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?N1VVVGgxNENRZjRiYWE1RFl4dDdwZGhjVldYVGkrektSa3pRNk9NdGRCUkRq?=
 =?utf-8?B?ZENLdTFhU3ZkUmZOcHpDbE9sSXk0NmdYWG5WNDFHRkk2SDVURFNNQUFrc1ov?=
 =?utf-8?B?U2pMWUR3YUxqWU9ubDhsd3RYSVJvaUI5YVlDY2QxVnBlc0QremJPdnBINExJ?=
 =?utf-8?B?NERud0ozTmNDbUxKRDhyQjU5L25pTTNvejVqdVFMdXNWWVZVZzdYV2FhZEt5?=
 =?utf-8?B?TlY1NjhuR2tGczBrM2dkeDRkSDBSU0gwYU9qYSt6TlFESmd4OFVuUmpDKzBY?=
 =?utf-8?B?ck4yazc2RXg2c2s1U1BLakZ2allmU1JlNzRBUGcwZE5oRHRqOEZKa1VmUDNU?=
 =?utf-8?B?ZzMrK0o5OEE2U0N2ZG1tRmVBTVdCUTJaQnk4eXBNQ1FmZVdzdnNwb25XeGlp?=
 =?utf-8?B?YjBoalY2b3RGUEIvYXFUaUZFWUFVUlg4bnd6a25iRTNCciswRGk0Zm1VV292?=
 =?utf-8?B?Q3BWcmpXajVNRnZqNFp1bFFaM2dWQnowZzF2R2syWWNaaVAxbFhzOGZIUHh4?=
 =?utf-8?B?VU1hejVjRjByMi9zWjh1QzlhVldoMXJvcGk2c0ZBQ2ZQVWhPQWhMQ2c1OUJW?=
 =?utf-8?B?NEtkRlRaSGVrU0UwZVFhbDZvK1dRejJyQ21oeERJbGh4NFNtc09YMVpTS3RN?=
 =?utf-8?B?WS9YeUVuZnlPdHh4RzB3cmRqUXI1dFFacVFMdElGaGhwWExaSE9qWmNuZFhC?=
 =?utf-8?B?S0dqaml2emdFVzlzc0hVWnhaR21qODlIMStoQlF2dXV0MDBIWS96T3VGWEJl?=
 =?utf-8?B?aXNYZkVDOVZLM2ZsN1dmdVcyWnVUN0JmODA5NElxVkNVN3ArcEtTME9BUnBS?=
 =?utf-8?B?SkVmcWN6b1hBVWRSSlhzb1h0TFozeGgxUnIxK09HcHhpZXJ6Wk5CaFRmR2tY?=
 =?utf-8?B?SWV2K0tIR1Zaa3grcDIxUkJRT1g1SFdqcllJeE5xZ3pxQWd3cGpvbGcwWngw?=
 =?utf-8?B?eDlvc2Z4VnlvbWdxNExxbHlXaE5DWWlSUlBNZUY2WkV2VTVMSEVWUDdGYkxP?=
 =?utf-8?B?NlFyK0xmVHk2THNhU2NVNTdDQzZUZ0NZQnFLdkpDVkY0cldqSnlPc0FKLzJl?=
 =?utf-8?B?UzRpQm40RTdacXFJTFpBL2l1ckJxaVNYakgwclJSL2g5U0NtazBqQ2hJRGlS?=
 =?utf-8?B?blc5dTNJbFJBV084K1VzNzZMYW9YRW5tRlBwakUwMHRMWWpENUhoTVpneXI5?=
 =?utf-8?B?S0pOZGM5RlpKZFBMM0NvYmJwT29BVTBGVzhteFFjL2ZlT2NjdFc0d1BDZ21U?=
 =?utf-8?B?Q0xsUGZYbjlremh4dXRmb0hIcWZ2OEF1Nzhyckh4UmQ3eFVEMHV3ejJnZHVn?=
 =?utf-8?B?V1Byc0ljZDBvcVdmeThDWlE4R2J4NGF4cHlLdTlTazF4R0RrRmI1dGVMTXZN?=
 =?utf-8?B?QkN2bkpDeTFrUW4rcmxFUmtxL25qZTgxbWN6cmZ0VGFWQkpEVXFuRzhscmcv?=
 =?utf-8?B?S2ZjSFB2M0NrbytBWFVJZWhYR1ZOMjFXUFpsTkFvM1IxMFdzam8vbXhBQUJ1?=
 =?utf-8?B?NkR2bFdSRlJBbzJsUFBGVlRua2k5UGpDejdQVnQzVTJxMEt0ODBRSHJXNEpv?=
 =?utf-8?B?eGliQmZhL1BSSWRudEFMVlVQdmE3VWFLYmVPK0JVNHI2VlRXTTR4aHlEVW9v?=
 =?utf-8?B?TEVHVWUzZktiWjM2b0NwSEZKV3licnczOXdYSncvOHF6cU9NTkJkWFNuNExD?=
 =?utf-8?B?VmlRSkFZclM5b1dWTW1FT2pLOUJSTnp3eXhPZTUzbHlmVWd5SUJMKzhyUkJu?=
 =?utf-8?B?aVd2TzNwVVErelA5eDBYNzVlaDdZK2NtWUdSb2ZGNkRUVnlsTStXcjgyenNw?=
 =?utf-8?B?Uld0cGdFd1RtNnYrVlNHamtEZEFQSGJPVGZRcTJyaHhxUXdrMkFmRG9tWVBB?=
 =?utf-8?B?aEhnR3RNL1llNDBEM0RsNEZkWHVpM2w4NS9rWGM4cE80UjNBK25oVGJpRm9W?=
 =?utf-8?B?M3NYaWpDZGpkdUVYcTJ2MmJXTStRaHlmck1FVStLVTlVY2YrZVdZeVJSVVRq?=
 =?utf-8?B?OFd1NFRMTTJhTmhweTFhcHFNUU1aRHBvV3hBS0J2K3NUcWQyNjBDY0dFUHBN?=
 =?utf-8?Q?wkExUv?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SldCa1FFaWdBV3FnVlg4eUhNZVVjMVhVYkNGMzUrZCt3UzdMMFlaR0pIWGtD?=
 =?utf-8?B?TjN0L05oTTZwdkpWSTFMSlgzSlJHRlhTdHd2ZmRZeFNHK3ZCUUtJZEg3bEcy?=
 =?utf-8?B?YkIrK3h6ZDVBSWw1SWxoV0EyYi80Vm9qQ3hsWmpmSTJGV3dPL0ZPT2cyMHVP?=
 =?utf-8?B?SE8za09xbE1zQXBOZ0pjaVNMbFJ5dVhmenhRQUNsSDgydVpzUGUvd0ZoWW04?=
 =?utf-8?B?RUtMeDVBc1F0Z01INHZYOHFuYXp1Qy9IaVBmRGl4QURiUUw1QVVIUys1cytG?=
 =?utf-8?B?TGt4MExYamlpdk5sUTlleWtaNVRxdHRyZytuNjBiZW4yTG85N0liNkNrSHBK?=
 =?utf-8?B?Z3R5MmlzSkxFNUdUNHMvSjRMUlV2My93VVh1RTVFdzBsTGxxRHh0NEwrZHhH?=
 =?utf-8?B?WTlMSTBtZUpXVHZTYWU1dFROaTdsUDZFM3J0cU5QeUtpY01FV1I4dHNPaGUy?=
 =?utf-8?B?RHB0VFVma2FiRjNLN3I1K1F4QVU5SkV2SlA1Qm80WDRGSTdRV29jeEErMith?=
 =?utf-8?B?VnZIWGJZY1kzN3JMTnp4SUgrd003MzU2aklFVFgySTJzRmtkRHlLWHNyYlFZ?=
 =?utf-8?B?QWxmSnd0R3B0Z0Jsd016SzNYN2RBR25sTUpLSjE4OStZRkVSRit2TnM4T1Zu?=
 =?utf-8?B?Uyt1bThvVTRDVFNHeXdiY1dYcmc1MWdZZldXbHB4WEdNS1c3RjhHb2gvRzMz?=
 =?utf-8?B?UDNNa1Y5S05XSWRkRmxTdFlVZHZmMDYzamNOMGFIb3o3amJ6RlRWOWxteXov?=
 =?utf-8?B?Z3ZXN0hpb3psUXovYnBIb0RPRzcwNVNDN05IZTliMEFpTjIxeHJ1YzNCajlK?=
 =?utf-8?B?R0xwN1dlTnRxNWk4SDI2VjRFRjdYWmt5TW1RWnEwQTZxRGVkT0hlVzBEK1VL?=
 =?utf-8?B?bVZlWUsvTm5qdjd4dVU5ei9RQ0UzbzBNaHdEemdGclJzd0YyVDJENXBrT0tE?=
 =?utf-8?B?elZRNERGNWs1NWR0MStIZEN6Wk1pdHNYR2R1aGhNMFhweUoxQTd5RHZxdHJ5?=
 =?utf-8?B?QXRwV05POXJ6OGUyZ2pkWGlOZXpINnNMUGlTb0VDeFdZNmdqZ3dzNzZPK0la?=
 =?utf-8?B?Tk5zV1d0eTRsT0FvMmRiZ2RqSzdGUFpvM05lazJRN0Y3SXp6UEJ5RmEvaldx?=
 =?utf-8?B?dVZ4aFIxUHJxL0g1ZjVrUjBDbmYyMloza0pqUGJDRDUvVzFzd2p3eTh5RlFY?=
 =?utf-8?B?YjNwb3hJcVZIYjRxSytTNUNnaGhOdXBOTDVBaVFaMHNudW9KRSt3bU0rbEFm?=
 =?utf-8?B?WkRxekdDVnRseXR1OEN2SW1rQkRkYVVvRHNrOTVxZ3lKU253RXZmZE1leWMr?=
 =?utf-8?B?eFpoeFIwWEdRN3QySTJEdkZvcklTNzJGZUdrd01Fc0JITDBoRUNmTTRnLzQy?=
 =?utf-8?B?Z2VTWWxRcmV4ellDaEt2djVIL1pMa2prcFdLZGZOd0FLMUgrVFFXY0xSTW4r?=
 =?utf-8?B?aWFiMFdjajY2cTBMTTlWS3pOOWhjN21tN3JLWkhWZk1lSWlDd0huaHgyTVFZ?=
 =?utf-8?B?NnlzUGRzT2xGcCtsVHVTSW40Zzl5ZVN0MG50RmZ0UENiQkZlRmJKdHlXUEky?=
 =?utf-8?B?UU94bXkrUi9mV3dnZUtVSE1DcG1yakMzNzE1Sk5UYTkrVjgxUm9kM0NBRFd3?=
 =?utf-8?B?c0cxT2owdXJDQXJTTmJkM1BaYTd0UTk5Qlp3SDNYYkdkVTltcENHeXM5d1E4?=
 =?utf-8?B?WEJ3SVFKNzJGcTRMOWhBNmlFQkF5V1lBcWFuckhhdFlQMEtQMm9QMWhIRlhu?=
 =?utf-8?B?L2lKem9KSHB6RmRQZGhsUEtlZE9CUlFISVNJaTRzTU9KWjFZOTJMQTI5b2pF?=
 =?utf-8?B?TWV4TTB1TmJweDRGc2R5dzdzRXpCamtjS25wMk84QUJ4cC9yUjRFV2hBZkxT?=
 =?utf-8?B?NnV3bEFQUzZWcnpFYTluRW11ajFKNXoxK09PR2l0ajgrT0ppb0NPRVRCRVF4?=
 =?utf-8?B?MnQyOVRQZHRxSW5HUzhqalc1Y2hpTnNXT3hGdDNIZUpvSHB0WWtWUWR1OEdJ?=
 =?utf-8?B?aGNLMTFqbFpqSHMzbmR5RE1PYnM0RjhJWVNhcXF3dHdMUzhsOXVFK2dsNkxs?=
 =?utf-8?B?eTY0aXZyL3pQRHM3RzlMdlR5T3dMMWZKc2tob1k3U2ZVYjBLTzJ5aWpCUjc2?=
 =?utf-8?B?cks1NW5EZzdRR1UraUV3OTZVc28ra21RSHFaeDgxN1Y0SjJuUUU2b3R5Njd6?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8fdb00-5154-4763-27c9-08de27d0ab7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 01:03:51.6727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3JeEFJoqXg5KOACM8O5S3daou31l8dHUCx83uJBdLPasbgeknb44wsuzC+XZouLHB/dpKk1mgcyZqnyerEB0vq6OcGD25BkuMLAt+dBoxHd0mMWrnXBzd5uAPZAr/3a3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6941
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 01:04:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20629

SGkgVWxpLA0KDQpUaGFua3MgZm9yIHlvdXIgdXBkYXRlLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24NCj4gQmVoYWxmIE9mIFVscmljaCBIZWNodCB2aWEg
bGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMTcsIDIwMjUg
ODoxMyBQTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IHBhdmVsQGRlbngu
ZGU7IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6ENCj4g5rSLIOKWoe+8pO+8qe+8tO+8o+KX
i++8o++8sO+8tCkgPG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmE+DQo+IFN1Ympl
Y3Q6IFtjaXAtZGV2XSBSZXF1ZXN0IGZvciByZXZpZXcgZm9yIDQuMTktc3QxMCwgNC4xOS1jaXAx
MjYNCj4gDQo+IEhpIQ0KPiANCj4gSGVyZSBhcmUgdGhlIG1hbnVhbCBiYWNrcG9ydHMgZm9yIHRo
ZSB1cGNvbWluZyA0LjE5IGtlcm5lbCByZWxlYXNlLiBBcyBhbHdheXMNCj4gdGhleSBjYW4gYmUg
Zm91bmQgaW4NCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvY2lwL2xpbnV4LWNpcC5naXQvbG9nLz9oPWxpbnUNCj4geC00LjE5Lnktc3QtcmMNCj4gDQo+
IDA0N2MxYWM4NGQ1ZTggbmV0OiByYXZiOiBFbnN1cmUgbWVtb3J5IHdyaXRlIGNvbXBsZXRlcyBi
ZWZvcmUgcmluZ2luZyBUWA0KPiBkb29yYmVsbCAxMzA4NTkxZjk2MTRmIG5ldC9pcDZfdHVubmVs
OiBQcmV2ZW50IHBlcnBldHVhbCB0dW5uZWwgZ3Jvd3RoDQo+IGZlMDI2NTQ3YmI4MjIgdHJhY2lu
ZzogRml4IHJhY2UgY29uZGl0aW9uIGluIGtwcm9iZSBpbml0aWFsaXphdGlvbiBjYXVzaW5nIE5V
TEwNCj4gcG9pbnRlciBkZXJlZmVyZW5jZSBjOWM1NjQyZWI1ZWVkIHJ0YzogaW50ZXJmYWNlOiBF
bnN1cmUgYWxhcm0gaXJxIGlzIGVuYWJsZWQNCj4gd2hlbiBVSUUgaXMgZW5hYmxlZCBiMjViZjU2
MTVlZDZmIHRwbV90aXM6IEZpeCBpbmNvcnJlY3QgYXJndW1lbnRzIGluDQo+IHRwbV90aXNfcHJv
YmVfaXJxX3NpbmdsZQ0KPiA2OWZiMDA1NmY4MzEyIG5mc2Q6IG5mc2Vycl9qdWtlYm94IGluIG5s
bV9mb3BlbiBzaG91bGQgbGVhZCB0byBhIHJldHJ5DQo+IGVlMWViN2ZjYzRiMjcgc2NzaTogbXZz
YXM6IEZpeCB1c2UtYWZ0ZXItZnJlZSBidWdzIGluIG12c193b3JrX3F1ZXVlDQo+IDkyNTVmNGYw
ZjcwODggc2NzaTogcG04MHh4OiBGaXggYXJyYXktaW5kZXgtb3V0LW9mLW9mLWJvdW5kcyBvbiBy
bW1vZA0KPiANCj4gVGhhbmtzIGZvciBoYXZpbmcgYSBsb29rIQ0KDQoNCkkgcmV2aWV3ZWQgdGhp
cyB1cGRhdGVzLCBJIGNvdWxkIG5vdCBmaW5kIGlzc3Vlcy4NCkFuZCBJIGJ1aWx0IHdpdGggYWxs
bW9kY29uZmlnLCAgYWxsbm9jb25maWcsIGFsbHllc2NvbmZpZyBhbmQgZGVmY29uZmlnLCB0aGVz
ZSB3YXMgbm8gaXNzdWVzLiANCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K


