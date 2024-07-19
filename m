Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71298C3DA5D
	for <webhook@archiver.kernel.org>; Fri, 19 Jul 2024 06:57:53 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.215.53])
 by mx.groups.io with SMTP id smtpd.web10.13475.1721372263120360387
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jul 2024 23:57:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FzQmyQ5V;
 spf=pass (domain: siemens.com, ip: 40.107.215.53, mailfrom: srinuvasan.a@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBpa6ncJS1UG7ykyGicVdNqeN/dMHGtSEn5S03vDd9Mmtruiw6U6MrPuSuVtNKWkUBDlmHxe79UNuUr+Wdekrh8csoWFZbBDk4mhWpeSbO1F+M7ZGib6RYxpAQ0wtMSI7GlXfGWmJ7w/J3CtOjaZGiIZK8C7PNNv/RRt5F+DFcgkn8uK/Q24glTlA8ttJ9gxEUJD1V1AuG6dZh/6MmTq6wCkGEXVvfYmYO50Bb/l83+uQ1V0f1Tyier0nj5AbiH7YAcd3Hr3KzI7+bvBbj7E+DZG5RY70PNHyl+Pw3wr2S8MCKBR4lb3bf/3nKPke8lmO/w4MimMPuDlNQfZ/WOXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6SS4rz7DIBOVJjjd2zO9esKt/+LCo6IRhVVtX2mnZ0=;
 b=C7VFDwtBkp5S2VYZNDKqC0cdXqYt/blt4H9Wv/H1kThFoknHC1jNFD2SuluSzx0iRArsjVuIzYhUcfzIWhyxOpb3l2TTer7+X+P23d454CRGXGlDOvN4yPBvM3+P5x0oFATc43RELbVfC7I7RYOx31XsS7APO0hYgI33w6ata0h8ngd270/sVMQ5s/sx83P1zPOJMZFxICPK+5qDfwooFj/tkLaS/F6TQVvWy5d9qOVOvMlRcxviln8jlj6UsdIUaDT0vCBlH0IXxrgdSaNcImfIjZdQjUSL/ySyyEfX6Zbp1nctB1pW5SwDGpnpFtQYTJHnwSlUFf4DHiBR3MzVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6SS4rz7DIBOVJjjd2zO9esKt/+LCo6IRhVVtX2mnZ0=;
 b=FzQmyQ5VbMAageGEAIR4AfzWJk56isfZRMfelFwndFK8bBTW14Gh4bH7K3KFIZYIlVcCS7rsqwIybLKIXHFUJ7za2nYAPPplrrPOmjEgxHNQB0IMYlcb+xNadTrG6qVix30nCHFDVX0tQkns9skD6pM/CYzjT0Ufsg6v6YbrQRzFtVRzrajNbEyeJ8hpkYTP0v8+cdnE4JbwzSaVUUOl9A6elhNwfKxsQS5Rpj/xC1K0vzKQepbfiqyFaGkDPY2E8jT1rYdZUi0NGPp2zZr8mrkPnW2qnNct8jbewcryz6mbB/AxiubjkfRVkIhMLJ1wpJyZ+Gpx4sDyXtltn9YT/A==
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com (2603:1096:301:f4::12)
 by SEZPR06MB6571.apcprd06.prod.outlook.com (2603:1096:101:185::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 06:57:37 +0000
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::d3a4:b94e:29d0:29e5]) by PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::d3a4:b94e:29d0:29e5%4]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 06:57:37 +0000
From: "Arjunan, Srinu" <srinuvasan.a@siemens.com>
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: RE: [isar-cip-core] [PATCH] classes/squashfs: exclude boot dir during
 squshfs image creation
Thread-Topic: [isar-cip-core] [PATCH] classes/squashfs: exclude boot dir
 during squshfs image creation
Thread-Index: AQHa2QFQCCQbzuqNmU6hcjMqNGVQALH9n00AgAAAUlA=
Date: Fri, 19 Jul 2024 06:57:37 +0000
Message-ID: 
 <PUZPR06MB5747D7A43A5869C191101C3B88AD2@PUZPR06MB5747.apcprd06.prod.outlook.com>
References: <20240718105718.11562-1-srinuvasan.a@siemens.com>
 <284ef2098da5aaeff02a565c4316fff854add437.camel@siemens.com>
