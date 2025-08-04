Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B494C87FCF
	for <webhook@archiver.kernel.org>; Mon,  4 Aug 2025 13:09:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.17379.1754312939386412664
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Aug 2025 06:09:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 574D8uVE2429458; Mon, 4 Aug 2025 22:08:57 +0900
X-Iguazu-Qid: 2yAbyr8Usk8eZthQSO
X-Iguazu-QSIG: v=2; s=0; t=1754312936; q=2yAbyr8Usk8eZthQSO; m=eMo7Y51jluByjXhsdPSx2KgXDh98NmDB2I5ySUKH2YE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 574D8tS53540422
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 4 Aug 2025 22:08:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXgahF7faNVYLBfIamgNB/9di37mOC8jztklghrr0vmcCjnYiJI6lKFSHhXTEf/NBKNFZrrlewbWEqtuhoqrg1YSP6V9kuJ04LDLXW7S0BE/FlKf9N6zaPfpqdAXu/c9wRX9XGy5pVwqAd6HcLLsa3VQfm9tP0Ily8vTl48VzxOneREJfVGlhrKg4kK4DEfgLWauAYibQp2UoaOtuV+ywoAGuibySN0iqHhocodd22iVem2rCcl/Zm+S3Gm2hnRzlJ1Y9dOv4AsrwC9eJZYzfgDl5bY+E3r54P9Bn75Nk+qu658UCmOvDH0KUQvBGqm8uCN46hUoZmhi2TcexJAPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEzhZ6j+OULiXHOkc4cLHwedXACznKk1KovYw0S6RbE=;
 b=g6x6vA3dlkQWbCmxO3dSV884gvJvEQOwb3oamT6mfPRS/HrGClc8j5FvH2dPnIC02fh7pyeBpCWI3W5TtUy/zzmGpSIpiWFk+PAFRhQacfM93mI/WKf7zW28os7QHeywcuSHUbzq7WvY5Yr3pMg+Ttij6kGRa+0EojeiJFiwY1JYKZ3RPvNXq4Eg0lmIh4hdyRVxRrV2Hj12aTChg1O822nYiC8jQ/Xs/Np4iEH7qNdQivgsKCCxTgLc4kSyt3RjqYSRfRH4aPaCNDo0bU8pCP/IFxmf0uzJvqpXOIb8693DIRmk4G7oiR0nixNphO3P+jY9CJzlIShojY0i2bX0ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <Adithya.Balakumar@toshiba-tsip.com>
Subject: RE: [cip-dev] [isar-cip-core v1] README.security-testing.md: Remove
 the credentials from console & document them
Thread-Topic: [cip-dev] [isar-cip-core v1] README.security-testing.md: Remove
 the credentials from console & document them
Thread-Index: AQHbuyKPR5GGPQhBmkSQO9iot55vJ7O+78cAgJPA+/qAAAA9QA==
Date: Mon, 4 Aug 2025 13:08:52 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB11075B09AA1BFCDF5DACB3519C723A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <20250502052035.1959453-1-Sai.Sathujoda@toshiba-tsip.com>
 <29c1beeb-3f3e-4bb2-89b5-a84d2b0b5043@siemens.com>
 <TYCPR01MB9669DF71C777AFA3B394F007C423A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYCPR01MB9669DF71C777AFA3B394F007C423A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TYWPR01MB10178:EE_
