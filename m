Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847B8C35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 13:46:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.8241.1742391962552150642
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 06:46:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=GTjisCqO;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key3.smx;t=1742391938;x=1743601538;bh=vV
	PRvX+v6sF/r/f2QRIiaOgteWMdPyrPxyGe0QFY58c=;b=GTjisCqOthW1mn/xikW2uta78VXfy66+
	jHilpBy0mO627kvQr4Lh+sHTKpAsequDnM2e+Mb3TdazsXZFlqLWbIB/3XprcZ1aFaIiVa6pNB+ai
	MQTox5Q5ZVls/lkdOIAv+3oKx5IML61/pItFFkOpiftnlWy++fokXxmUrHjm7H6VO164pu0I2YQ5T
	s0/nO3WzSVXt6Pxqu7dQqVgvex772FuzAgB67jK5Q+apeexguaSs+FVsAAhiI66CYb9SxMAe5IoZk
	VFIF5lu8mkdN8twiHoXBKD2GOnT1UZcaUU0vU2XDBrhIR3xEMKFz+qj/TSbcgnNBl0Mmp6njT4xmp
	lw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 52JDjbA5227227; Wed, 19 Mar 2025 22:45:37 +0900
X-Iguazu-Qid: 2rWhqikydoqEmvMvFR
X-Iguazu-QSIG: v=2; s=0; t=1742391936; q=2rWhqikydoqEmvMvFR; m=1KJvdKDTuHdoDWjUHZUmGrW+uoSw+fDbrqNJVr6Trug=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 52JDjY9r3170447
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 22:45:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gF8rZYLIfQH3R2v92cbq5TXw5iCog38+yRUSeM0BSZNPfwApoRMgPodL0LYR2EDcVBz2jrFP3ETnximmcXkcuDY0U/bhPn0MC4uJJBRsA6DAhZxYQFO14Uq9rnPZpjEym6e9l/c8N5ZDciSBOYApsiwFm9P2zn8d2ZTigqnJ9+FhMgD8TtuzGVhRi4XRovUin7irzO+AfcrpnEvo6BSQW4eEnBrWdCu3c3pLJVSvJDx8B+Wd/0ZeIH/+Ep9oPCePzULPGpyeqKG7/CFgaCirZVy44Z3IdhQTDQ++5RpdQm339JTQrkw0d5ZK4yRkKAVlTONgEGfgs1PhZ4ZT2+IUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6jun6GhDn5pMtm5rJUopYklCUl+tn77JLW0CwkNvds=;
 b=Vkzp19335X0/i6fAtEsV8PDC23uCVbJcuZZyJx381kqvgu+L1g+I9Zt0V7u/Wxx1yTL6v9CzBcOOZ510VzHKBRAXZkgBjKWAPwq2zNu4a2jriPYvFW0sECdvkvBPqxueF4LBfYDxoQhDu3hA365z+IRutlpIT8s4qgo+SIQZ5ObMXytwErhlaOQeHoqEHDAW2KcfbzIeqf8UhRtXXn7kWZBmQuf/uV85k0/P51XSvxnwiaoin07uFotwBTJCq80iD57H6naCCsCQy4crrY7kogUaxBhitX7M2AU0rdUmfDBz3/uCtLCvj76B3+raJ2wZ4+kL5VY2RP8qYev7zmEdXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <Chris.Paterson2@renesas.com>,
        <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v5.10.235-cip58