In-Reply-To: <284ef2098da5aaeff02a565c4316fff854add437.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-07-19T06:56:44Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=fd648441-ef3a-4e07-a4d8-f4d8134f7a15;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5747:EE_|SEZPR06MB6571:EE_
x-ms-office365-filtering-correlation-id: f4617377-656b-4cac-fa7e-08dca7c012d8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dkxHY3I2VysyRmprYjZYUWZGVVBxb0NkUzZEQmM5RnBoUGxuY1p6azM2RXJs?=
 =?utf-8?B?eGI1RzhWd2dySDlxV01WamxiQXZYMzk3ZEdqdW9oZU1lM3BOQUZEUzBpNVdY?=
 =?utf-8?B?UUJDMlJQWEl2ZmRDbFU1cDRaOXp0dXFwUjMwOFFDVW1LUG9KdUxoMTlOR2Zv?=
 =?utf-8?B?SC93cjdlTHA1UkVYT3BIZTRpbnppeDZqK1hrSlQ1V05YMTNhVEUycHU1d2E3?=
 =?utf-8?B?d1l2bzJaY3FxMFFUdjRWNVZWa2ZKRkNPb3o0ZXZwclpiMHlIYThHWXRoU3VZ?=
 =?utf-8?B?dHo3UnpGK1RiNFdTT0kyTEdYWndmWG1TN3VGa2NpWVJybTI3RXBxTGpHRnV6?=
 =?utf-8?B?dTFxVEEyUmQ1bGxGV1YvVlhsR0ZUVEJhQkxhd2QyNlRpc0swNjBsdVBXV201?=
 =?utf-8?B?YzFwNE5pQlNuOC9qNnhLVGdxbEVYZE9LL09IQjFUWTRVSnhqK3l0aG9TT0w3?=
 =?utf-8?B?UWsyejR2YkQ0b2dSbmRHMGR0WFhBUWk5anBteUlEMzhWUGNtR3hYc28wUG5M?=
 =?utf-8?B?YmpjUXIwbzNpQmF0bmF4eWVDQ2NWNngyTGZpcmJkcEEyeGI0QWozcWZVMVZ2?=
 =?utf-8?B?OXZHdDE5M0dPc1VXY05CdDcwL1hCM3lKdHdqd3VLYnJ0K2lOeGl4VThDK1Fi?=
 =?utf-8?B?OXRTUGlLcERmMDNkWDZNWjdnNXpTWSsvYkpXM2x5OWE5N3hOa2tpOGJjTit5?=
 =?utf-8?B?YzVab1JlWWtHTStKM1FTTENnLzVjQ3p1L1VuUU5XVmw3MkExNGNkRkRZdkRq?=
 =?utf-8?B?TWhqV0o5ekFPYkV6M3EwTnJaaC9BaUpjQ2ZWRks0S1lVL3dLRG1WS2lvOXhl?=
 =?utf-8?B?anJlNVRnSXdPWUphWXlDb0p3enlRQ1Zuc1JQamtscXUvbHY0RS83NHM0QURu?=
 =?utf-8?B?bG4rREMwc2NIcVIvTXlMWkJ4TFkxaDVsd2hsamprWlU1ci8xc0JGOWdySy9Z?=
 =?utf-8?B?U3dyWjkvS3lwMy9qbEhsdE5PUnZhVUF6dkFCSHFUbEMwQ2N1UlhpWVFnY3g0?=
 =?utf-8?B?YjRZOFMzdlRLTExzYWQveENCdDhJRkdWOEN1VVhNbm5sa29TUE50MngyL01u?=
 =?utf-8?B?N2tMcWJrU1h1NlZWSFZMZXBrY2lueGdwb1JyOVF6K1krSHY1YUJPRkNrQXZM?=
 =?utf-8?B?c085bnpSaENLWWpaTVFYTFlnbVJ1SXlONzh0aVArR280TXVid2RqRENqWnU0?=
 =?utf-8?B?SDBPZ1JVYXgyUzN4WGRDSyt5VmhpZkNlaUNPSnp0em1rMEZqbExDd1NldmhJ?=
 =?utf-8?B?aVVtRXIrcVhRbnRYZ1NaRk9VdUlMMHFVSzV6Vis3RDN4NlNqNUp6MDFrK3VY?=
 =?utf-8?B?cWhkcWRoa2ZyQzE1a1BTK2hzQWNSNVk5eDZJbm5yUlJmZFE1bWtWLzZBSm41?=
 =?utf-8?B?SWxnV21wRGVCY3IvR1l2NzhXZVIrKzA3VEpQUDhuUEl1enh4WXZONWFLVUtr?=
 =?utf-8?B?NTd5SjAvVU1BWnF2akpvK1FqalJkMmF3L3RRWnBHb21XN1BVWE1RSEN6MkVG?=
 =?utf-8?B?U3RHNGtQZW9ZcEJvM0hpT0VDeHVCbHdnYUlHWngwRnNFblI5aFZCUyttNW1G?=
 =?utf-8?B?a0x4empjSC92N3poa1d2RmZVUlZBNnhvNGdSaStjb1JTeUNVRmVtRSs3UGNX?=
 =?utf-8?B?U01CUW5QTHJiclY5NG9wRmd2M3VCSlFWTm5CQ0RDU1Z3T0pSVXlNQkhTV01C?=
 =?utf-8?B?TktabWx4SWlNazdEbEVld2lHMVhJYm0vbWVnTWhBcmhDdmNlamM5WENEb3la?=
 =?utf-8?B?TWVBdW1yVGRZbXVsWmMxVnF5K2dXczFjRGtkNVNRY0hLdTlWSit3VVpOdHdt?=
 =?utf-8?B?M2h2eFdwOVMwbWtnanFnQVBmeUR3K1VXMXE4RXlId3R5SHl2dVl6WTIzQ2Vp?=
 =?utf-8?B?b3V4WjRjMENpRFF1RXAxUDJBNDlyOVVnSkROWThXbmV4RkE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5747.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Si90OFl0Uk1OaHRSQ25kWkdlRHZuWHNUKzh5QkFSYXBXQzRzREFNVStTaHJM?=
 =?utf-8?B?TEx2VXhQd0tubkUwc1ZiMjhRM3dIN3laMTg2dkE1YnJkTWJiQ09Ic0dqcVQ0?=
 =?utf-8?B?UnNmdDVGSi9wQVFjQWs0NHlybWxDUC9PS1U0eVV6Zi9rS2EvZkVocG1zU3B2?=
 =?utf-8?B?YjI3QTFHaTg4Vkx0dGkzcnM5ZzVzRWh6WDNwdEZMMEE3Q2podi8wRmNNeUVu?=
 =?utf-8?B?bU5SV2dIU0k4cDMyOFBtbjNSUXh6eTNPaUdHQVFkb3dRR29iYUJCNTNVS0FS?=
 =?utf-8?B?Y3Q2VWFtdWxkYjZsWHhmS21sSkJXYU5lYktXOHg0TnFCNzV0Qi9oWWVSczFr?=
 =?utf-8?B?cDVmNGFBWDA4SjdNekhySDh4akZxMGtDUmpyQVhZQm81UGJMdStsbTNFdFdz?=
 =?utf-8?B?MDV3SjI5UHRhSGVxdWpzNTBaeHpFaVU4YWp0MTROSHZFMmJBYXVCT1JBSExM?=
 =?utf-8?B?NTU5dEQ5MXhLM3R5MVY5MVJGdVAwTk5CbXFxdmc4SE9vc1JmUEFaendWUDgx?=
 =?utf-8?B?cGEvdWZaZkgzMjlwb1RLYmJoaUFBdEQrNmtoWEFhYTd0dS9MQk5hS1p6ZXc0?=
 =?utf-8?B?azAwNVNzOG9oOWhUQ084REowblJVMzRzWERqNDQvd0V0c0pwWFViU3hMRmUr?=
 =?utf-8?B?MXI2ZFo1SkYxdXp1ZHNGU0NGKy9HVTZwMkpiRk95SGVQWHptbklHZ3RKK1dQ?=
 =?utf-8?B?a3dvdmRGWGt5K3hBclRCRDg5bkRmUFF0NmpGNC8xWHA5SExZRENLRzV5Yytj?=
 =?utf-8?B?cGdjTTB6eTJMeVhtRVhsazlLQ1VXclREdTZ0cDMybUZVeG9oWHVwRytHdzhr?=
 =?utf-8?B?QnVyK1hkMkxRTSt0Q21MY0hsRHdDekhkd0lZY2x5a0wvdWRvN1RLVTZDdStC?=
 =?utf-8?B?VmNXVlNGS1FLcDdET0VaUEE3TFNiT3YzODB6UGU1dnpsOXZsdlQ2dkdCTGF1?=
 =?utf-8?B?bmxBSkRYaW9MMWc5dkg0K2ZLMHQrb2d1RkdGdFRNNVZoUXZnaE1mTFNKQWRt?=
 =?utf-8?B?Tlc0eHFRRThqc24wcFBQVEVxekpiQksxTXk2L2d1Yk5zUEx5VEFSazc3cUtz?=
 =?utf-8?B?QnZTd3VqcjJBUWYrZUYrQnFRVi9wbitnOFU5RWFKY2FWZnZlNHlVK0FpMUxi?=
 =?utf-8?B?d0o2cy9Od1JtYUxpY0djT1RUaHowbnFQQkl1QXZoZWdEMW43Q0NyQ2dMVDQ3?=
 =?utf-8?B?MGZZcUJ2SWE1bXluQWp2WmtmT1QvZzIzWVE2YzZhVEduaXVvZjB5OC8xelhS?=
 =?utf-8?B?RUVoSHJwM2E5aEhJbHNtck5wQUNSbEZ5WUFMdlJGRmZwOW9OSHArSHgwMmlk?=
 =?utf-8?B?ZTJEZlc1WWo2QmRBa1FSSHdGY2xUY0xoT1RldFhObWpjN29LVHdGQUphSE0x?=
 =?utf-8?B?RmtXMHdPTG5GWTZSY29aOEFuTkwxMURZWFYwa3RwODRnLy9HcVI3cjd2ZzMy?=
 =?utf-8?B?VDJka1NoK3YyQ1E5bURmb3RoUDBieHA1Ly9meGtDeGMvaDh1anZKTG5sN25Y?=
 =?utf-8?B?bEJoS25DSHYzZ3VyWGlQb0VqWkk0VEdObkhjTmxyQklWQkZpS2pVVm5WVDBa?=
 =?utf-8?B?TlZtZzgxR29lOWZ5WFI0aVRxTzdkRmc5aStjVDdrdmYxeG1QdHVQZEd1MnJX?=
 =?utf-8?B?VlRRRXNHWVNwcU9sZS9FcUtXdkFXYXBFSVIxUGMxcFBsaU5SSkc0ZnRwUEZm?=
 =?utf-8?B?dTFsT2pXbU4zbEliK2FDUSs5WXIwY0NxZDJUcFlkbXVPb1ltdnoxWVhCU0ZW?=
 =?utf-8?B?VVFYU2g3R1ZWeE1pd2VkQUlpdVhEdXBCUHc4TjB4NEZCKzB6VldQSiszM1Iz?=
 =?utf-8?B?cUFTWDBlUXJyeXFRbHErV29OOVA4SEZDaFgvZzJyN241dm5SUXQxU3VuUmpK?=
 =?utf-8?B?WW5uZU1IUm1nOUV3TmdGK1hVSnBCV0pUMjYxeHd1NTUydm9jaUJ3c2YzNzhP?=
 =?utf-8?B?YitWYXZJVG9zQ0pKM1kwMkVZR0RDRlF1NXZkbUhEL2ZUak1ybWYyeFhTcjFL?=
 =?utf-8?B?RDN0UzJkaXRrTjRBRVI4SGdSZy9LdDh4L09YelZ4dWV0ZEQrL1lhdWJYZHlE?=
 =?utf-8?B?U3hmdFM4MTFOcEd1S1BUVXllSUQrZ1NGbGpTL2M2eksySk5ZSTRKZExmRmdW?=
 =?utf-8?Q?SJ9XO2AHBjLntZvWwuA8xx/di?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5747.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4617377-656b-4cac-fa7e-08dca7c012d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 06:57:37.1429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CoJjdeIhIdy+E9zp4dQbANw3EGK/FsWmhGuJZGGzATmJT60xebG5TpegwJNg8wygK8QsLhhcCIwzdQzg5b+NUxOTR1YATrnYD0pHUeZgO1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6571
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jul 2024 06:57:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16592

