Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCD6C3ABD9
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 08:35:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.96976.1747211735824900374
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 May 2025 01:35:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=hDCUU/ld;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1747211722;x=1748421322;bh=6rrKEt4Zvl6fMRzD6szmvDy15obI4yYBZBwFA3d
	611o=;b=hDCUU/ldl3/yiUFu7FRbg8FY9p+bObHKvw7IhpAOIgFjZ08fZYfJ+Qgwv4/zR2DO4nQWt
	DQ6rD7I2hkVWyfmnW/t+gcVbnrhiFp7H2kIVuRyq7yQbUk9nvojeoHveIftfBMLj/SpXuUjs/Zgyb
	Utoe1S3HYEoM/5WprDXYzy6ZViJazW0mUu4zaW04jngCTfAC0g6hKevWz+kHk5xSa6bHGi9b5zkQg
	EKeDiMsL0uNLmR2iu8elgfB5blDyTVbBv601qpywW6I7BBqaB5KkArgCcAJotoC4i0zd+R943SfVd
	CkUZjh3W3/oi3wylW2awNGoid+4PMDnGsxImY2S9Qg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 54E8ZL0d356456; Wed, 14 May 2025 17:35:21 +0900
X-Iguazu-Qid: 2yAbyr8UqUS01JD9LU
X-Iguazu-QSIG: v=2; s=0; t=1747211721; q=2yAbyr8UqUS01JD9LU; m=B49yxWzMu7xD0iY/g/uwhPgrz+9SFSO5Bn6AROzRo1Y=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 54E8ZKTM2934389
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 17:35:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOu18YZfC74h5BI3MbgEbR3S5RviVBiacFp1+1afHPPI3/4GR0/2mryfrXWSiDwXtKwjUezc/ZjSzdRi1zQ82np2EBSntIdQvwOKjJPchhYbamhRncQtpM5SmUR41fQ/p6V1XyveM3AnjLjNqWZUjj5U0SyIqXjwNpNFlKc25oppHYIO01YLfP4rZDNFOCV9hkuyrK8I5b2DVrN4FUnO9kAWTr6jcqU7Uh9vnc8ooxeGBSwMfJxpHNO1jTwJnfinYhrH1MEnQB9KL5n5TK9AzCTbLaaJwRSt4KkxHWqHjlLcE6qyeLQaIHXpgBeo+8vZ2BNuWKZCeTbG7f0NoIT5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUvZQAoVsmV79yhPGxSSHX0crS2v3pgzOAqDaW4Ze/Q=;
 b=fIdk489KnovxOPODGtqKXJ8xmmpLQaY8WrHg07IYqHr+jU5hWovTHfyKfka0KwMwpazID3OhBs77Cs6XbVNLalh6Mm/98xn7F8jrKXR2LdO1M+SdDSrzmb/F5Da4bZPU4juxYBagNlu9sVTCm/D0EyY39BGJLlw7MFE0E6Rp7iVT6KbXFz3iQHJXsLRuazXhDLm+cSZTDxiPsyHfI55s9XGd9lMBHqBvg3YFQ9qec7hygIPbp32PmxN4A4vtY7yMMoIh+tD8zsX55lTegX/fiiepQdHwoKyaS8SeR70aFtWZ5KuEOjHawup8y1CgaQM43jfnhpPEjcOlBPqaNLePgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <cip-dev@lists.cip-project.org>