Thread-Topic: [ANNOUNCE] Release v5.10.235-cip58
Thread-Index: AduY1MY6Vqt6z79LStyq4zBLVqjFnw==
Date: Wed, 19 Mar 2025 13:45:31 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148181DF2BFED25388AD8A2F492D92@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB5782:EE_
x-ms-office365-filtering-correlation-id: bdcf2208-d765-404c-eed0-08dd66ec50d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?TWhPcXVHazMyaDJlREF6T2cvZzg2S2RjWGJNQmZsdmRNOURJb2wyZHJD?=
 =?iso-2022-jp?B?Z1pvNVRjb3lBd0xSMlpaNUNkckNVaVdCNVU0NXcrQzNnOUpsUkZFTFJC?=
 =?iso-2022-jp?B?WDJmTzJtc2VTQVh3MVhqaWJYeU5JSzIvZnVIcTJVcU9xK04xY21UNGt4?=
 =?iso-2022-jp?B?emVGS2lLRWRMQ1Izd08rS1d4ZUEvK09VdEpkc3REWVhwV3Q5V0RrOExu?=
 =?iso-2022-jp?B?SWg2NzVrSDVuMXBiOW9aQzBROUFidFdFbmxCblpvc01nVVowa3BUNlhq?=
 =?iso-2022-jp?B?VlErMUdkQk1uSGRJaWFUV0wyTU9HOGhQTE9QRHFScHBGN0U5MWV5N284?=
 =?iso-2022-jp?B?YUZwOUFtMWxQRytJVEdXWlJ4c3JoUW1vRDdXcTdiaWpYeTVFeHNtYUF5?=
 =?iso-2022-jp?B?SzJnUFZ0bE93b3ZnYXlrdUprWUkyWDRzMWVMeVVjK1JqblNUMFgrT2Q0?=
 =?iso-2022-jp?B?RVpQbVZYVnNVdVBMWDdaVHFYVEx5R3N5VjI1dGhkZU1jQmVBOEdMZnhs?=
 =?iso-2022-jp?B?UUJEUEZuaDhrblFMcUZBVXZnVVNiV29XUzdCU0xyWVZJSzFaTENlVUtN?=
 =?iso-2022-jp?B?SHdQblU5WmE4STVNRUpEQnNVT1VKdC9DVnR2akZlWE5hTURxOXVYUVpC?=
 =?iso-2022-jp?B?UkJ0Q2o1Y0NVRzNUaDJZek1NdXlkTms0dW9sYzhpeWs4bUdWUTNpck83?=
 =?iso-2022-jp?B?bGRYb3RjYytMa3RMMGYrYW5TNnBieFFNb29yV3lCTGRnbXBGdHNkWnpq?=
 =?iso-2022-jp?B?MExKNTVQVjNsWGZydWRJN25JZTJmSUxrOUtqZGtqUXBObTVGNzVTT0pC?=
 =?iso-2022-jp?B?NDRkRExvSmNhR1p4TWZCR3NzN0VwMWQ3M3ZqbHp1ZUNBU0NsandLK1VH?=
 =?iso-2022-jp?B?Rk5lY3F1QXBuSno4TXBTYUJwbjJXMGhUcDZCTDV0dGtLVXZEdzVHc2Zx?=
 =?iso-2022-jp?B?dWdueXo3ZHlQb1FKMnE3RnZXUThZTVlxbXZhaGMvdEtZMWY2UTBLYXZi?=
 =?iso-2022-jp?B?eERXUkwvYnB2ZkR0bi93eGFFdHdOZlNhZEFFdE5qVDZHckpoak45WTJL?=
 =?iso-2022-jp?B?bTQ3VnNXa01qWWg4VXlhV2F6eDFpMERmQThHTzJtNTJEUlluV3RldnZI?=
 =?iso-2022-jp?B?M1BnTVZRaExkVVg3WWRhcm9jbzFpcDhVYlF4eEhPMGNDNStqYkQzUERW?=
 =?iso-2022-jp?B?K0NHYmIwdjFvNFU4VzJudG9oTUdrZ0hnVkpPQTRLSm9RejI1cDdyVEhq?=
 =?iso-2022-jp?B?RFA3SnV4UFhoMkRTWitCVE1CQ1BaZUFrNU8zNE1tNWZmblpiUWxta3NV?=
 =?iso-2022-jp?B?VXNETkVrMnRxdUJjcVYrNzNiRnA3S0xnOEdacUxzQ3RCV0pVajNlZ2I5?=
 =?iso-2022-jp?B?N3YvY3daUUtiWEVZWVZra2JDTUVVbEc3a0xEc3BNaEVyQjBadGxNcTlZ?=
 =?iso-2022-jp?B?UTVRNS9TZi80N0hVZkEzdDI1alhlMFNCUUxLK0dOaXAzTmJvaGNlaE1a?=
 =?iso-2022-jp?B?aGVHZmJMNSs3S05YZzBjb3l2UWpBaW10UG1EbmEwTGcrbGJRWkZiTUE0?=
 =?iso-2022-jp?B?bnJqZ3VEemRDQUgvaThwRjdUanYzMUdUb1dvb05FL2NxQnZ4UEVqdVZY?=
 =?iso-2022-jp?B?K0RRbU95N1lWVHBHUFZLMzA5L0d1ZzdIU1VIQnZJcVhGLzlkWmlmMTE1?=
 =?iso-2022-jp?B?THk3eFNuTDNaZ0JpaVNadktteEdJYW50ZURhcUczaDRzWjlVWXdmWVo2?=
 =?iso-2022-jp?B?L1U2UXVJSkRGSkJtWjRTeXpUcXNaQ0JzK3duZWUrQ3hFOHB6UHYzR1Z3?=
 =?iso-2022-jp?B?cCtMODNYZlZqZHNOQnZ3bUEvaXlONC9GYVE0YzhORG4yOHYrUHR3b1lI?=
 =?iso-2022-jp?B?bEVNUkpEZWFPTTBHZVJuZDdGRjhlSm12YjAzeE1iRmtBZlVJTmFIcnBR?=
 =?iso-2022-jp?B?WUFXN2gvZUNXQ2dwNG03L2xJenNhclQvSi93NzRyVmYvZUlhdEgwTGpF?=
 =?iso-2022-jp?B?OE81eHJrQ1FvYjR5a2IrVTBnR0tEbi9zSWcwOEtEOVpFdWFIM3duSzda?=
 =?iso-2022-jp?B?M09aczBteTVRQlQ3K0JnNmhjVVVoa0VCd0dlMVN5bnFpeklGUENRbFIy?=
 =?iso-2022-jp?B?RlNlUG5TcHYzNEZaeitkWHRTVE1qaVF3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SGJKNW5tL3MzK0dHZ0x0Sm04N0VpRlhrZTNpdWlyYnFndkxhZHd4R2hp?=
 =?iso-2022-jp?B?SnJjYS9CVXBINGxWSWtVZVAzczZYUTVDSG5tMVIrNmlabExvTmVzUHdL?=
 =?iso-2022-jp?B?V25IVzBNOGZNcXBCNzlWSysrQkhYQjVRYVR5OG1CL2NzdFUxY3lOSzVy?=
 =?iso-2022-jp?B?MTVRT2w4M0hFcVRaeWRVTHc4bktBdEZBUGFaVFk1dkExK2ZvTHZpWVVP?=
 =?iso-2022-jp?B?WkwvQldvS0xkNklHaUtJL0R2THV4a3oxT2pTODY2cHc1M3hEZHNCV2w3?=
 =?iso-2022-jp?B?UkxQTWhvVWVjWmxCY2VCdGduMm54aE1KMFNFZExYSTVaeEtwYmJielBo?=
 =?iso-2022-jp?B?Y05VK3RTbnRzYk9ZSWN2UXNSR3pmeEFOVWhNSlBzajV2dEhwR0prcFlw?=
 =?iso-2022-jp?B?MVdnYTFiVzNRdForelI3d2NCRXRJV3lQbHIwdnptVWtLMGRVTW54RjBF?=
 =?iso-2022-jp?B?bVpUUnNHNHcxQ0t5YmpkdC9HQkdNR0dKMDBZYk1hNDVxTFJHRFNXQm9Y?=
 =?iso-2022-jp?B?elh3YWtrcG92SEh5cUVNZGhLcWJKTVVrMzVrcTBpVngyN2RVVk40V2ZZ?=
 =?iso-2022-jp?B?M3NJVFJ2dHJEQWIvS3pVUDhSSmh1QVFSOVBmVW40Z1NqZHFjOE0zYk5C?=
 =?iso-2022-jp?B?b1V1dk1UbCtZZWxYcEZQU1lyU1prSGlRSDUxbG5yVjhxak02dm5qNmx1?=
 =?iso-2022-jp?B?ZHRabDhJRG9vc05lY3JhUysyM0tNbnF0RzdxbkR2Z1ZSbU5EZEwybDBQ?=
 =?iso-2022-jp?B?YmV5bWVuNGZRVWcySmRtckJ2SzlnQW9RSlRuYkJVVXk0dFhyTVN6LzM5?=
 =?iso-2022-jp?B?RXdjNWxZc0FmOUNDNzFIWEFOQk1TdlYzUURDSVdjalFaYTJwZW1XM2h5?=
 =?iso-2022-jp?B?VUYrL3cwckJ5T0tWcUpSMnZNa0JleEF5NlJCQ0VkOUNXM0ZaRWVHZmNP?=
 =?iso-2022-jp?B?d3JDSDFmMC91SWNFVWpqdTNLYmV2TFdhVERnTjJqbzVRQWdacVA3K3VH?=
 =?iso-2022-jp?B?SmpOcFMzU0VXY3FDYzFqZ1RtZVFMd3MrSU1MYmxrdFJZU1lzMVdON3JU?=
 =?iso-2022-jp?B?ZnNoOCsvTHZQdFQ1OHpXMUZ6M3JhRms4Y0FEanNlYytGQlFReUVLd21q?=
 =?iso-2022-jp?B?Q09IRVNRbjdobWNsTkcwZUpzcTdjN2ZPdGVZMVorVjQ3QVZrcDZtMW5H?=
 =?iso-2022-jp?B?c3NXK1l0bUx1MHVDVWVQRVFNamNtOXB1SmJaNFFLbUtMN1ZTYTR6STl6?=
 =?iso-2022-jp?B?c1RHQkIyUTlsc3R3bXF6bnV2VlRBcTVmb0d1NWVjV05mc3kvV3BraHk2?=
 =?iso-2022-jp?B?aVdFbnlOWEZzNUc5WmVMQ01lSkd3cGw4Q2dEK3Q0WWdycXJnOUJPWXRq?=
 =?iso-2022-jp?B?WDQrK0VrRnMrWER5L0VrZDl6M1FnY2lqVUJYYnRpUElhNmdaSkZBREVH?=
 =?iso-2022-jp?B?NVYveTUrTTluWVZuUWlrN0ZzMGdhc3RybWRucUMvWjAxS05kdlhhMTRN?=
 =?iso-2022-jp?B?KzF5WHpXMkt5czRZUldTc2U2bE9FUFZUNWdtYjB0eDN0Um1Mejd5Smgw?=
 =?iso-2022-jp?B?ekV4MXFzQmd5MkV1N0JsVEM0SDF4NEo4NW9OQUtKZ1JLbUgrSlE0T0FT?=
 =?iso-2022-jp?B?MURiaWlobHd0cUNiM2pEemU5eUQ4MWJ4RkEvVmxwSmQzbzJQWXliUy93?=
 =?iso-2022-jp?B?Qy82SFB0ZDhlQ2FnZngwRE05MnUvaWt4WVh3SlR4d0RSTUtJR3M5N3ZJ?=
 =?iso-2022-jp?B?Y1c3M2RWYzEyNHF2dzNMb3NwOWEyaFdvVkltdUZ5VjJnL1hycHlQdGNL?=
 =?iso-2022-jp?B?UW5QNWs2cWtLSURYZ3hoU0hkejRxbWtzcFR4cEp3ZlFZemtyZm90L3JH?=
 =?iso-2022-jp?B?SFFTSHNmdnF3bHI1dGNKSDdpZTg2V1o0eVo3WVJEa2NsYUdtc3JadjVS?=
 =?iso-2022-jp?B?TUlpQ2VwelB1UkRzVHd6azk3bUtzWUpkK1FOTkFWRldhZlFOTjdhOTg2?=
 =?iso-2022-jp?B?M3pCYThHZzJFWVJTTlNxTkIxK3FxNWM2YjhXaUZ6T08rREo4RjhkVFND?=
 =?iso-2022-jp?B?WUhGQXBmZmJOQ3ROeUlSUEloZXBGcFJ3QWYxQWRqVzMwUU04SEVHRkZV?=
 =?iso-2022-jp?B?anZxSVRzdzlKODFMS25UYUtYendoc3NEYlV3VlBXZHdCQnA2bWNQQlg4?=
 =?iso-2022-jp?B?aFIvT200YW9pVHJ6ekVhWUUyU2x4VkxRNXVoWWhzL0d0ZCs2SjFyMUJW?=
 =?iso-2022-jp?B?VWU4RGtUWkVwV0VoRnRxWWFWMG81YmVmUk1YS2VlQlFDM1VlOW1GMEdD?=
 =?iso-2022-jp?B?bGdhQ0VuR2xicXpwb0I2Z2lEL0NmTVRBdXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcf2208-d765-404c-eed0-08dd66ec50d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 13:45:31.0793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HL5f3xKsmJz2ns1C0E9lULxd91klnbh9MLYELbWxUXcqEg4fTESG1LOvlDWNvqKu2MEQbOScIqG291gvkEivGw+i/0KJaX7suPvRCUBlVNEk9Df48+XWdTjiDjqXNzvQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5782
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 13:46:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18278

