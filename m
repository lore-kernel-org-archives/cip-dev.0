Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACFECCD184
	for <webhook@archiver.kernel.org>; Thu,  9 Oct 2025 12:08:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.10626.1760011676695734021
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Oct 2025 05:07:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=QGiZn/22;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1760011651;x=1761221251;bh=
	NVq85i0Uw/tYSlzyiqP1fmcGgaRDWVTMJyZ6hDAQPEc=;b=QGiZn/22rE3dOBzppVfdM9CE0xUNPO
	nQTDj18iVmzytdA6ehtPlNOmvwM/TPzwVu/wrGozM2g2pf+giddHnY+/bjytISIIkzaWYIw0RSsvb
	kwJo9FUu+MrqaKqeQNrcmo7UtEK1HOAPS1YoZeniNQhsj6ts6Rt+Jsp0TqiXuAqC46RQyMjzRqy9j
	6Mxkj2HnLhZ/8OKAYh0iufU380X2mEer/nmPfvIQzSy/aAU7z9pjjN7ZFT5l4XrkzVFuPWDjTXnXV
	ljVoMLwtVzXEQA8w8/n7DIrELVTXW+UMggigItF1BmK7J2/nYYJgzzJknF9CZUJZcw5guiWY5peE5
	B26w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 599C7UQI3002939; Thu, 9 Oct 2025 21:07:30 +0900
X-Iguazu-Qid: 2rWhxZoCOlXhA0p3lg
X-Iguazu-QSIG: v=2; s=0; t=1760011650; q=2rWhxZoCOlXhA0p3lg; m=e+1eKvlGJbOKUFK0Y0GwmOh+NqYcIlO094Kh4enPTxQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cj7ss5CF7z4vyh; Thu,  9 Oct 2025 21:07:29 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=md9rpbRnjmjSfvXtyp4sucn7dVP9BeQY9jztHR6KHs43XDCdv/LcKmbakyx9sXYax+0RN4Xz6sWYQQLVYRBCsTUXpJyJVSbUKRys/y5WuFJR0RBO9GW1F5LrEy2OLVd5UuRxSacofs4Wt8VFKDjN+sYj//zccCB4KjAsm1PkZ48JZR1kGE443/hsPhD5Z5j7p4LHia/ZHZFyCndEp6Gng0ViZJivLrl0n4qGylcPf74v0+gpmZzgKSfpaox1JerPM+zs6c9b7EbvGJB3dcRiBlzyQeCwV3TFY54MuK7lQh0A8DH99KUS9yDh4m7VxqOBRXOi4zOrFKOUfmgGdrEaqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWZ3E39/95LNJVanyTN0zg3jPplwFWLwQVnGHtVeM8c=;
 b=DdZ4eGHPeOBTsu2U3U4acYMrDsb3DGLcqYPGAZSE9iAu8yekTSqIJWMe4QGsakdP0uklAM1FnwozeqskoyszFeURBNLoa2mdDN5Rx/7hd+yqhKLnYhSwJVEIeTUuEtIzJ52mdMblPNZevGa1KmhFfa9ygC8EvghC4JDZXa9JFNbxqpOYOlCJiSAikt29gUi8D28xyyAXAvUzf/RnY8HuBMKC18X2/sMVNRQrzCvc0hIQ6V0qZTit76Xtj8Jb6zt978bxhIRZ7ENk4rG194HpTTsPeWjhXQB/8jXwpiCgUo2kHy+wNsBw20/lB2YDotoCDxXPPf2WCS02w0mKEe5qfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.12.51-cip10