SGkgRmVsaXgsDQoNCg0KICAgICAgICAgICAgICAgICBTdXJlICwgdGhhbmtzIGZvciB0aGUgc3Vn
Z2VzdGlvbiwgbGV0IG1lIGNoZWNrIG9uIHRoYXQgYW5kIHNlbmQgdGhlIG5leHQgdmVyc2lvbiBQ
UiBzb29uLg0KDQpUaGFua3MsDQpTcmludQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogTW9lc3NiYXVlciwgRmVsaXggKFQgQ0VEIE9FUy1ERSkgPGZlbGl4Lm1vZXNzYmF1ZXJA
c2llbWVucy5jb20+IA0KU2VudDogMTkgSnVseSAyMDI0IDEyOjI2DQpUbzogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmc7IEFyanVuYW4sIFNyaW51IChESSBDVE8gRkRTIENFUyBMWCBQQlUg
MikgPHNyaW51dmFzYW4uYUBzaWVtZW5zLmNvbT4NCkNjOiBLaXN6a2EsIEphbiAoVCBDRUQpIDxq
YW4ua2lzemthQHNpZW1lbnMuY29tPg0KU3ViamVjdDogUmU6IFtpc2FyLWNpcC1jb3JlXSBbUEFU
Q0hdIGNsYXNzZXMvc3F1YXNoZnM6IGV4Y2x1ZGUgYm9vdCBkaXIgZHVyaW5nIHNxdXNoZnMgaW1h
Z2UgY3JlYXRpb24NCg0KT24gVGh1LCAyMDI0LTA3LTE4IGF0IDE2OjI3ICswNTMwLCBzcmludXZh
c2FuLmFAc2llbWVucy5jb20gd3JvdGU6DQo+IEZyb206IFNyaW51dmFzYW4gQSA8c3JpbnV2YXNh
bi5hQHNpZW1lbnMuY29tPg0KPiANCj4gRm9yIGFsbCB0aGUgVUVGSSBiYXNlZCBic3BzIHdlIHVz
ZWQgYm9vdGxvYWRlciBhcyBlZmkgYm9vdGd1YXJkLCB0aGlzIA0KPiBsaW51eC5lZmkgY29udGFp
bnMgbmVjZXNzYXJ5IGJvb3QgZmlsZXMgdG8gYm9vdCB0aGUgc3lzdGVtLCBoZW5jZSANCj4gcmVt
b3ZlIHRoZSBib290IGNvbnRlbnQgZnJvbSBzcXVhc2ggcm9vdCBmaWxlc3lzdGVtLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogU3JpbnV2YXNhbiBBIDxzcmludXZhc2FuLmFAc2llbWVucy5jb20+DQo+
IC0tLQ0KPiDCoGNsYXNzZXMvc3F1YXNoZnMuYmJjbGFzcyB8IDIgKy0NCj4gwqAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9j
bGFzc2VzL3NxdWFzaGZzLmJiY2xhc3MgYi9jbGFzc2VzL3NxdWFzaGZzLmJiY2xhc3MgaW5kZXgg
DQo+IGIzOWJlMGMuLmY5YzdiZjQgMTAwNjQ0DQo+IC0tLSBhL2NsYXNzZXMvc3F1YXNoZnMuYmJj
bGFzcw0KPiArKysgYi9jbGFzc2VzL3NxdWFzaGZzLmJiY2xhc3MNCj4gQEAgLTIyLDcgKzIyLDcg
QEAgZGVmIGdldF9mcmVlX21lbSgpOg0KPiDCoA0KPiDCoElNQUdFUl9JTlNUQUxMOnNxdWFzaGZz
ICs9ICJzcXVhc2hmcy10b29scyINCj4gwqANCj4gLVNRVUFTSEZTX0VYQ0xVREVfRElSUyA/PSAi
Ig0KPiArU1FVQVNIRlNfRVhDTFVERV9ESVJTID89ICJib290Ig0KDQpIaSwgd2UgYWxzbyBuZWVk
IHRvIGV4Y2x1ZGUgL3ZhciAoYnV0IG9ubHkgZnJvbSBib29rd29ybSBvbikuDQpCdXQgd2UgbmVl
ZCB0byBlbnN1cmUgdGhhdCBvbmx5IGV2ZXJ5dGhpbmcgYmVsb3cgL3ZhciBvciAvYm9vdCBpcyBy
ZW1vdmVkLCBidXQgbm90IHRoZSBtb3VudHBvaW50IGl0c2VsZi4gSW4gY2FzZSBvZiB3aWMsIHRo
ZSBzeW50YXggaXMgPGRpcj4gcmVzcC4gPGRpcj4vLiBJIGhvcGUgdGhpcyBpcyBzdXBwb3J0ZWQg
Ynkgc3F1YXNoZnMgYXMgd2VsbC4NCg0KRmVsaXgNCg0KPiDCoFNRVUFTSEZTX0NPTlRFTlQgPz0g
IiR7UFBfUk9PVEZTfSINCj4gwqBTUVVBU0hGU19DUkVBVElPTl9BUkdTID89ICIiDQo+IMKgDQoN
Ci0tDQpTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQpMaW51eCBFeHBlcnQgQ2VudGVyDQoNCg0K