x-ms-office365-filtering-correlation-id: db0f0401-11c0-456d-4aa0-08ddd3580f7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|8096899003|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?akc5U25RK2J4WEJyY3Y2QWZrSlR4ZDYreml1cTBIQnMybUhuekMxeE5k?=
 =?iso-2022-jp?B?N3NOQXJqbXR3d3lpUDV5bkt5ekxCWEtxeWFMT2pnaVkzaGNEMlpOVVVm?=
 =?iso-2022-jp?B?aU4wS2hwdFVlRG5TVlpjNFduRUZDZXp1Z3ZFNTFWc1k1S2JManp5QW0w?=
 =?iso-2022-jp?B?d0JscUV3Zk94L0lSOFNrWk9kdElFYngxbEhpZkphMHB3Mmo2U2FjWE4z?=
 =?iso-2022-jp?B?eG1xbjNwWmVxTm9GbjJ4L3c5WG9QdWdyRkRrVHJ6T2QvdldkbVZPMXcr?=
 =?iso-2022-jp?B?TVNwVkZpd1R4TG5xek1lVkxuNjlHdUhUb3JqQVRwRHVkZVNnQ3ovaURM?=
 =?iso-2022-jp?B?SkhTcW9XQXdrUDR6OE9udXNXUW51eTQ1S3NLRUdEUGlNdjJMM3dGWElk?=
 =?iso-2022-jp?B?VzVPck54clhNZnBiczEwSlpDZ0wraGJGcUR4SDZXUVgycDVwOXl6Z0ZJ?=
 =?iso-2022-jp?B?WVEzU2Q4ODVUUU9iRGhGWFJmRW1KdDRuZmZwbWdRZ3cwWjg5bEZ1S1ll?=
 =?iso-2022-jp?B?Q3o1bk13Wk9Pc21acUZsQkxaQkMyL2pqSEQrQzYvMWdpekRLVnR6TjNC?=
 =?iso-2022-jp?B?aTBWMTJZYWxrVlpBc1pRY0IwTldXVDdsZWNxekRITnlCYTBmU0xQekZR?=
 =?iso-2022-jp?B?SldqNVlRMzhEYlFEQXlUQ0VrSVVjek1DZUlPd202eUIyL1JOKzZwOWhO?=
 =?iso-2022-jp?B?aU9MWVBVb3dReGxLbVNyNDBtWGlDdjhuNTQ3UGZ4R0crSzJCdVBZTEpn?=
 =?iso-2022-jp?B?ek5CTmFIelN0N2xaUUNkQ1g0SFVzVUpUK0hVMlRsT1hxay9VSnRhVy9r?=
 =?iso-2022-jp?B?THZ2aDdEVmd1ejI3bzlmTTBhbmQvbUxMSXFaRGY2K0pCZ3ZTNDZWVHli?=
 =?iso-2022-jp?B?MTdJNE0zTU53NklNRkt3amtHUGdXTjE1dGI5MUtaQ2o1SmUwTTFudVBi?=
 =?iso-2022-jp?B?SHVIWHd2T1NqZGE4WW5HWWR3L1pQVXRnaHZEMzNBbnB5ajBjNE54Y0FL?=
 =?iso-2022-jp?B?TE5mYUtJbkl5U1JxWnlHaW90RERVSVI5ZnpBMHpBL3Yvc1RGMHk3NFB5?=
 =?iso-2022-jp?B?MTk5cTZ4M1dITlUrMXN0d2ZsMXB0aTVDZmw0dkt1M0JoVVRwdmdaNVdl?=
 =?iso-2022-jp?B?akFVUFJrbFVtdDhZbWRYM0ZFUTNBbWl4a1ZTZVBJVzFjak9JdWtoMmtv?=
 =?iso-2022-jp?B?Z3BWV1QrZFh4dXlXVXNybnhsb1lGQnRycS81UnNvWnBpS1JZVVVCemFS?=
 =?iso-2022-jp?B?ZVJndTI0WlplbHQvK2RZK240MFBzcFFTZm4xbWVJTmxGVWNJVkUxQlVM?=
 =?iso-2022-jp?B?VVo1cEhZaHNtbGF6THh1cTBQS0ZmUlhKWXZ2SGo4b0NEbE5VbVB2Z0Fy?=
 =?iso-2022-jp?B?MDF5U1FPd0pDRDQ0ekVJTUtOb1ovaVUrUlVTdkRzdjlKdjU4RXU2M05G?=
 =?iso-2022-jp?B?d1ptd2JMR3pnc09wbVFSODkvMDdJZVVpS2xWSmtaNHdSdU9rWHUrMUJS?=
 =?iso-2022-jp?B?Q3FiSDNoUVU4TG9TYytvR3J5SVJtbEw2YW90akZjVGhYRmliRUxaMXRI?=
 =?iso-2022-jp?B?bmlmUmEySHFlSVZmb2NyZmNvQWFFYUNXS0lBQWIxUWNVYXFaK2xvMnhQ?=
 =?iso-2022-jp?B?OW05RCt0Q1BTU2hLc3ZnQXRIQTByNlBiUnEzeGk4TDFuZVVuQVUxMksx?=
 =?iso-2022-jp?B?RCs5ZXNHT2JBcVBvUG1qU09Obk1iNUR0Uk9XMlNweGp6V2xKRERxVUxn?=
 =?iso-2022-jp?B?MkMwWTR4UXphazVqNVUwMDUvSzJ2NmIvWG1YVC9jMjNlajZEU2Z4a1pk?=
 =?iso-2022-jp?B?UDZyN1VnR3NoejVDcnYvc1RmcnlOa3V3TE9IbkEzNElZelc2UktqM21E?=
 =?iso-2022-jp?B?K1lIaUIrNFM4ZmIycWNhNkpBTGxiUmtiNXc4RDhMYmxPN1krMnZvRW1q?=
 =?iso-2022-jp?B?VEM2YTNJV2d3R0t1TFNxS0tCQjlmSjFadE9WdEUycEdsTEl5YUFEanU3?=
 =?iso-2022-jp?B?eGViRXdld1BQS3lML3FBYXdjcTg4bisrR0VyUkd3ZGFTdDVsNXhxMmRz?=
 =?iso-2022-jp?B?RnI5TXpzUWxpL1lDd0NQVm1iZ3NrUWliM0dMam1od2IzTzhVVExrZkY2?=
 =?iso-2022-jp?B?czhoZjV6alNmS21KTU9JS05uc1VwMCt2TzB3aW16ak9VNXdiQmZzU2Fj?=
 =?iso-2022-jp?B?bmkwPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(8096899003)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?S1kzMEt1YzVVQVVxaG1sVHhxcC9Zcm05OFNGTEZ4bFJxRERHUC8xSVZj?=
 =?iso-2022-jp?B?ZXlJQkk3Zm9oa2p4QUdmM05jckRGanJ4WE92dnBDK29uNlVGR0NkUlRi?=
 =?iso-2022-jp?B?djlyVGRWekd3dlUzZGNnLzhmcjBPbmpPby9BWnFObFVJSDBrbVR1ZVVm?=
 =?iso-2022-jp?B?bnpMZk1LbjJjVC92RmYrZHk4TFUyQm0vKytaVHBjWm5tN05MZEgwTFY0?=
 =?iso-2022-jp?B?N08yTnJXTmFNcTNnUDlpUjlPa1hPSXV3S1dpWmREVUx6U0N4UHZpQjNr?=
 =?iso-2022-jp?B?Rkk2Qk5VcFZjek51UXBYdFhBQmF6b3VJeVN5bC9zYUhBTitDVnFtWjkz?=
 =?iso-2022-jp?B?VWJwY25oNGNWRnBYTzhUM3JibXFjZW9BQmJVcXZJdytYeDEwSnlDRTdS?=
 =?iso-2022-jp?B?MlJrOUFEY2JUVEpxb2VBekFtdnB4UDhUOURXd0NRYXhxakJGSWtQZXJ0?=
 =?iso-2022-jp?B?WFFIUlRCaVdGc094R3UrMDFDZ3BncmF6bVNxU0dMQmxiVTBuMThmQTJX?=
 =?iso-2022-jp?B?MGtpeGYxdjZlWEdHVG9jSno0c3dkUzhhTE1HSitNQ2hpajVaOStKT1dB?=
 =?iso-2022-jp?B?WFZ2OGNKbEdHclp0SHQ3YlhlVDRlMEQvcW52OUdqTjdZUXJRVjNWQThM?=
 =?iso-2022-jp?B?UktYWklkcjJMOXhtaTBhbDYwLzZYOWFJelFCaUxuUXRsT2ZQR1o2S1dh?=
 =?iso-2022-jp?B?TTI4WUFBZm1yRERIU3djQnpMVzUzUmdIUkVvaXlCRXZkUXZkWWhpNllU?=
 =?iso-2022-jp?B?aVc1aWVRZTJ5T2djOEliN3IxVk00ZzJlN3J0RGNDeWRic0pFODBCR2Qz?=
 =?iso-2022-jp?B?WC9IODVvZmZUSlBDZFBGQXQxbERsN3pMWUVhSXJIcmMrV1E3b0FXdDdE?=
 =?iso-2022-jp?B?UEljZjNOQVhnMjF4RXdUbkQ0K0VMZndNT29vQkJTbStYK1h4cUdiU1FP?=
 =?iso-2022-jp?B?TXlBTUFXYy9aN1BnZFd2R3FQbGxUU2xFcFNteXlkc2Y3cndDSjJyRG42?=
 =?iso-2022-jp?B?OGFtTnhkSVdSejZjSGg1YUFzQ1FqeWdIcEEySlR4U1hMMkNpL0tDV0pk?=
 =?iso-2022-jp?B?N0pBbGVldElnREdVYlBKU0NHd1d2QmxlRUF3WUszbWowZ1B1WmQ0UFkw?=
 =?iso-2022-jp?B?VXQ3c1dCd3hyQlN3QjJOUXdiVmhYL0twRm1BNFNFZTF2VWhFeThIRlFv?=
 =?iso-2022-jp?B?QjdpbzNGbTZyTEtJbXp1Y0dKdEo5TG1SMnRlY2pUM0pPVXYwNUljRlQw?=
 =?iso-2022-jp?B?L3ZpYVpWSDhwcDkzMVFPSkxsOFdlVXdPVVdnQ1lOR09mdFh5WVl2Ymhw?=
 =?iso-2022-jp?B?ZzhUWHlLWEhlYnlpUU1lVnVNN0RQSWp0OGh5ckR6SXptQVlVenpLM1JO?=
 =?iso-2022-jp?B?ZDhTTHVuckd3RTByL3RFbG1QQWN0TzNUUVI4b3JaRGtQYURMci9Ddm1x?=
 =?iso-2022-jp?B?T2ZDTEdkQStVc0hjQ1N6Z1c4Q2duSkx4d1VKN0Y2cDh4c25Id2Y5VDhW?=
 =?iso-2022-jp?B?bU1IakNiYlRETDdWTFh6Q2ZmTEVjTmM1bS9HeVJHQ2FEREY5d1djaFdZ?=
 =?iso-2022-jp?B?TjYra2lqc3UwQkNSTysydHc1UHFRaFlrWnUyYndTUlJkSVlBS3ozbGU4?=
 =?iso-2022-jp?B?aG11WU10OWp1UUJ1dU91ck5OeHVVVUNka2JlTHlFUDA1VVFXRlVpRXRt?=
 =?iso-2022-jp?B?UEt2QWMwejI2anR0bVNjbnlPQzFqRkZqSkpDbGJXTWZTVmhRQTc1V21E?=
 =?iso-2022-jp?B?VDh1NWpidERJN2NBUityNnNyYXdXbGVSRzJqZkdvVXNhY21zQTY4QkJY?=
 =?iso-2022-jp?B?Wm9rdzdTM21wZm8yM3ZkUldxZjBxMWthTnlIT0VGRWNuQkhSWUNsVklN?=
 =?iso-2022-jp?B?aCtMUWZlVEZ5TGNXYTM3amRoMWR2TG9xOGl0MjN2amFFQ1pnVnIwTEU5?=
 =?iso-2022-jp?B?dTNvZk5WcEpoaGtYejZmdk5pK0NrajZ1WnBDMHVORTFmajZTSDA5OStX?=
 =?iso-2022-jp?B?Y0Q5OTYwSWJYZm1zUWVTK0E4bzgycmNhbWprSDlDblNEeGw4SjdhZGc4?=
 =?iso-2022-jp?B?cm4vdzBFaFN5M2dsUTh0eWFDTkROQUdTUWI2MFpEZVBGVFhLbjVpdThw?=
 =?iso-2022-jp?B?eEE2SDJWNnREdnJlNndrUmk4c05GMWFVQlRzdEVWaFdBcVZYKzZVblFM?=
 =?iso-2022-jp?B?VktIRFhkM2lpcW56TFBQMXZWbHd0SEpKWnNNTDB5Z3FDZTRJQjN0MUhQ?=
 =?iso-2022-jp?B?UFJaekNtemt4WHBseGx4T05MWTgvcmEySlhieStQTERCRlF4VjFmS0VL?=
 =?iso-2022-jp?B?d0JremZHVmg1ZGRiSVVWQ1B2c1VqTmFXbHQrK1JURitIR3NqaVBJQUlJ?=
 =?iso-2022-jp?B?YzNPMms9?=
