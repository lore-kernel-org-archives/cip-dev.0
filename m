Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24C0C282D1
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 05:54:20 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.5979.1741240452116396386
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Mar 2025 21:54:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=i8wu7AYR;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key3.smx;t=1741240449;x=1742450049;bh=fMaYe9wnHz0TsaVq8/lEbgtZl86/G3LPvZ5uL9Q
	ceB4=;b=i8wu7AYRQWYcr4lxWFyOQZPXepoxpxjr6TsJl1e3zz+VF9DG92RFHFZxbt1r9WbaitH1Z
	S3UTmNoxwv5HC7drDrfS8dpiZy8lcNLngxqGZC5eyqy6FkhT6cTz9c2ZZQP2gp02FSiWk3MED4do0
	Mt7sQ09dEdXNLUOQ2KQo/k5brb/N42tWkoE4Tsj5BJ/bk5iBj1OFOmA5IOdG5TxJJXYgHg2OyxSKd
	VpfFyb4arC11n9ErzngSDFbYx5/P5XU2kSk0GbLLdR+OlIJamLlAk/GlySfBn83xCLfGeF11VSla/
	+8wYAB03DRm14AsVRInQ/y71+FoYI5ZlqWaXECjgBg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 5265s9DR4043443; Thu, 6 Mar 2025 14:54:09 +0900
X-Iguazu-Qid: 2rWhEqwpjSXB4LNRsi
X-Iguazu-QSIG: v=2; s=0; t=1741240448; q=2rWhEqwpjSXB4LNRsi; m=ymWgP71ACtJbKtB2EI69amdhHBYakyDLhduTwhFclW4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 5265s75J774446
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 6 Mar 2025 14:54:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5lu8Su2U8NvX+VkqfS/LXl21KEiWYjERrrHfA3rte5xbQrveILqh9eta55LMRAICUwCuz87ZNCWr6lZ1CnoZxstUpwkMZ3NQDZ5kpAPsdme69VTAH1mmyyBz1ubNxUGY9DHmCVBXXLvsR0ZVtEtkL+xVkxVeaVTocqIbkgDTDePWYy9bCHl3bXhvgsoHFMljtDZdHCHwmJPkeJp9TBpbLLc4hiNgs4fmtA/IjQZ3fAKcSevuiTSouYYuWKijvr3EjpO0znbWfF+VpV5EnANY2sB/CLAGjzk62mfTlUFh3w5Oz4NWJDaA3Tu+OVsd3P3pJwSBrym3xLNv+0hEjA9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMaYe9wnHz0TsaVq8/lEbgtZl86/G3LPvZ5uL9QceB4=;
 b=szvSFJNn6mbVqZophlPTDlnnKIp12r8TXNoD9TYHNMV5yqBN94Y37VoaNNX0IgtaG5g2n4ylDgLczAIezI4qyMhqDweU0WoSfB0s2zNWuF2eeH370npJC63VbLlcqY9ClNBn5SmdpG3sU3ATrci2D3UZK6a4iFRvhIZ+6venvajaXL3JdhIXc6zjdEo5hHzGED6uXqlbs7CmJ+wYrll+rLn5M+j5QpQ0ulrcA0K5KJCYSQEb44B1Ao883pG3lMhViRpTT1DRaOkLQNKufrwpZ93ceVstmRNrI0sUnNDDYw4DSchF8B4d9szbsyw6cXKIQu9zBAfIVwfl5uayiJetNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <arisu.tachibana@miraclelinux.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [isar-cip-core][PATCH 1/2] kas/opt: Add option for not
 install kernel
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 1/2] kas/opt: Add option for not
 install kernel
Thread-Index: AQHbid7aiL2g1B6U5EC3Tt6PZG0LZbNc2mcAgAcfP4CAABQoAIABN/5g
Date: Thu, 6 Mar 2025 05:54:05 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818D951D04DE7F5E0A5038A92CA2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1740746806-6557-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <95dd9e49-59bf-44e4-bc62-6e0195d11300@siemens.com>
 <TY7PR01MB14818077A700A2DEE3DB42BDC92CB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <143de2ca-60aa-472a-ac99-e10e24a7e882@siemens.com>