Hi,

CIP kernel team has released Linux kernel v5.10.235-cip58.
The linux-5.10.y-cip tree has been updated base version from v5.10.234 to v=
5.10.235.
And this release applied fixes for ravb ethernet device on Renesas ARM SoCs=
.

You can get this release via the git tree at:

  v5.10.235-cip58:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      8d46dd408e190ac3aa377d4136d2beebc37c7d46
    fixed CVEs:
      CVE-2024-26982: Squashfs: check the inode number is not the invalid v=
alue of zero
      CVE-2024-39494: ima: Fix use-after-free on a dentry's dname.name
      CVE-2024-47726: f2fs: fix to wait dio completion
      CVE-2024-47730: crypto: hisilicon/qm - inject error before stopping q=
ueue
      CVE-2024-57834: media: vidtv: Fix a null-ptr-deref in vidtv_mux_stop_=
thread
      CVE-2024-57973: rdma/cxgb4: Prevent potential integer overflow on 32b=
it
      CVE-2024-57977: memcg: fix soft lockup in the OOM process
      CVE-2024-57979: pps: Fix a use-after-free
      CVE-2024-57980: media: uvcvideo: Fix double free in error path
      CVE-2024-57981: usb: xhci: Fix NULL pointer dereference on certain co=
mmand aborts
      CVE-2024-57986: HID: core: Fix assumption that Resolution Multipliers=
 must be in Logical Collections
      CVE-2024-58001: ocfs2: handle a symlink read error correctly
      CVE-2024-58002: media: uvcvideo: Remove dangling pointers
      CVE-2024-58005: tpm: Change to kvalloc() in eventlog/acpi.c
      CVE-2024-58007: soc: qcom: socinfo: Avoid out of bounds read of seria=