Content-Type: multipart/alternative;
	boundary="_000_TY3PR01MB11075B09AA1BFCDF5DACB3519C723ATY3PR01MB11075jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0f0401-11c0-456d-4aa0-08ddd3580f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 13:08:52.6613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E/9DgrL+k6ZEVe8Rxto0f6Q5ZQyVSpdYEqzlTPzns5Vd+N8Q6/fxtGm+FxOY5/l+xBmx/Y+0AMC0+KJeYeNqzfBiu3YLWdEvdbDUSAOS3jU3EkaxP7PTof/pgnEdQs5n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10178
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Aug 2025 13:09:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19659

--_000_TY3PR01MB11075B09AA1BFCDF5DACB3519C723ATY3PR01MB11075jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

This is an old patch and would like to get some conclusion on this.
Based on the conclusion, I will plan to send v2 patch if required.

>> +IEC 62443-4-2 certification body expects to remove the credentials from=
 being displayed on the console prior login stage.

>This sentence does not belong here.

Okay, we can remove it.

>> +(Warning) CIP users are strongly recommended not to use CIP default cre=
dentials for production images.

>No, this MUST never be shipped in production, irrespective of any formal
>certificates. This here is a TEST image, not a PRODUCTION image.

We can remove this statement as well.

>Anything that must be kept for a production image
>must not be contaminated by setting that are just for testing purposes.
>In that light, having our test password inside a customization package
>that could be reuse for a real image is a bad thing.