In-Reply-To: <143de2ca-60aa-472a-ac99-e10e24a7e882@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB10110:EE_
x-ms-office365-filtering-correlation-id: 2c8a63a7-7061-4d9f-6e7e-08dd5c734dd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?K0xkTlVWQWhEVWxzdHdXK2F5RWkvMFBDOGRXbGdqS2hIREY3cFNob0NoMGdL?=
 =?utf-8?B?bFM4VGtwWXNHQmRQYWhvOGNjalo1TVZmSTh3MVA3Tjl2bUZNUlp6Skt2SjZ3?=
 =?utf-8?B?Tm9lL3lVdVNnT01MMTBDbXgwWXd6QWs0WTYvZi84aVAreFNUWStJTjNuWGNB?=
 =?utf-8?B?cTVqTFJScUE0U1dkWXNuLzFya0RnNWJaN0hyakM0ZmhmUlB1b0s4MkhKSGFj?=
 =?utf-8?B?T3dkTm52NkF4cmFIbkZoaTI3YU41bkYwVi94dFpXc1NkcndJODcxS0RNc3Br?=
 =?utf-8?B?cFF0SVVwQmZwY0dGbVh2ZGlrVU1XY1JBZXNUQ2prRml0NHZCRzlQWWZib09K?=
 =?utf-8?B?djlWWnZLbHdkejJMekZsbXBpMkliQ1FKazJidGVQT1g1RXl3eTltejU3Q2pX?=
 =?utf-8?B?cFk2OE9BQWxmL25wYmxEVE8rSzV1THNIbDJBTnZ6TmZtL0hVZm1Tb2tuK2NJ?=
 =?utf-8?B?aFpsTkVKcll3Ylp4SkwvazlqYjhnc05xWEU1V0NoT0NJLzFOSmJUVW15bFFm?=
 =?utf-8?B?YXdQbVNYRHpGOWlEOWRCOUEyL3p5Wnk4WFdIbzBmNnFycFM4VDljLzB5M2Qw?=
 =?utf-8?B?MFJsTFhEcHNkc3lyL0lNc1MwbU1COWJzeXBacVVIQUJsN0NLdWIzUHNmQXdJ?=
 =?utf-8?B?VTZGamJGWUdkdjRNZXd6T3dBdDFOWE0rSTFHVEpjRmhZaXExOGFXY0lJc01P?=
 =?utf-8?B?Vm5VdE5FS3VETUFjaVRLZHR0bFd3MWtnSmVlajlYV0VYNHVuVjVYQUE5dkM4?=
 =?utf-8?B?cWlQWmExMmFqaG5DS00zRE90M2xaR1ZnZS9iczZaVFRUcVdHRUZRL0VBSnQy?=
 =?utf-8?B?RGExVWpFOHVHUVhZcDdKcVkva1UvKzFxTXdicUNyVklpM3lRV1pxMDlRYzh3?=
 =?utf-8?B?OFFHZWJJaEFWSzAwS0FpRXhuRzBDMzFsSFlyTU5qWk1XU0pSUUZpbVpObGJF?=
 =?utf-8?B?bVlrdjVpVWtLMngza3V2VG9CTmw4elJzaTNWNUNrTCs0TkpUaFJ4MEVSTG8r?=
 =?utf-8?B?OVE1UWZZd08waXhrZHVKejliQllBRFlGcXBWNHhFM3VEMjBUbm1kNmlZMlBZ?=
 =?utf-8?B?em5rMTBXbm4zM1NHMkUvOXNPRkVoVmp2dnZySFR2Q3RLcE11c3c2cHBFdXdt?=
 =?utf-8?B?OWZmRGpJT2lFSm5vUTNVL1QxRGJEZm1BMTVsVmd2OE9tTGxmdGNVd0lHenN1?=
 =?utf-8?B?MGpWek9EK2JPdjUyVURTNE10bWpaQWY5K1d6QkZuSEVlZjd5UmQ5Y21ocU5Y?=
 =?utf-8?B?YUlSKzZTRFFIbDZ1N2Nra2xsZ2wxVkN6RlgwQXhsL3BpT2xWQ1hMYzArc1BB?=
 =?utf-8?B?eDIyU1lhenVRNFNXWHFySXpGRFdXdkpVVHJ5NzdrQ0ZTY0tDVVUrTUxvK1kv?=
 =?utf-8?B?TTgyMjRpU2p3NzdsNW51bzV0NjN4aFJQaFE4dWl3UWJBcGZqZXk1YWswYTNr?=
 =?utf-8?B?TmZCZnFLTWhFaXJwNGRZTkJEZHphNHRPNDN6RHlYZmhvcFlCeTIzSjlRQWFT?=
 =?utf-8?B?bnhKMHlFcWNNVmZKQkNjSHJ5Vjc4bEJYTFlpQk83cU1kS255NEZwS3Z2ZGQz?=
 =?utf-8?B?dVIyUUNOM3ZzcE94Q2FpSTFaRTRwQUk1UlNHY3pCY1ZYZFFMOGZxRGdVdnoy?=
 =?utf-8?B?YVRhS0JuV1VwazRqUVBVY1loaVhQR2ZTeTRjMElpTEVoblNVWUs5Vk12eDJs?=
 =?utf-8?B?R1NEZWlzUm9QL0FPZW5GUWN6b25hSXhCYU96ZGlHVm01L1EwZmtIMVdGZllU?=
 =?utf-8?B?S2FVU2I5WW5KUlVEcmxaamNpRS9zMkw4ejlWUjZILy9mTi9GczRSaVNvUTJL?=
 =?utf-8?B?N1BWMFBlZjJRTW5UcUJURTdjc1dkd0hyRjRMS1Z1QlAwQ0o5RG1TVGptcGdu?=
 =?utf-8?B?UkpQVjNNakZlL05VVEExdnhxcGdJdE8xNDlhVWtubC9LazlIOVJ3VjhVaUtV?=
 =?utf-8?Q?BhF4uD44wgRyIx8dd9ezbRnJWk19YhaG?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?V2QvK3J3ZmsvZ0x4QUFKYlF2aXdHSVIrY1h3dzVUdGdwMVhJcU11QmxtZHkv?=
 =?utf-8?B?Z2RaNmVSakRXRXJQcHBJU0xQNUp0OWlIQXB4ZnlDdDVGWVdJcE5vVXlJbjVs?=
 =?utf-8?B?aCsyb2YxdFF5ZCttdFpSZEZpK0gxZmxrMnpuMVRoR09FZFBRMkVLT1Y5c3V6?=
 =?utf-8?B?RGZwL3lVVEkxZFFneUJxZlhOVXlaLzN3bVc5TG1LMkwzbWY2UjA0dGgwbFlI?=
 =?utf-8?B?MWJkcW9pSHdlcWRWZjA3b3NsS2tJdlVHVEFla2JHMVRtUEtMRE9WQjF5eGU3?=
 =?utf-8?B?eW1yNnIzVFZCOUxTRy9aTVErcmY4eGlNdHlxVU5EMHMrQXZyZUlRMUMwdnR4?=
 =?utf-8?B?d0VZbWo4RlFZSHI1Q3VLVVVWa0RmWEpHWjdCaVZXSnNTV0VrMHE1OXBJN290?=
 =?utf-8?B?WEFiRlRTc1U4Y1AzVS9JMEFhRE42M0w2VFFmQjVNRFNPNE1QL2JiRGxOd0kr?=
 =?utf-8?B?UmhJaVJ5c1dtVVBlRTdEYmlHSUtZME1BNVhUMG5uOXJDblEwelF3ckhFamRK?=
 =?utf-8?B?QTVENGZ0Q2ZVcnI1dDBvcXptYmZMYTZxV2o0VHBWSUxVVUw2TEdhTFlFMnVy?=
 =?utf-8?B?Ny9EMjdGR0hHUm9xRVh3Ynk2T0NCS1dpNm9DY2JyeUpsby9CeHJmbmdDaUdz?=
 =?utf-8?B?SzRzNGt5R095d092VlBCb2lnNGlnamlGTGNKT25VS3M5NlNWREhFMEl3MU1p?=
 =?utf-8?B?Z2Q0dU9kQ3lDVEU3V2JFMmdNbFg0T1JmaDVpYXdSTVdUMGJYbm5Ha3NDak9x?=
 =?utf-8?B?SVJyY0UzNjNkcEdCSG5veWJ4cnk2ZFI5bXUzc3ZyYmhrUkVuNkg2LzVpeDNj?=
 =?utf-8?B?NjZxb3RSWXZKbDRSaFhxcHhIK01BMlJrYzdkdGlCTnBTcFBXQ0I5OEw0NmNy?=
 =?utf-8?B?UmpqOWFvcXNSQXhoYmowWXpkYll6SDJvZldDSGZqOW9wanhiMzNzSXFaQjB2?=
 =?utf-8?B?RUlpajMvcHEyM3F0R0Erbjhidkd6ZnVaTGNYcndIakxBQlNOb0NFYUxmaUFw?=
 =?utf-8?B?OW1lM0FPdW1KRE8wZHhSaDZlNlZGUUJkMHQwRzFNWWJCYytWci9yVm93bTFD?=
 =?utf-8?B?OWQrRHB0MkYyQnkySjhQTm8rcGVzaWo2c1BhclJ2eWdGTHlkM2JPc0JkaExH?=
 =?utf-8?B?NlkrWTZjMURrQVo1UUlrN3FUWW5xb0hieThCVXU2VWpQQjhIMjJNT2JxMzVr?=
 =?utf-8?B?Rk1Qeld1bGI2amNpUWttcTkyV1UxVGk3ZE5qNVBpZUtFR1M2YXhqNkJIZ0kr?=
 =?utf-8?B?WlluVHZyM1pEZmY3L2xqd0FmMU9hQ3kwRXQvUkxnUUdtMjMvRDM4ckxtUUk3?=
 =?utf-8?B?TDNJSmRUQnlTSVk4QnJ4RmVheW9ZWTZWR1NzSFZYcGJzKzJ5c2NMckVCalM4?=
 =?utf-8?B?T1pqdUNLNTAvMFhDK0NTRTU0YVU3N2dnL0diclNqMWZUUTFUY3pETEU2d3Rk?=
 =?utf-8?B?OGt0NkxNcWtCWU10OWx3ZUwrVlU1S21rc3EyeHFTQjN3Rm16d1JmTFNzb2Ur?=
 =?utf-8?B?SEFBUmZBQkhXZ0NmMCtYRXlwb0pWREtzWmorYkxVUG9WMUtjT29FbmpFZW5K?=
 =?utf-8?B?aVcwQWxvbW5KcVdVaTBqMjJnejdrcG5DWjM5QmxrbU5nMWprWGhBU3liWUky?=
 =?utf-8?B?N0N1MW9kVUp3U1FNKzd3U1VicDJIQUFHa3VScXNXckwzd1A3eCtMZytKOW01?=
 =?utf-8?B?NGlEL0tEWXRwMVE1dDBTSzJTSXJUQmc0d2Q3cXpRR0NXd0VtVkdzSDB0TElz?=
 =?utf-8?B?WHkrWVRPV1AvNHNvQ1JWM3VmR3JqSjMrbUcrSHIwRGE0T2d4YTZKcEk1c0tK?=
 =?utf-8?B?blNpK2R4eDdKUGpwQUw3Y2tPZjVkTmpURzBLNkY1SFQwVnJwY0tvbzFTQmI5?=
 =?utf-8?B?d2hZbDFGWk05MjJzNHFWNFEvSXEycjJCOERkVk81N2R0T3ZsTS92dm5BRmsr?=
 =?utf-8?B?SUNjV0RodjBpdGdla3NXQnlEMWxVd29PZUF4UmRRLzRnZ1lWTHUzMWtVMnFQ?=
 =?utf-8?B?dUJFQmNTVUxBN0ZvSWZPaHFZdFQ3Rlo4MjJBV0FIMjVTOFlWVlhGZGZURGwy?=
 =?utf-8?B?aXpodkw5ZHFjeVFrak5jSXBtYmJ5YmVzR0JDK1h0dWdyblk4Uy94UnVMdkZr?=
 =?utf-8?B?T1FRQlVlWU5DdTVLYytEOExDa1k1TFpXTFgyV1lQZmJHendZZW5Tb3F1RFR0?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8a63a7-7061-4d9f-6e7e-08dd5c734dd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 05:54:05.3100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ul6WmYaD8PrNVILgN+iiLqwK1DlX8tX897q8cF6UUpoHO4G52S3GQP30Z8wvsnTtSfdv8W5710NW4SEazG1V7IM+nSM3EiiyCV6IwXl7C1kZ/P6OXyaQygasaIA9hdGO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10110
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Mar 2025 05:54:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18049

SGkgamFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24N
Cj4gQmVoYWxmIE9mIEphbiBLaXN6a2EgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50
OiBXZWRuZXNkYXksIE1hcmNoIDUsIDIwMjUgMjozOCBQTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhp
cm8o5bKp5p2+IOS/oea0iyDil4vvvKTvvKnvvLTvvKPilqHvvKTvvKnvvLTil4vvvK/vvLPvvLQp
DQo+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnDQo+IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNvcmVdW1BB
VENIIDEvMl0ga2FzL29wdDogQWRkIG9wdGlvbiBmb3Igbm90DQo+IGluc3RhbGwga2VybmVsDQo+
IA0KPiA+Pg0KPiA+PiBPbiAyOC4wMi4yNSAxMzo0NiwgTm9idWhpcm8gSXdhbWF0c3Ugd3JvdGU6
DQo+ID4+PiBUaGlzIGFkZHMgYW4gb3B0aW9uIHRvIGNyZWF0ZSBhbiBpbWFnZSB0aGF0IGRvZXMg
bm90IGNvbnRhaW4gdGhlIGtlcm5lbC4NCj4gPj4+DQo+ID4+DQo+ID4+IFdoYXQgaXMgdGhlIHVz
ZSBjYXNlPyBIb3cgZG9lcyB0aGlzIHJlbGF0ZSB0byBrYXMvb3B0L2tlcm5lbGNpLnltbD8NCj4g
Pj4NCj4gPg0KPiA+IFRoaXMgaXMgbm90IHJlbGF0ZWQga2FzL29wdC9rZXJuZWxjaS55bWwuIFRo
aXMgd2lsbCBiZSB1c2VkIHRvIGNyZWF0ZSByb290ZnMgZm9yDQo+IENJUC9MQVZBIHRlc3Rpbmcu
DQo+ID4gVGhlIGN1cnJlbnQgcmVjaXBlIGNyZWF0ZXMgYW4gaW1hZ2UgY29udGFpbmluZyB0aGUg
a2VybmVsIGJpbmFyeS4NCj4gPiBLZXJuZWwgYmluYXJpZXMgYXJlIG5vdCBuZWVkZWQgaW4gcm9v
dGZzIGZvciBrZXJuZWwgdGVzdGluZy4gVGhlcmVmb3JlLCB3ZSBoYXZlDQo+IGFkZGVkIGFuIG9w
dGlvbiB0byByZW1vdmUgaXQuDQo+ID4gVGhpcyBpcyBhbHNvIHVzZWZ1bCBiZWNhdXNlIHNvbWUg
dXNlcnMgbWF5IG5lZWQgcm9vdGZzIHdpdGhvdXQga2VybmVsDQo+IGJpbmFyaWVzLg0KPiANCj4g
Rm9yIG15IHVuZGVyc3RhbmRpbmc6IFdoZW4gaXMga2VybmVsY2kueW1sIHVzZWQsIHdoZW4gdGhl
IGtlcm5lbC1mcmVlIGltYWdlPw0KDQpJIGFtIG5vdCBleGFjdGx5IHN1cmUgYWJvdXQga2VybmVs
Y2kueW1sLCBBcmlzdSwgY291bGQgeW91IGV4cGxhaW4gaXQ/DQpBcyBmYXIgYXMgSSBjYW4gY29u
ZmlybSwgdGhlIGN1cnJlbnQgZ2l0bGFiIENJIGFkZHMgZ2V0dHkgLCBzc2ggYW5kIGRtZXNnIHNl
dHRpbmdzIHRvIHRoZSByb290ZnMgd2l0aCBtaW5pbWFsIGZ1bmN0aW9uYWxpdHkuDQoNCkZvciBr
ZXJuZWwtZnJlZSBpbWFnZSwgSSBhbSB0aGlua2luZyB0aGF0IHRoZSBrZXJuZWwtZnJlZSBpbWFn
ZSBpcyB1c2VkIGZvciBrZXJuZWwgdGVzdGluZyBieSBnaXRsYWIgZm9yIENJUC9MQVZBLiANCk9m
IGNvdXJzZSwgdGhleSBjYW4gYWxzbyBiZSB1c2VkIGZvciBvdGhlciBrZXJuZWwgdGVzdHMuIEl0
IG1heSBiZSBwb3NzaWJsZSB0byBtYWtlIGtlcm5lbGNpIHRoZSBzYW1lLg0KDQo+IEZvciBrZXJu
ZWxjaSwgd2UgYWxzbyBkZXBsb3kgKG5vdCByaWdodCBub3cgYXMgdXBzdHJlYW0ncyBBUEkgaXMg
Y2hhbmdpbmcpLCBidXQNCj4gdGhhdCB3YXMgYWx3YXlzIHdpdGggdGhlIGtlcm5lbCAtIHdoeSB0
aGVyZT8NCj4gDQoNCkkgdGhpbmsgdGhhdCB0aGlzIHdvdWxkIGRlcGVuZCBvbiB0aGUgdXNlciBh
bmQgdGhlIGRlc2lnbmVycyBvZiB0aGUgdGVzdGluZyB0b29scy4NClNvbWUgcGVvcGxlIGRvbid0
IG1pbmQgdXNpbmcgcm9vdGZzIHdpdGggYW4gdW5yZWxhdGVkIGtlcm5lbCBmb3IgdGVzdGluZy4N
CkFsc28sIHRoZSBzaXplIG9mIHRoZSByb290ZnMgd2lsbCBiZSBzbWFsbGVyIHNpbmNlIGl0IGRv
ZXMgbm90IGNvbnRhaW4ga2VybmVsIGJpbmFyaWVzIG9yIGRyaXZlcnMuDQoNCj4gPg0KPiA+Pj4g
U2lnbmVkLW9mZi1ieTogTm9idWhpcm8gSXdhbWF0c3UNCj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0
b3NoaWJhLmNvLmpwPg0KPiA+Pj4gLS0tDQo+ID4+PiAgLmdpdGxhYi1jaS55bWwgICAgICAgICAg
ICAgfCAyOCArKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+Pj4gIGthcy9vcHQvbm9fa2VybmVs
LnltbCAgICAgIHwgMTcgKysrKysrKysrKysrKysNCj4gPj4+ICBzY3JpcHRzL2RlcGxveS1jaXAt
Y29yZS5zaCB8IDQ3DQo+ID4+PiArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LQ0KPiA+Pj4gIDMgZmlsZXMgY2hhbmdlZCwgNzggaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25z
KC0pICBjcmVhdGUgbW9kZQ0KPiA+Pj4gMTAwNjQ0IGthcy9vcHQvbm9fa2VybmVsLnltbA0KPiA+
Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS8uZ2l0bGFiLWNpLnltbCBiLy5naXRsYWItY2kueW1sIGlu
ZGV4IDRkZjUyMWIuLmEwOWVlZGQNCj4gPj4+IDEwMDY0NA0KPiA+Pj4gLS0tIGEvLmdpdGxhYi1j
aS55bWwNCj4gPj4+ICsrKyBiLy5naXRsYWItY2kueW1sDQo+ID4+PiBAQCAtMjcsNiArMjcsNyBA
QCB2YXJpYWJsZXM6DQo+ID4+PiAgICBidWlsZF9zd3VfdjI6IGRpc2FibGUNCj4gPj4+ICAgIHN3
dXBkYXRlX3ZlcnNpb246IGRlZmF1bHQNCj4gPj4+ICAgIHRlc3RfZnVuY3Rpb246IHN3dXBkYXRl
DQo+ID4+PiArICBub19rZXJuZWw6IGRpc2FibGUNCj4gPj4+DQo+ID4+PiAgc3RhZ2VzOg0KPiA+
Pj4gICAgLSBidWlsZA0KPiA+Pj4gQEAgLTY3LDkgKzY4LDEwIEBAIGRlZmF1bHQ6DQo+ID4+PiAg
ICAgIC0gaWYgWyAiJHt3YXRjaGRvZ30iID0gImRpc2FibGUiIF07IHRoZW4NCj4gPj4gYmFzZV95
YW1sPSIke2Jhc2VfeWFtbH06a2FzL29wdC9kaXNhYmxlLXdhdGNoZG9nLnltbCI7IGZpDQo+ID4+
PiAgICAgIC0gaWYgWyAiJHtzZWN1cml0eV90ZXN0fSIgPSAiZW5hYmxlIiBdOyB0aGVuDQo+ID4+
IGJhc2VfeWFtbD0iJHtiYXNlX3lhbWx9Omthcy9vcHQvc2VjdXJpdHlfdGVzdC55bWwiOyBmaQ0K
PiA+Pj4gICAgICAtIGlmIFsgIiR7c3d1cGRhdGVfdmVyc2lvbn0iID0gIjIwMjIuMTIiIF07IHRo
ZW4NCj4gPj4+IGJhc2VfeWFtbD0iJHtiYXNlX3lhbWx9Omthcy9vcHQvc3d1cGRhdGUtMjAyMi4x
Mi55YW1sIjsgZmkNCj4gPj4+ICsgICAgLSBpZiBbICIke25vX2tlcm5lbH0iID0gImVuYWJsZSIg
XTsgdGhlbg0KPiA+Pj4gKyBiYXNlX3lhbWw9IiR7YmFzZV95YW1sfTprYXMvb3B0L25vX2tlcm5l
bC55bWwiOyBmaQ0KPiA+Pj4gICAgICAtIGVjaG8gIkJ1aWxkaW5nICR7YmFzZV95YW1sfSINCj4g
Pj4+ICAgICAgLSBrYXMgYnVpbGQgJHtiYXNlX3lhbWx9DQo+ID4+PiAtICAgIC0gaWYgWyAiJHtk
ZXBsb3l9IiA9ICJlbmFibGUiIF07IHRoZW4gc2NyaXB0cy9kZXBsb3ktY2lwLWNvcmUuc2gNCj4g
Pj4gJHtyZWxlYXNlfSAke3RhcmdldH0gJHtleHRlbnNpb259ICR7ZHRifSAke0NJX0NPTU1JVF9S
RUZfU0xVR30gd2ljOw0KPiA+PiBmaQ0KPiA+Pj4gKyAgICAtIGlmIFsgIiR7ZGVwbG95fSIgPSAi
ZW5hYmxlIiBdOyB0aGVuDQo+ID4+PiArIHNjcmlwdHMvZGVwbG95LWNpcC1jb3JlLnNoICR7cmVs
ZWFzZX0gJHt0YXJnZXR9ICR7ZXh0ZW5zaW9ufQ0KPiA+Pj4gKyAke25vX2tlcm5lbH0gJHtkdGJ9
ICR7Q0lfQ09NTUlUX1JFRl9TTFVHfSB3aWM7IGZpDQo+ID4+PiAgICAgIC0gaWYgWyAiJHtidWls
ZF9zd3VfdjJ9IiA9ICJlbmFibGUiIF07IHRoZW4NCj4gPj4+ICAgICAgICAgICAgbWtkaXIgYnVp
bGQvcHJldmlvdXMtaW1hZ2U7DQo+ID4+PiAgICAgICAgICAgIGlmIFsgIiR7ZXh0ZW5zaW9ufSIg
PSAic2VjdXJpdHkiIF0gfHwgWyAiJHtleHRlbnNpb259IiA9DQo+ID4+PiAiZWJnLXNlY3VyZS1i
b290LXNuYWtlb2lsIiBdOyB0aGVuIEBAIC0yMjEsNiArMjIzLDMwIEBADQo+ID4+IGJ1aWxkOnFl
bXUtYXJtLXRlc3Q6DQo+ID4+PiAgICAgIHRhcmdldDogIHFlbXUtYXJtDQo+ID4+PiAgICAgIGV4
dGVuc2lvbjogdGVzdA0KPiA+Pj4NCj4gPj4+ICtidWlsZDpxZW11LWFtZDY0LXRlc3Qtbm9rZXJu
ZWw6DQo+ID4+PiArICBleHRlbmRzOg0KPiA+Pj4gKyAgICAtIC5idWlsZF9iYXNlDQo+ID4+PiAr
ICB2YXJpYWJsZXM6DQo+ID4+PiArICAgIHRhcmdldDogIHFlbXUtYW1kNjQNCj4gPj4+ICsgICAg
ZXh0ZW5zaW9uOiB0ZXN0DQo+ID4+PiArICAgIG5vX2tlcm5lbDogZW5hYmxlDQo+ID4+PiArDQo+
ID4+PiArYnVpbGQ6cWVtdS1hcm02NC10ZXN0LW5va2VybmVsOg0KPiA+Pj4gKyAgZXh0ZW5kczoN
Cj4gPj4+ICsgICAgLSAuYnVpbGRfYmFzZQ0KPiA+Pj4gKyAgdmFyaWFibGVzOg0KPiA+Pj4gKyAg
ICB0YXJnZXQ6ICBxZW11LWFybTY0DQo+ID4+PiArICAgIGV4dGVuc2lvbjogdGVzdA0KPiA+Pj4g
KyAgICBub19rZXJuZWw6IGVuYWJsZQ0KPiA+Pj4gKw0KPiA+Pj4gK2J1aWxkOnFlbXUtYXJtLXRl
c3Qtbm9rZXJuZWw6DQo+ID4+PiArICBleHRlbmRzOg0KPiA+Pj4gKyAgICAtIC5idWlsZF9iYXNl
DQo+ID4+PiArICB2YXJpYWJsZXM6DQo+ID4+PiArICAgIHRhcmdldDogIHFlbXUtYXJtDQo+ID4+
PiArICAgIGV4dGVuc2lvbjogdGVzdA0KPiA+Pj4gKyAgICBub19rZXJuZWw6IGVuYWJsZQ0KPiA+
Pj4gKw0KPiA+Pg0KPiA+PiBEbyB3ZSBhbHdheXMgbmVlZCB0byBidWlsZCBhbmQgZGVwbG95IHRo
b3NlIGV4dHJhIGltYWdlcz8NCj4gPg0KPiA+IEl0IHdpbGwgbm90IGJlIG5lY2Vzc2FyeSBldmVy
eSB0aW1lLg0KPiA+IEl0IHdpbGwgbmVlZCB0byBiZSBidWlsdCB3aGVuIExUUCBpcyB1cGRhdGVk
IG9yIHdoZW4gYSBwb2ludCByZWxlYXNlIGlzIGhhZCBpbg0KPiBEZWJpYW4uDQo+ID4gVGhlIGN1
cnJlbnQgZ2l0bGFiIHBpcGVsaW5lIGlzIG5vdCB0aGF0IHdlbGwgdGhvdWdodCBvdXQgYW5kIEkg
dGhpbmsgaXQgbmVlZHMgdG8NCj4gYmUgY29uc2lkZXJlZC4NCj4gPg0KPiANCj4gSWYgd2UgZG8g
bm90IHBpY2sgdXAgdGhlIGFydGlmYWN0cyBhdXRvbWF0aWNhbGx5IGZyb20gYSBwaXBlbGluZSBi
dWlsZCwgd2UgY2FuDQo+IG1ha2UgdGhlc2UgdmFyaWFudHMgYWxzbyBtYW51YWxseSB0cmlnZ2Vy
ZWQuIEJ1dCBJIHN0aWxsIG5lZWQgdG8gdW5kZXJzdGFuZCB0aGUNCj4gYXBwYXJlbnQgb3Zlcmxh
cCB3aXRoIHRoZSBrZXJuZWxjaSBidWlsZHMgKHdoaWNoIGhhcHBlbiB1bmNvbmRpdGlvbmFsbHkg
c28NCj4gZmFyKS4NCg0KSSBoYXZlIHN1bW1hcml6ZWQgdGhlIGRpZmZlcmVuY2VzOg0KDQotIGtl
cm5lbGNpOg0KICAtIG5vdCBpbmNsdWRlIHRlc3QgKExUUCBhbmQgb3RoZXJzKQ0KICAgIGtlbnJl
bGNpIHByb2JhYmx5IGRvd25sb2FkcyB0aGUgdGVzdCBiaW5hcmllcyB3aGVuIGl0IHJ1bnMgdGhl
IHRlc3RzIGR1ZSB0byBMQVZBIGZ1bmN0aW9uYWxpdHkuDQogIC0gaW5jbHVkZXMgZGVkaWNhdGVk
IHNjcmlwdHMgKHNzaCwgZ2V0dHkgYW5kIG90aGVycykgYW5kIGNvbmZpZ3VyYXRpb24NCiAgLSBp
bmNsdWRlIGtlcm5lbCBiaW5hcmllcyB3aGVuIGJ1aWx0DQoNCi0gbm9fa2VucmVsIChsYXRlc3Qg
cGF0Y2gpOg0KICAtIG5uY2x1ZGVzIExUUCBhbmQgb3RoZXIgdGVzdGluZyB0b29scy4NCiAgLSBu
b3QgaW5jbHVkZWQga2VybmVsIGJpbmFyaWVzDQoNCklmIGtlcm5lbGNpIGRvZXMgbm90IHVzZSB0
aGUga2VybmVsIGNvbnRhaW5lZCBpbiB0aGUgcm9vdGZzLCBJIGJlbGlldmUgaXQgaXMgcG9zc2li
bGUgdG8gY3JlYXRlIGEgY29tbW9uIGltYWdlDQp0aGF0IGRvZXMgbm90IGNvbnRhaW4ga2VybmVs
IGJpbmFyaWVzIGFuZCB0ZXN0IGJpbmFyaWVzLiBBcyBmb3IgTFRQIGFuZCBvdGhlciB0ZXN0IGJp
bmFyaWVzLCB0aGUgc2FtZSBmdW5jdGlvbmFsaXR5DQphcyBrZXJuZWxjaSB3b3VsZCBuZWVkIHRv
IGJlIG1vZGlmaWVkIHRvIGJlIGF2YWlsYWJsZSBpbiBDSVAvTEFWQSBZQU1MLg0KDQo+IA0KPiBC
VFcsIHdoZXJlIGlzIHRoZSByaXNjdjY0IHZhcmlhbnQ/DQoNCkFoLCBJIGZvcmdvdCBhYm91dCB0
aGF0LiBJJ2xsIGFkZCBpdCB3aXRoIHVwZGF0ZSBwYXRjaC4NCg0KQmVzdCByZWdhcmRzLA0KICBO
b2J1aGlybw0K