l number
      CVE-2024-58009: Bluetooth: L2CAP: handle NULL sock pointer in l2cap_s=
ock_alloc
      CVE-2024-58010: binfmt_flat: Fix integer overflow bug on 32 bit syste=
ms
      CVE-2024-58014: wifi: brcmsmac: add gain range check to wlc_phy_iqcal=
_gainparams_nphy()
      CVE-2024-58016: safesetid: check size of policy writes
      CVE-2024-58017: printk: Fix signed integer overflow when defining LOG=
_BUF_LEN_MAX
      CVE-2024-58020: HID: multitouch: Add NULL check in mt_input_configure=
d
      CVE-2024-58051: ipmi: ipmb: Add check devm_kasprintf() returned value
      CVE-2024-58052: drm/amdgpu: Fix potential NULL pointer dereference in=
 atomctrl_get_smc_sclk_range_table
      CVE-2024-58055: usb: gadget: f_tcm: Don't free command immediately
      CVE-2024-58058: ubifs: skip dumping tnc tree when zroot is null
      CVE-2024-58063: wifi: rtlwifi: fix memory leaks and invalid access at=
 probe error path
      CVE-2024-58069: rtc: pcf85063: fix potential OOB write in PCF85063 NV=
MEM read
      CVE-2024-58071: team: prevent adding a device which is already a team=
 device lower
      CVE-2024-58072: wifi: rtlwifi: remove unused check_buddy_priv
      CVE-2024-58083: KVM: Explicitly verify target vCPU is online in kvm_g=