As per my understanding, we don=1B$B!G=1B(Bt have separate recipes for TEST=
 / PRODUCTION images.
Correct me if my understanding is wrong here and also I believe minimal cha=
nges required for PRODUCTION images based on the current isar-cip-core reci=
pes.

In that case, the current patch which removes credentials from console (/et=
c/issue) works for both TEST / PRODUCTION (if production image uses the cur=
rent recipes as base/reference) images.
The CIP users should refer README for the login credential details for TEST=
 images.

As of now, there is no blocker from this patch.

Thanks & Regards
Shivanand K
________________________________
From: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org> <=
cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>> on beh=
alf of Jan Kiszka via lists.cip-project.org <jan.kiszka=3Dsiemens.com@lists=
.cip-project.org<mailto:jan.kiszka=3Dsiemens.com@lists.cip-project.org>>
Sent: Friday, May 2, 2025 12:52 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Sai.Sathujoda@toshiba-tsi=
p.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>; cip-dev@lists.cip-project.or=
g<mailto:cip-dev@lists.cip-project.org> <cip-dev@lists.cip-project.org<mail=
to:cip-dev@lists.cip-project.org>>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsi=
p.com<mailto:dinesh.kumar@toshiba-tsip.com>>; hayashi kazuhiro(=1B$BNS=1B(B=
 =1B$BOB9(=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <kazuhiro3.hayashi@toshiba.co=
.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>>
Subject: Re: [cip-dev] [isar-cip-core v1] README.security-testing.md: Remov=
e the credentials from console & document them

On 02.05.25 07:20, Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@tosh=
iba-tsip.com> wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com<mailto:sai.sa=
thujoda@toshiba-tsip.com>>
>
> The IEC 62443-4-2 certification body insists on removing the login creden=
tials
> from console prior login prompt and document them as part of user manual.
>

We are qualifying an image "as if" it were a production image, mentally
subtracting anything that enables automated or manual tests - including
hard-coded credentials. Let's split those bits technically and document
that. And avoid suggesting that everything is fine if just the prompt is
no longer showing a password - the well-known password itself is the
problem.

> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com<mail=
to:sai.sathujoda@toshiba-tsip.com>>
> ---
>  doc/README.security-testing.md                      | 7 +++++++
>  recipes-core/security-customizations/files/postinst | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/doc/README.security-testing.md b/doc/README.security-testing=
.md
> index 213fc82..9696892 100644
> --- a/doc/README.security-testing.md
> +++ b/doc/README.security-testing.md
> @@ -25,6 +25,13 @@ Save & Build
>  ```
>  host$ ./start-qemu.sh x86
>  ```
> +# Login using the following credentials
> +```
> +username: root
> +password: CIPsecurity@123
> +```
> +IEC 62443-4-2 certification body expects to remove the credentials from =
being displayed on the console prior login stage.

This sentence does not belong here.

> +(Warning) CIP users are strongly recommended not to use CIP default cred=
entials for production images.

No, this MUST never be shipped in production, irrespective of any formal
certificates. This here is a TEST image, not a PRODUCTION image.

>
>  # Copy security tests in to the Linux image
>  - Clone the cip-security-tests from following URL
> diff --git a/recipes-core/security-customizations/files/postinst b/recipe=
s-core/security-customizations/files/postinst
> index daade83..15be659 100755
> --- a/recipes-core/security-customizations/files/postinst
> +++ b/recipes-core/security-customizations/files/postinst
> @@ -6,7 +6,7 @@
>
>  set -e
>
> -echo "CIP Core Security Image (login: root/CIPsecurity@123)" > /etc/issu=
e
> +echo "CIP Core Security Image" > /etc/issue
>
>  # CR1.7: Strength of password-based authentication
>  # Pam configuration to  enforce password strength

Let's argue like that: Anything that must be kept for a production image
must not be contaminated by setting that are just for testing purposes.
In that light, having our test password inside a customization package
that could be reuse for a real image is a bad thing.

Jan

--
Siemens AG, Foundational Technologies
Linux Expert Center

--_000_TY3PR01MB11075B09AA1BFCDF5DACB3519C723ATY3PR01MB11075jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">Hi Jan,
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">This is an old patch and w=
ould like to get some conclusion on this.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">Based on the conclusion, I=
 will plan to send v2 patch if required.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; +IEC 62443=
-4-2 certification body expects to remove the credentials from being displa=
yed on the console prior login stage.<br>
<br>
&gt;This sentence does not belong here.</span><span style=3D"font-size:11.0=
pt;font-family:&quot;Aptos&quot;,sans-serif;mso-fareast-language:EN-US"><o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">Okay, we can remove it.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&gt;&gt; +(Warning)=
 CIP users are strongly recommended not to use CIP default credentials for =
production images.<br>
<br>
&gt;No, this MUST never be shipped in production, irrespective of any forma=
l<br>
&gt;certificates. This here is a TEST image, not a PRODUCTION image.<br>
<br>
</span><span style=3D"font-size:11.0pt;font-family:&quot;Aptos&quot;,sans-s=
erif;mso-fareast-language:EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">We can remove this stateme=
nt as well.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">&gt;</span><span style=3D"=
font-size:11.0pt">Anything that must be kept for a production image<br>
&gt;must not be contaminated by setting that are just for testing purposes.=
<br>
&gt;In that light, having our test password inside a customization package<=
br>
&gt;that could be reuse for a real image is a bad thing.<br>
<br>
</span><span style=3D"font-size:11.0pt;font-family:&quot;Aptos&quot;,sans-s=
erif;mso-fareast-language:EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">As per my understanding, w=
e don=1B$B!G=1B(Bt have separate recipes for
</span><span style=3D"font-size:11.0pt">TEST </span><span style=3D"font-siz=
e:11.0pt;font-family:&quot;Aptos&quot;,sans-serif;mso-fareast-language:EN-U=
S">/</span><span style=3D"font-size:11.0pt"> PRODUCTION
</span><span style=3D"font-size:11.0pt;font-family:&quot;Aptos&quot;,sans-s=
erif;mso-fareast-language:EN-US">images.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">Correct me if my understan=
ding is wrong here and also I believe minimal changes required for
</span><span style=3D"font-size:11.0pt">PRODUCTION </span><span style=3D"fo=
nt-size:11.0pt;font-family:&quot;Aptos&quot;,sans-serif;mso-fareast-languag=
e:EN-US">images based on the current isar-cip-core recipes.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">In that case, the current =
patch which removes credentials from console (/etc/issue) works for both
</span><span style=3D"font-size:11.0pt">TEST </span><span style=3D"font-siz=
e:11.0pt;font-family:&quot;Aptos&quot;,sans-serif;mso-fareast-language:EN-U=
S">/</span><span style=3D"font-size:11.0pt"> PRODUCTION
</span><span style=3D"font-size:11.0pt;font-family:&quot;Aptos&quot;,sans-s=
erif;mso-fareast-language:EN-US">(if production image uses the current reci=
pes as base/reference) images.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">The CIP users should refer=
 README for the login credential details for TEST images.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">As of now, there is no blo=
cker from this patch. &nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">Thanks &amp; Regards<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;mso-fareast-language:EN-US">Shivanand K<o:p></o:p></sp=
an></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">
</span><a href=3D"mailto:cip-dev@lists.cip-project.org"><span style=3D"font=
-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">cip-dev@lists.cip-=
project.org</span></a><span style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,sans-serif;color:black"> &lt;</span><a href=3D"mailto:cip-dev@li=
sts.cip-project.org"><span style=3D"font-size:11.0pt;font-family:&quot;Cali=
bri&quot;,sans-serif">cip-dev@lists.cip-project.org</span></a><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black=
">&gt;
 on behalf of Jan Kiszka via lists.cip-project.org &lt;</span><a href=3D"ma=
ilto:jan.kiszka=3Dsiemens.com@lists.cip-project.org"><span style=3D"font-si=
ze:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">jan.kiszka=3Dsiemens.=
com@lists.cip-project.org</span></a><span style=3D"font-size:11.0pt;font-fa=
mily:&quot;Calibri&quot;,sans-serif;color:black">&gt;<br>
<b>Sent:</b> Friday, May 2, 2025 12:52 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"JA" style=3D"font-size:11.0pt;c=
olor:black">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-size:11.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif;color:black"> DITC_DIT-OST) &lt;</span=
><a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">Sai.Sathujoda@toshiba-t=
sip.com</span></a><span style=3D"font-size:11.0pt;font-family:&quot;Calibri=
&quot;,sans-serif;color:black">&gt;;
</span><a href=3D"mailto:cip-dev@lists.cip-project.org"><span style=3D"font=
-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">cip-dev@lists.cip-=
project.org</span></a><span style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,sans-serif;color:black"> &lt;</span><a href=3D"mailto:cip-dev@li=
sts.cip-project.org"><span style=3D"font-size:11.0pt;font-family:&quot;Cali=
bri&quot;,sans-serif">cip-dev@lists.cip-project.org</span></a><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black=
">&gt;<br>
<b>Cc:</b> dinesh kumar(</span><span lang=3D"JA" style=3D"font-size:11.0pt;=
color:black">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:black"> DITC_DIT-OST) &lt;</spa=
n><a href=3D"mailto:dinesh.kumar@toshiba-tsip.com"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">dinesh.kumar@toshiba-ts=
ip.com</span></a><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&=
quot;,sans-serif;color:black">&gt;;
 hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font-size:11.0pt;color:=
black">=1B$BNS=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:black">
</span><span lang=3D"JA" style=3D"font-size:11.0pt;color:black">=1B$BOB9(=
=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:black">
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans=
-serif;color:black">=1B$B""=1B(B</span><span lang=3D"JA" style=3D"font-size=
:11.0pt;color:black">=1B$B#D#I#T#C=1B(B</span><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">=1B$B!{=1B(B</sp=
an><span lang=3D"JA" style=3D"font-size:11.0pt;color:black">=1B$B#C#P#T=1B(=
B</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,san=
s-serif;color:black">)
 &lt;</span><a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp"><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">kazuhiro3.=
hayashi@toshiba.co.jp</span></a><span style=3D"font-size:11.0pt;font-family=
:&quot;Calibri&quot;,sans-serif;color:black">&gt;<br>
<b>Subject:</b> Re: [cip-dev] [isar-cip-core v1] README.security-testing.md=
: Remove the credentials from console &amp; document them</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">On 02.05.25 07:20, =
</span><a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com"><span style=3D"fon=
t-size:11.0pt">Sai.Sathujoda@toshiba-tsip.com</span></a><span style=3D"font=
-size:11.0pt"> wrote:<br>
&gt; From: sai ashrith sathujoda &lt;</span><a href=3D"mailto:sai.sathujoda=
@toshiba-tsip.com"><span style=3D"font-size:11.0pt">sai.sathujoda@toshiba-t=
sip.com</span></a><span style=3D"font-size:11.0pt">&gt;<br>
&gt; <br>
&gt; The IEC 62443-4-2 certification body insists on removing the login cre=
dentials<br>
&gt; from console prior login prompt and document them as part of user manu=
al.<br>
&gt; <br>
<br>
We are qualifying an image &quot;as if&quot; it were a production image, me=
ntally<br>
subtracting anything that enables automated or manual tests - including<br>
hard-coded credentials. Let's split those bits technically and document<br>
that. And avoid suggesting that everything is fine if just the prompt is<br=
>
no longer showing a password - the well-known password itself is the<br>
problem.<br>
<br>
&gt; Signed-off-by: sai ashrith sathujoda &lt;</span><a href=3D"mailto:sai.=
sathujoda@toshiba-tsip.com"><span style=3D"font-size:11.0pt">sai.sathujoda@=
toshiba-tsip.com</span></a><span style=3D"font-size:11.0pt">&gt;<br>
&gt; ---<br>
&gt;&nbsp; doc/README.security-testing.md&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; | 7 +++++++<br>
&gt;&nbsp; recipes-core/security-customizations/files/postinst | 2 +-<br>
&gt;&nbsp; 2 files changed, 8 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/doc/README.security-testing.md b/doc/README.security-test=
ing.md<br>
&gt; index 213fc82..9696892 100644<br>
&gt; --- a/doc/README.security-testing.md<br>
&gt; +++ b/doc/README.security-testing.md<br>
&gt; @@ -25,6 +25,13 @@ Save &amp; Build<br>
&gt;&nbsp; ```<br>
&gt;&nbsp; host$ ./start-qemu.sh x86<br>
&gt;&nbsp; ```<br>
&gt; +# Login using the following credentials<br>
&gt; +```<br>
&gt; +username: root<br>
&gt; +password: CIPsecurity@123<br>
&gt; +```<br>
&gt; +IEC 62443-4-2 certification body expects to remove the credentials fr=
om being displayed on the console prior login stage.<br>
<br>
This sentence does not belong here.<br>
<br>
&gt; +(Warning) CIP users are strongly recommended not to use CIP default c=
redentials for production images.<br>
<br>
No, this MUST never be shipped in production, irrespective of any formal<br=
>
certificates. This here is a TEST image, not a PRODUCTION image.<br>
<br>
&gt;&nbsp; <br>
&gt;&nbsp; # Copy security tests in to the Linux image<br>
&gt;&nbsp; - Clone the cip-security-tests from following URL<br>
&gt; diff --git a/recipes-core/security-customizations/files/postinst b/rec=
ipes-core/security-customizations/files/postinst<br>
&gt; index daade83..15be659 100755<br>
&gt; --- a/recipes-core/security-customizations/files/postinst<br>
&gt; +++ b/recipes-core/security-customizations/files/postinst<br>
&gt; @@ -6,7 +6,7 @@<br>
&gt;&nbsp; <br>
&gt;&nbsp; set -e<br>
&gt;&nbsp; <br>
&gt; -echo &quot;CIP Core Security Image (login: root/CIPsecurity@123)&quot=
; &gt; /etc/issue<br>
&gt; +echo &quot;CIP Core Security Image&quot; &gt; /etc/issue<br>
&gt;&nbsp; <br>
&gt;&nbsp; # CR1.7: Strength of password-based authentication<br>
&gt;&nbsp; # Pam configuration to&nbsp; enforce password strength<br>
<br>
Let's argue like that: Anything that must be kept for a production image<br=
>
must not be contaminated by setting that are just for testing purposes.<br>
In that light, having our test password inside a customization package<br>
that could be reuse for a real image is a bad thing.<br>
<br>
Jan<br>
<br>
-- <br>
Siemens AG, Foundational Technologies<br>
Linux Expert Center<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_TY3PR01MB11075B09AA1BFCDF5DACB3519C723ATY3PR01MB11075jp_--