Thread-Topic: [ANNOUNCE] Release v6.12.51-cip10
Thread-Index: Adw5FTZMGZmi9fGbRXSDK//iy3+z4w==
Date: Thu, 9 Oct 2025 12:07:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148185B262CE517BB429ED7C8CDEEA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB9650:EE_
x-ms-office365-filtering-correlation-id: 4b30a147-9e0b-427d-0e4e-08de072c6a1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?T1hZMVBoMFR3RHdIaHJRcFFMWHJVN3k4Z0Z1b2s2TEZvczh3UWlVL1cw?=
 =?iso-2022-jp?B?MTVFWmVLd2h5VGZnSmZpT2I3dExKMFhJL3JBSzJGYXg1WWhoV3d3M2pw?=
 =?iso-2022-jp?B?Wk5WOGtsS1J2QjZvTTIyMUZuSTUrUmpiZkl5TFp1RDBmMjR5VG1lcmhp?=
 =?iso-2022-jp?B?U1kzQ2lpeTBNN0RnNlQrVGxwVy96aGNZNit5WEdEY3ZiRmRvbnJ0OXR6?=
 =?iso-2022-jp?B?cTRPZW95WnVUcFlNdmdHNFBYSGZhZEtCYm0yL0ZMSFlIMHVTbnhXYTVK?=
 =?iso-2022-jp?B?a1FhNXg4S2xSQUd4a0w5d1RSd2xmekUrc2hQY2tod2diVkVoUnlidVM2?=
 =?iso-2022-jp?B?dHVTQjNSWVlyVTErS2lweW5sMGdwZWlDTUFpQ09YZ3RNMVY4cGYxQnFZ?=
 =?iso-2022-jp?B?OUZOQURLN1RFSTUvODF2d0VWVWZkeDJaaFFpRThzd09aemFiODNhb3l6?=
 =?iso-2022-jp?B?clZoS1NqanZZVzl6UUxQZHVHc0NvcGhETjZ0eTdqRlpMTWtXTVdHMm9k?=
 =?iso-2022-jp?B?K1RPV3ZpUnBuczZDWFFRb3l5anFWKzY4eVJlUWZCbm1QSytnRWM1alc4?=
 =?iso-2022-jp?B?WmsyVjE1djVjMjZvbldoUllFd3JzeGV1SWpEQWZaQkk1U3RrbTdlRnRx?=
 =?iso-2022-jp?B?VFpuZlZYc0hXNjEvbk92aXBQQnBxblFqb1hTT05uRldMQ0V0Q1FiOVRZ?=
 =?iso-2022-jp?B?OEpaME16Yyt6a013dk92Yk5XMGVGWEJTWHQ3dXJQODhCdjZXZlhvMFVP?=
 =?iso-2022-jp?B?dE1uQkdwVHNLNVZIUjE2OFdEN3g4MG9aaWs5SW8xbDBTRzhjaFM0a3p1?=
 =?iso-2022-jp?B?ZC9waDdZRzlFRzlMUkg5K3prVExaUmkwT3NwMjhaYnRMMzduanhkbWJo?=
 =?iso-2022-jp?B?WDhxS1NzZGNOeFprc2h0clhXRFNaTXhrQyt4cGFId2hISVBRV0J2eCt0?=
 =?iso-2022-jp?B?dVlBSFE2dEJyUWVNeHM3OGtNNklFeENBUWQ1eFJyOFhsQ1FpcmgwMURv?=
 =?iso-2022-jp?B?YmpyMmJtbTU1L2d3VXJxbEtCNW4xbHh6SUFJTTlTOXZvdUlSaUZFRFZl?=
 =?iso-2022-jp?B?TFd4c1IxSXdmV0d5UUZMSFl0MDZuYm9WTlAwRXBCUTZLSEJvbG0zcHps?=
 =?iso-2022-jp?B?c0NtTmFWV2NET1FsQ2lWSnhBR05ubk1GcDNENG1peTc0NWR2eUpxTWp5?=
 =?iso-2022-jp?B?QjVZdjhma2tIWTY1dHlFcWZCSlI1VWlSbHBkcndwRzhBZXozeFNNY3Qr?=
 =?iso-2022-jp?B?aG5SWE84S1RzanlrdTJoK3B3dWU0MC83QkRLR2RzWEVjd2FmTjRxbHN5?=
 =?iso-2022-jp?B?dXBwUTRiU0w0NzlYcGw0UlJOS2hubWpKS2JlQ1UxNWdlbnV6Qml2TlZE?=
 =?iso-2022-jp?B?SVBOUVhpOVZpclp5c3AxWncyZ0t5SHNyamJIQTNLazBEZ1JVNWRDSlV2?=
 =?iso-2022-jp?B?RnJiTTl0QnM5SjFhYkZNYW1yWEdpcU9NQmU4b2MvWHZiYytlcDVBcUpW?=
 =?iso-2022-jp?B?UitiTzBwYlpwODdhUEhwNjA3NEVtTUJkUFlRVFVJNTR2QWd1QzNFTkhZ?=
 =?iso-2022-jp?B?RThnRlZaVDE5bXpEbEJaT3djZmhOa0VHN1lVQXFKWWF5SittTEJ2MGJx?=
 =?iso-2022-jp?B?SXg4RHhUYmJHdmZtVkE0WlpQbjRzZFlHcUZqQ2oyRCs0V3grTzlsUEFt?=
 =?iso-2022-jp?B?dFRmREg2R2QrOFo3aU4vVVZGSkQ3OTNKcWhUbGFyN3hoWlpzR0tlbFN6?=
 =?iso-2022-jp?B?M0JicjlZSkFUb29hYzFhdkJXTUtqem12bTJQZy9KN2IrUmFLcVBycFRi?=
 =?iso-2022-jp?B?aWtmdGRKZG81K0R6SHdkOXgxRzNrMS90bnZENmFIelFKWGpYUnhzT3dI?=
 =?iso-2022-jp?B?TjdkNGNDMlI1ak1oT0p3R3VSUDFOUm96V2FNOHZmbGlHakl2aVNhKzBG?=
 =?iso-2022-jp?B?akhIK2Z3a3RVajdtYk00SjBwc1RpcktDSUhiSnNsaXE5TW5FQUdjTTdM?=
 =?iso-2022-jp?B?OFZDQzh3dzUxd2wxRExHZnRxNGRrY0Z3NjNqT29RcVdOSmZ2RmJFYkNz?=
 =?iso-2022-jp?B?S2NZODY3cUhzU2krV3pTLzdYbWFXTnBhSVdjaFJWbFNoQlB6SDJ0dndH?=
 =?iso-2022-jp?B?Qk5VYW01UE5wZGpFSzNUN0o4WmdITlBwVXAzd3F6YlJMUUwvblJUWUhu?=
 =?iso-2022-jp?B?QTVqTkFTODlzckxyNjhiVnUyZnZyK1NH?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MkJWVHFOLzRId1M3eTBoVjk5QjBMRlJ4QkwyblV6NlRJUGQ1RnpOK1lW?=
 =?iso-2022-jp?B?N1JLWEdiYlJvYkdsNUFtd3VPMUNMeU5xaFVlM0srQXBxS1A3SUNYWDRj?=
 =?iso-2022-jp?B?ZWtHczJqSTVwZk1VUHlhRXNxTGd4dFQ2SmhmMG9LU0NmVVhFWWpEV3ZU?=
 =?iso-2022-jp?B?Y01HYWFwRlg4dk1WbEFiRmNjOERRMk1yWGszb3pVTmc5dEpMeVB0NURR?=
 =?iso-2022-jp?B?VnRmQkdXcVFzeVBDQldlWEc2eDhjRGF3QmExVFRtenZxd2N4V0FzUXdz?=
 =?iso-2022-jp?B?aDd4ZEpIaTRUNFh1QVRoaGVDQi8yRTYxVXNpQnpmZUVMVTZiSlN2dHVG?=
 =?iso-2022-jp?B?OUNnSHo0bVdyOGVNenl5a3VtTkVzTHoxNTlzbG9uSldGRXhsMDM2eFJY?=
 =?iso-2022-jp?B?UktuZ2tVSWNTekRCSlF1S3ZrUEFyelpCM0NXVEtQV2t2Q0ZQaVV2d0ZH?=
 =?iso-2022-jp?B?Ykg0WHNDVzJndVRGRG9MYzZocDJJdG44eFdlclFFcDlLZDUzUFZ5Wmx3?=
 =?iso-2022-jp?B?Tlh6SmwwWnFBc1FmdDFhVEZ1UW5ndzh5bkIrbkMybytmZ2c1RkNDWk5D?=
 =?iso-2022-jp?B?YVVwYzdaS3hnUFVWL0RLdGhoUTBFYnNFU010TFFMNlZ5Zy9Bc3JMaHJh?=
 =?iso-2022-jp?B?UHRuMVJaNy9zbzNmVmFoNVM4WVJxWk1adklIQy96RUx6bjJXRHFnYzE0?=
 =?iso-2022-jp?B?Q2JLOXFDTUZTb1diRkFPMk1nYjVNeVBxYXplZWl2cFk3Sm9WTGoyQ0ky?=
 =?iso-2022-jp?B?Q3YxMkV3YlF2QmxrVUxPUGhzbExMQlhMcmJxMU9NQTAvL1lTTzZlR1cy?=
 =?iso-2022-jp?B?OEFHd2NlWlhVZllzYUcycHFrSXp0UDZPV25udG9STHdUTEdNcDVqVnRW?=
 =?iso-2022-jp?B?ZnlEQ0NTUlZrQTJ2M2dlc2FqU2NvQU9kN1I2UTRLekJYeWdpSm90SVpo?=
 =?iso-2022-jp?B?VW96S2N3VHJSWHZjODRiRHROZlpiSUZLazVhbjkxMGt6TXIwVDZCQW1z?=
 =?iso-2022-jp?B?N25aQUNSN0JsVWRDUkMxUnl3cnM3NU00M2RDUFBrNWhHdUw5WGw5R0s5?=
 =?iso-2022-jp?B?QzkzampNTUNPN0dIZ0pDWVpLRno3bzFLenVncDhiTkViVkE3NVFxd1lP?=
 =?iso-2022-jp?B?eXREd2JSSVE4clVLQTl4bkJialdGQkJ0MGtPRFJkK3lCK01HV1RZUU9a?=
 =?iso-2022-jp?B?Vk9tbmJjeE1YVjVZS09kck9IWXAxUzlwcHpTQXgzV1BEZnU4RVpnWnd5?=
 =?iso-2022-jp?B?OWgraTRsNmpCN25ldnJaZDh5MWF2SnQ0NytCZzJEMmdRZnNsanJjalpI?=
 =?iso-2022-jp?B?UmcxM3lITjcza05RbjVNaytiVUhLR0orL0Vyd0taMmpNTnVsdzJGOGpw?=
 =?iso-2022-jp?B?bDIyK3ozR2tsS2RKd2RsZXV5VDdwOTNpS1FsYU94ODZDWG92V2pTSjk0?=
 =?iso-2022-jp?B?OVhoa2pSTExoRmV0UGVkK2pEZzdGNHFvUWpOWjFTanl2eVdWeGhGdUhT?=
 =?iso-2022-jp?B?NXN2OEtkQkt4bFFZUzNxN094bW5BSlo5clcxeHY3N2Vrd0RYWTAwalZT?=
 =?iso-2022-jp?B?Vk8yaWVHUndSUlkvNDhOcko0MWlFNURqTTN5bWZFUkt1bHBTTm45QmlW?=
 =?iso-2022-jp?B?TmZ6dXZRQ1ZSMVJwVUUxNFpmQzgzTjU0d092N2xMR0ZiRFEzY1FhU2pl?=
 =?iso-2022-jp?B?QzFxdUxEdTVoZG9XYlVyNmQ4M2h1S3M4dUwvRkFIVU1iMmVhd0JHemUr?=
 =?iso-2022-jp?B?R2JqdXJxYXd3clBNUGU1VnVjZzQxQXpOa3JYckM2VkJyTXpZL2NNanRt?=
 =?iso-2022-jp?B?TURlNlhjeVEzT0VUUVhoVG8rdFdEMlFFY2JOL1lFenpoaklETFNna2JU?=
 =?iso-2022-jp?B?cVFlbW9rYnppUFVCRndmUCtrejU1ZnRkUFlyNXhpLzRBRzN5SkV6VmF3?=
 =?iso-2022-jp?B?M1RjK2RyNVpMTkxzeWw2Nmp3QnZ6a08wa2E1bzRTczg1ZDF6c1JmL0hs?=
 =?iso-2022-jp?B?WXJZZndZSkFhTVlnRnhaSTlNYVNYREw0NTBCZTlNTVZldUhJcjlRcmlV?=
 =?iso-2022-jp?B?blkyaWRKaldHRFJYRXQ1TGxnQWRYeVRaZUpMUDhIM0FKQ1Q2ZWRObE9t?=
 =?iso-2022-jp?B?QnFiTmo0NHQ2MGNIUlJDSFdrZ3IvS2NSOGl6YjA5WUlPL0NqYld0bzg1?=
 =?iso-2022-jp?B?ZjB6WVF2SEF6VmliQWpLZTNDWDM5cFl4eVErallaK3pVL2tJVE16ZHdU?=
 =?iso-2022-jp?B?eW9sYWUvN1hMSGI2bVV4dms4d20xbjVjRDQ4dG14ZElVMjZVMGl2QVZv?=
 =?iso-2022-jp?B?c0U3cVFuSFA3OFR0bW5wOXBiNlBuQ0NiTEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b30a147-9e0b-427d-0e4e-08de072c6a1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 12:07:27.3484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTnngQ9Ou5ezN6tkR5beSzKNe02KfTpAFjJcNDDYTMn2SpPTK/x5faF4BjNwMqNbff1ioz+BG7P5tm4t+6FNkFZWOEEf3K0AuAUsWwnYx9hcTcUz3I1ZqP07ri7nJCkt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9650
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Oct 2025 12:08:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20165