et_vcpu()
      CVE-2024-58085: tomoyo: don't emit warning in tomoyo_write_control()
      CVE-2025-21647: sched: sch_cake: add bounds checks to host bulk flow =
fairness counts
      CVE-2025-21700: net: sched: Disallow replacing of child qdisc from on=
e parent to another
      CVE-2025-21702: pfifo_tail_enqueue: Drop new packet when sch->limit =
=3D=3D 0
      CVE-2025-21703: netem: Update sch->q.qlen before qdisc_tree_reduce_ba=
cklog()
      CVE-2025-21704: usb: cdc-acm: Check control transfer buffer size befo=
re access
      CVE-2025-21708: net: usb: rtl8150: enable basic endpoint checking
      CVE-2025-21711: net/rose: prevent integer overflows in rose_setsockop=
t()
      CVE-2025-21715: net: davicom: fix UAF in dm9000_drv_remove
      CVE-2025-21718: net: rose: fix timer races against user threads
      CVE-2025-21719: ipmr: do not call mr_mfc_uses_dev() for unres entries
      CVE-2025-21721: nilfs2: handle errors that nilfs_prepare_chunk() may =
return
      CVE-2025-21722: nilfs2: do not force clear folio if buffer is referen=
ced
      CVE-2025-21726: padata: avoid UAF for reorder_work
      CVE-2025-21727: padata: fix UAF in padata_reorder
      CVE-2025-21728: bpf: Send signals asynchronously if !preemptible
      CVE-2025-21731: nbd: don't allow reconnect after disconnect
      CVE-2025-21735: NFC: nci: Add bounds checking in nci_hci_create_pipe(=
)
      CVE-2025-21736: nilfs2: fix possible int overflows in nilfs_fiemap()
      CVE-2025-21744: wifi: brcmfmac: fix NULL pointer dereference in brcmf=