Subject: RE: 5.10.237-cip release
Thread-Topic: 5.10.237-cip release
Thread-Index: AQHbxKYtgtk58jIknUW/ZtUCZQFaYLPRzItA
Date: Wed, 14 May 2025 08:35:17 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818556E8FC0E79225E82A999291A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <aCRNYn3zxpNa9LzA@duo.ucw.cz>
In-Reply-To: <aCRNYn3zxpNa9LzA@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB9273:EE_
x-ms-office365-filtering-correlation-id: a1e2ebba-8ee2-4fda-9c20-08dd92c24181
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?VVdmZUhZcWtNeDZPL3AyRDNnMFpGR0dvTldkeXJCMUYwbFpkMGxWblg4?=
 =?iso-2022-jp?B?UU0xSlIzM01ySThpclJPVzJ6LzFlTVQ2WnlNSlJXRDlBUStGRS9WSG9N?=
 =?iso-2022-jp?B?NldSRWdaUE5GWTZoTkJMb2taaG5vNGhkSGhvZzRhd2U1UUZEZkxWNzJL?=
 =?iso-2022-jp?B?QlNhUDd1eW44MzI1c0VBNS9JeEFWOGhXTTdIa2JZbWtLd1lCVTgyczRi?=
 =?iso-2022-jp?B?Wkl6M0hNTi95Ym9DdzM4amR2TWpHNG03N3JDamtiUzFNU1MxaFZRWmVM?=
 =?iso-2022-jp?B?cE5SZ2RWaGFpb3ovNjJKVXd6YThYRXlHN0N4djl1Yys2b0dsZGp0UEFG?=
 =?iso-2022-jp?B?L0k0WWFnMjVnRElVcFNnRlFRRGdqU0Y0ek1ZdnJhdlRQMmwreVlPSUFx?=
 =?iso-2022-jp?B?cC9GR0RqR3M5SEkvOFdMejcxQ2xwQVR4TFA2M054V080S1lmYWVic2Rz?=
 =?iso-2022-jp?B?RkRtNzh2Mmx1ZG44S2FZaWZGbWp6ZDJOekRrd2pyOW9Gb0ZaTHdqajJ5?=
 =?iso-2022-jp?B?ZjRpb0FqaC9aWE50eGFuSG1ocTJ3MUdVS0lYUGNDYU1RN2V1a2g5cURX?=
 =?iso-2022-jp?B?UURqTncyMTI0YVRReWthMFRtS0ppcDV6NW9KZ08rSHBWNVZONmZDRzVO?=
 =?iso-2022-jp?B?WkRibUp1TlFXaGx5UEtaWGV1ZVRQdis4eUxyVm5zWnkwV0VkYURFRlFF?=
 =?iso-2022-jp?B?ODd2M1hzaEI0UDJiN3FTODBEcWMyZ3FqaG42dVZnM1ZlanpYejAwOEE4?=
 =?iso-2022-jp?B?SmgwZENLdmVZVDJmbWZRRmhReSs4Q3lVTkN1a00wQXlhM1Y2M2Z6Zy9i?=
 =?iso-2022-jp?B?NnU5Q2s1dFdpZXh0ZWQ2dGliVkJwMU8vZlo5bHphNEZkd3lVMXB4eDJk?=
 =?iso-2022-jp?B?d0p6SUNrTURGR0M2QnptKzZTaUIwVmsySXhJSlJ1MFFQWTVCTEVKamVG?=
 =?iso-2022-jp?B?WFhEbFM2NDJRZ3pvRWo0dnMrdEY2TStpUlMzTTBwRFpmWGZTdVN2bEtQ?=
 =?iso-2022-jp?B?L1U4RHBveEhjZnVHTTUyRWRGd1VETGF3L0NPZjQ1cTBSVlhTZkxBaHRT?=
 =?iso-2022-jp?B?d1RPNEs0bXBPRFFJalpTNkx6alpadWpOYkVSY05ldThvY2pUNUdLaFN1?=
 =?iso-2022-jp?B?MENzMW82T3VwcUUxQ2llb21XdGdVSnI2WDhJek9lZ0tvckZNY29WYmhT?=
 =?iso-2022-jp?B?OVphTy85b0kzZDVQLzA0K0lGTXZPUDc2K0FrZ2hIWWp4bkMwdGdDbkJF?=
 =?iso-2022-jp?B?dnJqZGg4aUdXVStiaXE0WXQ2dVBvUGcvMGxVSlZyMFppckVRZ0hFYkc5?=
 =?iso-2022-jp?B?TTQ1WTBOcWRkWW9LMUl3WmNwRXY0VUo2NUVKZHJpb3NpVk9pMk5HU0Y0?=
 =?iso-2022-jp?B?Y09tRktIVlJld08wVWhBTjRXY1Vnazl4Z2ZVMWNTR3BjWW1JZWVmcWdB?=
 =?iso-2022-jp?B?UVMxNjFZc0pnSDFseGZWZzd1bEs1L2FOQ3FqNEVtR213a2JaOXB6Z1hS?=
 =?iso-2022-jp?B?b0hHUzN3bittZ0MwN2x4b2I4ZkxNaXJNV3o4TzRPQWE1Y1NpLzZaN2dB?=
 =?iso-2022-jp?B?MXdrZmszQ1BXUVBpd2RYVGlRUDljaitKamxzU0Z3YldUQm5xcE1zdEJH?=
 =?iso-2022-jp?B?L2lWbkIwVEZ0REZFWUliU1lhSkpiSC9vK2g4d0NzamRMWEx5dEt4L1FB?=
 =?iso-2022-jp?B?bGVBR3ZkbEM0L09haWM4ZlF3N3VQNENWUk4rclVNTE95eXhDSGUzbjh5?=
 =?iso-2022-jp?B?OEx5ZEJRcXh1Skx1ZDc2SWU2K1RZWmdYczJuc2ZDS2JOZ0tVZFgvaHQv?=
 =?iso-2022-jp?B?MU1pWEdGVnFxNHRLeDYxZW52azc5V1pmQXhMekcwOERYd2pBL1B3cDVU?=
 =?iso-2022-jp?B?K3A4bXJ4d1AwSy9tMHBiZDRlM0M3UWFFTzQ5WkZsRE9URjIySmo3Vmgr?=
 =?iso-2022-jp?B?Y282RHg1dExWYitsMjRzYld3blBLeXpVQlFPRkxOMVRTdHVVUnYxY0FF?=
 =?iso-2022-jp?B?ZitRNXE3b20welhmQk5kdSsrZXloUjhKSmFlQmxicHpsNWxrR1RsTmYy?=
 =?iso-2022-jp?B?d3dtOVFPdEt3SVFVblpBSWpaaUJFRmZzZXl2VURRRzBTcFUzcXRyNHRT?=
 =?iso-2022-jp?B?ZS9iZnpaeGFxMUV4S2xhTGVTZnJrRS9RPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Y1cxOVc0U2grc0tQSjkwTHVtZHJQT3FoMmRTaXdwakFXTGovVjl1eTNi?=
 =?iso-2022-jp?B?WDhKV0lmcXFmZXV4bGVPYUtWNVBqelViMzcvNnFyZnFDZ1hEV05jQmpT?=
 =?iso-2022-jp?B?TWYzRmlzdXI0REVnaEh1a09nempUaW5SczVSQ0w2MTEwaXBJUHBPZXJU?=
 =?iso-2022-jp?B?aFRJMENNQjRpejU0ck1IOHM3NEtmbjRWRlo3YmU5SEYrQ2czOGdhWHVh?=
 =?iso-2022-jp?B?Vm5hK1A4VHhiOTlieTBSbjNlbm5SVXJ4UG55OHFMdjhkWXowV2V1T3B3?=
 =?iso-2022-jp?B?bkxmRDVYa254eWhXN25aSVp1UHF3eFVuRTlRT0ZxNHdSUFNROHVGYlZ3?=
 =?iso-2022-jp?B?YUxtNEhhT0F4ZmU5T2g0eHliNzYvUlZLdVdBbVJSYTFGMXltemIvV0du?=
 =?iso-2022-jp?B?UC83WlU2eG5aZXp5aXN5bWRWY1FRVGcyaG9jNDI2aU1sUlVDVW5JNkUv?=
 =?iso-2022-jp?B?bWcxUHdEbXJBWklaUi82T2lGdzBaNEtIcy9NVTYyVlZuaWhmSFg1aCtm?=
 =?iso-2022-jp?B?b1pIK0Z6ZTVJYmJqbzBMWW9tb1IvWkZDTXhXZUh1cW5Mbmh1N3dQaXdK?=
 =?iso-2022-jp?B?WnVPdEV0MzB0NDlZd3dqOXNHYkthMWRLRmxKZjA3MUxNbWNPL21yYlYw?=
 =?iso-2022-jp?B?SkJERlBkaFVnMUJuRnF2aVp1MDl4NWVUS2krajI0dXlCL0RjM1lPMnhx?=
 =?iso-2022-jp?B?bHN2dHpRUHUxUUxxdCtTdmJEMGNrV3pYeTU5RmozdTdkN3VrQVE5OXZE?=
 =?iso-2022-jp?B?eTIwaUtLYVZBaGdhV2RvWEtCSnZ5bS9kbSswTVo2S3M4UlFUZjZMS0NS?=
 =?iso-2022-jp?B?Qm9EellaSURFSTkrem5DRnhiNGhHNmgxK3JRTlpyR0UrZUovV0l5Yldj?=
 =?iso-2022-jp?B?ZlFlTUMyRnN3L09reTNQcXZNTUg3U1FmNUl1a2pISTd4NzFvVzROM2hU?=
 =?iso-2022-jp?B?engvVDB6bC9mTzVTWFlncUFaL1dDWjFETUJFNzJsMzF2VWYrcjdHcmVO?=
 =?iso-2022-jp?B?Q2ZvenlMMXUyekVBdnkrbklWSDVqdVBJdjNTbkpVdWI5UyttbXpBNGcr?=
 =?iso-2022-jp?B?MjJzVkttaDVUODFrVVZUclhSdWtDcDJ3ckwyVjlVdGs3YjBEVHlYM3Va?=
 =?iso-2022-jp?B?cU5PS0JoT2ltZVFDS1ZyUnZhdkxnUWZqaGdaZ3ZSRlYwT1NNVTFpWFB2?=
 =?iso-2022-jp?B?YjdHVk9nVTJhLzZDaFZwRXc3eGtTUGVDZ2RLMVdzUU54ZTlJdTY5eXk2?=
 =?iso-2022-jp?B?bk5FbWEvZnhLK1h4TDRIcEE2a2ltTFllNVgvdFYvVEZ4UzBKQWxEUjFz?=
 =?iso-2022-jp?B?cFEzMmQ4ODVsaVEyaE9HMHhQd05ZWlIvRTFXeGpFdlBKMkxPWjB5Nk1n?=
 =?iso-2022-jp?B?SXdndTlHNkpvWi8yT2k1OEc1anRUTWFkOWZIang1NU9Bc2dPREdDdjhw?=
 =?iso-2022-jp?B?dTE4OXhDNVBjK05mQWRYaENRNkw4Q1cvVnhOSmNiL3RSOGsrZDdUN3hx?=
 =?iso-2022-jp?B?Sy9CazhJRytFQkN0dXkyZ0djOGdBakdVUTN4b0lwdmM5anA5aUJJV3Jy?=
 =?iso-2022-jp?B?VTJFeHF0M3I3dG91RDRqQ1p0WnBzWGJTdTIrRFl5VmxLTmZPK005V0hI?=
 =?iso-2022-jp?B?UWdTSFRwbCtTR3pOT214S2dvcnFnZU9WbDQzSWlZYjlXd0Z5QUh5NVZR?=
 =?iso-2022-jp?B?dTNiYmE0UnlQNFRXZDVvN0p2cDQ1a0VXaEtOZUYvaVlsMUtlU2gwVk5H?=
 =?iso-2022-jp?B?bVlCcXQ1LytTbU81VUo0YmNlMUhMUlhqQ0pEdURhTURNTzhIcUhhY3pt?=
 =?iso-2022-jp?B?WndNM0pXZkt4WHU4Wm1DRyt3dnlZdHVQNFROMGZKaFdIWlRuTkhvbms2?=
 =?iso-2022-jp?B?YmZhVHpDdlVXOVp1MzF6RThEWHc3UTVrR1VPN25ISllSR1R5V3p1SU9a?=
 =?iso-2022-jp?B?Uy9GUEl4NlBQLzNQSndBR1NmL1pqMkRYY3pMQXFUS1Izc3V4WlUyNVdj?=
 =?iso-2022-jp?B?c0tiR2xTUUFkR0RiVytzam9oVHE4UTdoL2c5cjFsTFpOUWpLb05DaldT?=
 =?iso-2022-jp?B?ZXU1YWhBamo1MmU4bDFCbk1heC8rOU9mcXNxUmxJajdneFltRnBPMGs1?=
 =?iso-2022-jp?B?bkZpUlJEVnA5S2IyeDhwL3ZVeEVFSHVMTGlqUFI5OVQxREhEWEhHTGQy?=
 =?iso-2022-jp?B?YjlhSkhqeUFiZ2FxQk1oRkZCNGI4ZUlTcW9FMWlHaGVQZ21Xd2o2TE9u?=
 =?iso-2022-jp?B?UndOSk95Y2F4K01YSC9vVGtyaU1rUldFZWZpOFk0TzRrejV1NVYxbkxO?=
 =?iso-2022-jp?B?a0Z3K1E2R3ZOZ25PWUw1aXoyMWYzY1pMd0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e2ebba-8ee2-4fda-9c20-08dd92c24181
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 08:35:17.6565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWaKZmx6XOWt7Qc6YZrLPYXARyN8TV8jbD+8sMZ9eK479QGdS1CjomzICzBHhuvV4PhgN++QHa7j2L8abOmwZG9dInA6Rh3/401/pKbJ5Ev5uM2I8mx0MV4Jg1KoUHSl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9273
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 May 2025 08:35:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18903

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, May 14, 2025 5:00 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev@lists.cip-project.org
> Subject: 5.10.237-cip release
>=20
> Hi!
>=20
> 5.10-cip-rt release is due soon, and 5.10.237-rt131 is available, so 5.10=
.237-cip
> release would be useful for me.
>=20

Thanks for letting me know.
I will prepare my release with 5.10.237.

> Best regards,
> 								Pavel

Best regards,
  Nobuhiro