Hi all,

CIP kernel team has released Linux kernel v6.12.51-cip10.
The linux-6.12.y-cip tree has been updated base version from v6.12.48 to v6=
.12.51.

Information about this release is as follows:

  v6.12.51-cip10:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      9ca012159eec014224e8e4f20c982956741f7ae5
    fixed CVEs:
      CVE-2025-39946: tls: make sure to abort the stream if headers are bog=
us
      CVE-2025-39952: wifi: wilc1000: avoid buffer overflow in WID string c=
onfiguration
      CVE-2025-39948: ice: fix Rx page leak on multi-buffer frames
      CVE-2025-39950: net/tcp: Fix a NULL pointer dereference when using TC=
P-AO with TCP_REPAIR
      CVE-2025-39816: io_uring/kbuf: always use READ_ONCE() to read ring pr=
ovided buffer lengths
      CVE-2025-39929: smb: client: fix smbdirect_recv_io leak in smbd_negot=
iate() error path
      CVE-2025-22106: vmxnet3: unregister xdp rxq info in the reset path
      CVE-2025-39951: um: virtio_uml: Fix use-after-free after put_device i=
n probe
      CVE-2025-39937: net: rfkill: gpio: Fix crash due to dereferencering u=
ninitialized pointer
      CVE-2025-39940: dm-stripe: fix a possible integer overflow
      CVE-2025-39953: cgroup: split cgroup_destroy_wq into 3 workqueues
      CVE-2025-39932: smb: client: let smbd_destroy() call disable_work_syn=
c(&info->post_send_credits_work)
      CVE-2025-39944: octeontx2-pf: Fix use-after-free bugs in otx2_sync_ts=
tamp()
      CVE-2025-39945: cnic: Fix use-after-free bugs in cnic_delete_task
      CVE-2025-38322: perf/x86/intel: Fix crash in icl_update_topdown_event=
()
      CVE-2025-39949: qed: Don't collect too many protection override GRC e=
lements
      CVE-2025-39931: crypto: af_alg - Set merge to zero early in af_alg_se=
ndmsg
      CVE-2025-39938: ASoC: qcom: q6apm-lpass-dais: Fix NULL pointer derefe=
rence if source graph failed
      CVE-2025-39934: drm: bridge: anx7625: Fix NULL pointer dereference wi=
th early IRQ
      CVE-2025-39943: ksmbd: smbdirect: validate data_offset and data_lengt=
h field of smb_direct_data_transfer
      CVE-2025-39947: net/mlx5e: Harden uplink netdev access against device=
 unbind
      CVE-2025-39942: ksmbd: smbdirect: verify remaining_data_length respec=
ts max_fragmented_recv_size
    added commits:
      CIP: Bump version suffix to -cip10 after merge from stable

Best regards,
  Nobuhiro