_txfinalize()
      CVE-2025-21745: blk-cgroup: Fix class @block_class's subsystem refcou=
nt leakage
      CVE-2025-21749: net: rose: lock the socket in rose_bind()
      CVE-2025-21753: btrfs: fix use-after-free when attempting to join an =
aborted transaction
      CVE-2025-21756: vsock: Keep the binding until socket destruction
      CVE-2025-21760: ndisc: extend RCU protection in ndisc_send_skb()
      CVE-2025-21761: openvswitch: use RCU protection in ovs_vport_cmd_fill=
_info()
      CVE-2025-21762: arp: use RCU protection in arp_xmit()
      CVE-2025-21763: neighbour: use RCU protection in __neigh_notify()
      CVE-2025-21764: ndisc: use RCU protection in ndisc_alloc_skb()
      CVE-2025-21765: ipv6: use RCU protection in ip6_default_advmss()
      CVE-2025-21767: clocksource: Use migrate_disable() to avoid calling g=
et_random_u32() in atomic context
      CVE-2025-21772: partitions: mac: fix handling of bogus partition tabl=
e
      CVE-2025-21776: USB: hub: Ignore non-compliant devices with too many =
configs or interfaces
      CVE-2025-21781: batman-adv: fix panic during interface removal
      CVE-2025-21782: orangefs: fix a oob in orangefs_debug_write
      CVE-2025-21785: arm64: cacheinfo: Avoid out-of-bounds write to cachei=
nfo array
      CVE-2025-21787: team: better TEAM_OPTION_TYPE_STRING validation
      CVE-2025-21791: vrf: use RCU protection in l3mdev_l3_out()
      CVE-2025-21795: NFSD: fix hang in nfsd4_shutdown_callback
      CVE-2025-21796: nfsd: clear acl_access/acl_default after releasing th=
em
      CVE-2025-21799: net: ethernet: ti: am65-cpsw: fix freeing IRQ in am65=
_cpsw_nuss_remove_tx_chns()
      CVE-2025-21802: net: hns3: fix oops when unload drivers paralleling
      CVE-2025-21804: PCI: rcar-ep: Fix incorrect variable used when callin=
g devm_request_mem_region()
      CVE-2025-21806: net: let net.core.dev_weight always be non-zero
      CVE-2025-21811: nilfs2: protect access to buffers with no active refe=
rences
      CVE-2025-21814: ptp: Ensure info->enable callback is always set
      CVE-2025-21818: [REJECTED]: x86/xen: fix xen_hypercall_hvm() to not c=
lobber %rbx
      CVE-2025-21823: batman-adv: Drop unmanaged ELP metric worker
      CVE-2025-21826: netfilter: nf_tables: reject mismatching sum of field=
_len with set key length
      CVE-2025-21835: usb: gadget: f_midi: fix MIDI Streaming descriptor le=
ngths
      CVE-2025-21844: smb: client: Add check for next_buffer in receive_enc=
rypted_standard()
      CVE-2025-21846: acct: perform last write from workqueue
      CVE-2025-21848: nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()
      CVE-2025-21858: geneve: Fix use-after-free in geneve_find_dev().
      CVE-2025-21859: USB: gadget: f_midi: f_midi_complete to call queue_wo=
rk
      CVE-2025-21862: drop_monitor: fix incorrect initialization order
      CVE-2025-21865: gtp: Suppress list corruption splat in gtp_net_exit_b=
atch_rtnl().
      CVE-2025-21866: powerpc/code-patching: Fix KASAN hit by not flagging =
text patching area as VM_ALLOC
      CVE-2025-23126: [REJECTED]: x86/xen: fix xen_hypercall_hvm() to not c=
lobber %rbx
      CVE-2025-23127: [REJECTED]: x86/xen: fix xen_hypercall_hvm() to not c=
lobber %rbx
      CVE-2025-23128: [REJECTED]: x86/xen: fix xen_hypercall_hvm() to not c=
lobber %rbx
    added commits:
      CIP: Bump version suffix to -cip58 after merge from stable
      net: ravb: Add VLAN checksum support
      net: ravb: Enable IPv6 TX checksum offload for GbEth
      net: ravb: Enable IPv6 RX checksum offloading for GbEth
      net: ravb: Simplify UDP TX checksum offload
      net: ravb: Disable IP header TX checksum offloading
      net: ravb: Simplify types in RX csum validation
      net: ravb: Drop IP protocol check from RX csum verification
      net: ravb: Disable IP header RX checksum offloading
      net: ravb: Factor out checksum offload enable bits
      net: ravb: Fix R-Car RX frame size limit
      net: ravb: Fix maximum TX frame size for GbEth devices

Best regards,
   Nobuhiro



