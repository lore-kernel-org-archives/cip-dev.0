Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F08C02182
	for <webhook@archiver.kernel.org>; Tue, 21 Jan 2025 11:37:12 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.55])
 by mx.groups.io with SMTP id smtpd.web10.14164.1737459429876142740
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jan 2025 03:37:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=jWOKlNDa;
 spf=pass (domain: renesas.com, ip: 52.101.229.55, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BB3MAUjzDp4hOz4bL4OEFxmCiDinnNnvHPfxy0Xik8/P6aqTXox4tPUIipzk6DRaHmbDXZTc+Ukjxjoz7kVtSTd8Zyv7myS61ud4i3IHt9oVMMBynmR7QeiHLJMQ4g+aBLboFptrqxRdep+3pFtdrjwZwYbLUIzO5aHvNm6jQ9kHM34ZpW8UxNp3SThhtldDwlgi8R129mpBkHWGM1XrM87qdlWIHxUw5xuDiOCWHmH7JMxeb0lkIvLDlsQq91wSaIe2uE6ZvFtPzGfnH62LZ5HSp9HdLDcmiFbBE3PSN5KJhcrERf30yJNHeEBeQXMVtzA9xwagsfgipuhO9gYyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1EdRwGmxYqsVZFQzAFS8ISGd3DwwpOVsQRNkrrvokI=;
 b=Yvwf4dWm+z+Hr7IiObOmEQ5ub/HNEUAxo8t0MPb5xSIAUKsRjIaqk5BPrm4zqssbZHQOB3C2ruojBbVcjO8zWBNQIS+SNGB9qNeNF4eEtBv79sKuEqq3aFReEstzZb1tOTS27BdP63nokM6ur/2bDOzaCvKtww5J1A3ssnm1hhzpvj6aTkbzwC6oGugy41/g6AvORcGlf4owhmu/C5qH7R9MbMIr60RkFTSw9SyhkMr4vQqnKxnwesitRuQ7VA5ywDJKNQRjWiUcfKqMl6eU0JEXBVH9Be5qmRAnbPnyyx0Qc3UrX7hJKRZQNqpWiQlB/3tE0/+HFGUZa9CtqTpC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1EdRwGmxYqsVZFQzAFS8ISGd3DwwpOVsQRNkrrvokI=;
 b=jWOKlNDaqx4ug69S5ay+WKFLE9fSCe67pOQb4JFmwcNtc3xktPuxTd65T6BS2Lxhno0uk8Ca5nFRMdKoMn6RVZCfcqHXlT/PKq0gsaNwqKiUTRGF83m7IAvvepOKLPXgE9PJwNSKJVzcx4TB+AHqXo8UNAGhBLMdK6ej4IkPnIQ=
Received: from OSZPR01MB8401.jpnprd01.prod.outlook.com (2603:1096:604:16f::7)
 by TY1PR01MB10688.jpnprd01.prod.outlook.com (2603:1096:400:327::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 11:37:06 +0000
Received: from OSZPR01MB8401.jpnprd01.prod.outlook.com
 ([fe80::c9a:aa8b:f8ea:998b]) by OSZPR01MB8401.jpnprd01.prod.outlook.com
 ([fe80::c9a:aa8b:f8ea:998b%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 11:37:06 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>,
	Gylstorff Quirin <quirin.gylstorff@siemens.com>
CC: "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
Subject: RE: ltp (syscall) failed test in CIP Security image with
 isar-cip-core v1.6 on M-COM
Thread-Topic: ltp (syscall) failed test in CIP Security image with
 isar-cip-core v1.6 on M-COM
Thread-Index: AQHbUuTAhee4QvOabkGKuX6gapV/KLLvWeRwgCiiEZCAAvIAEIAGXZKg
Date: Tue, 21 Jan 2025 11:37:05 +0000
Message-ID: 
 <OSZPR01MB8401759CA7B581E1C8D0BE2AB7E62@OSZPR01MB8401.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AAC4C7533384E6C3CE8CC2072@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OSZPR01MB85159B1B29203FFAC3458D6ABF072@OSZPR01MB8515.jpnprd01.prod.outlook.com>
 <OSZPR01MB84010B4C962BC73DD1466779B7192@OSZPR01MB8401.jpnprd01.prod.outlook.com>
 <OSZPR01MB85158D80663768F0ECD9D96CBF1B2@OSZPR01MB8515.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSZPR01MB85158D80663768F0ECD9D96CBF1B2@OSZPR01MB8515.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8401:EE_|TY1PR01MB10688:EE_
x-ms-office365-filtering-correlation-id: 9733a0f2-ec64-4ca4-9cb0-08dd3a0feecc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|13003099007|7053199007|8096899003;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SnUvWStuOVI5enNEVmxwOXRSU1pEWEVFbW1mTVdWb0ErY2NiOWgreGVF?=
 =?iso-2022-jp?B?TEhPZUhiYm9QZFBQYXJUL24wSFJ3cGlHL0NDVzNURjhHMEsvSnhvZ0Z6?=
 =?iso-2022-jp?B?ZEE3RDErbDVyNi8weVNvWkpqTjUvREs0VW1FdTdrS3pmTXI5SzNDdFgy?=
 =?iso-2022-jp?B?VENvaWpIa3FjOHFobDRmaFc0VXR2R1hjc251WENmVEhlL0lJZTFlZ0tp?=
 =?iso-2022-jp?B?bHprVklYMldMNEk1MzFleGRyM0c1R3ZxTmxDZnl0THNKeEU2N0V6THFv?=
 =?iso-2022-jp?B?WmVoRFlNakdDMTBySmVZQ1UvRnNZOTV2ZjVTR0s3QlV4TnZaMHRTdjBH?=
 =?iso-2022-jp?B?ZEQwTThrZE91TFhYM3h0TlNmL1g3UmVaVXVvVmZ2bitaSlBwTGp5VUd3?=
 =?iso-2022-jp?B?ck90Q3lLV0YyNHVZcVR3K2wxV1RJQUF1VmZZMjYxSHYxTkVnZks2c0dq?=
 =?iso-2022-jp?B?K3dqOGxzMkRYV0F5N2JTbWJRMURMRUplQVdJRzBSdU1qcGdSbnVSM2hi?=
 =?iso-2022-jp?B?TzRwTFlyUFQ2Tm52bXlLNDdmZlQxUTFsbXRid3FhTkFRRFB6S2Y2WWxz?=
 =?iso-2022-jp?B?REthVHdtWnVBMWIrRkNOVG5HNklXR0JZYzRPSkNDTGhqU1M2cmlCOVNl?=
 =?iso-2022-jp?B?emJlQWJ3Y3NnR2JLSk5qVDcrYjkyRUdDRjhsOUFvOUQ2b25FZDczdGVq?=
 =?iso-2022-jp?B?NHVkbEsrRVkwbW5zeStwQnFOWUxDaEhDcUlzcHZxSFdCVFVvamh5R0g4?=
 =?iso-2022-jp?B?M01hTlBFRXFPaCt2VkZDQkJTS1lrRDJURER6UWxobTBFaWZvWGdJaVhs?=
 =?iso-2022-jp?B?dnp2SXQweWFFVnE3QksvMWlSdDR0dXZwQTNtdVJHaDZkdGRnWUw1VGlK?=
 =?iso-2022-jp?B?OFdXS3dySW5JRDQ1QUIrczNnUDBqZzBOYnFmZTRvRytYU0Y3d21zWkNZ?=
 =?iso-2022-jp?B?VWdUdmNDaW9GeUZzdUdDK0JvY0pJRCtIUWxMRlNoWHphL1hzVGZxbWtu?=
 =?iso-2022-jp?B?bjVybTNaQ3VTNE1CbHE0azVNYk1QS3BySlovUzNmNEQ5MlBLZ1c1c3dD?=
 =?iso-2022-jp?B?c0ErRTY1T0RUa0Yxa0pYS04vbCtORFd2UVdMWW95TVRiTnBsR2tSdG1O?=
 =?iso-2022-jp?B?all0aFJjRmE5VVJjWUpoOEU2Q1BjR0k3RnN2aHZxbjdaUHRYQ0tvL2RU?=
 =?iso-2022-jp?B?V0hYb0p1ZzlyTjN2V2NObWdGeE42NlV3cjg4SjBielZQanQxUkhDb09M?=
 =?iso-2022-jp?B?dWF4OEZtVzNxYXE1U29nZ3NKaWhTN3NIdkh6QTQ2VmpZdVhCU3ZTaFdo?=
 =?iso-2022-jp?B?KzgrWERWbGRaejVjcHNnZ2owU3NEWG83N1FOTUJ4dTNucHo4bXdEYUtB?=
 =?iso-2022-jp?B?bXFyMnNFRmdtZEVZUjdUV1pGT2YrY0dicWQ4MEVkQ0luaTVxRE02Y0VG?=
 =?iso-2022-jp?B?aXBFWHRDQjQxU0djQzZCM1VjQUNmaDRrYThGakxxZFZ4a0lyWWRMc2VP?=
 =?iso-2022-jp?B?VDFzam40aXd3M2Y4bzUwcnUwTlgwZk15S2hwYm14emJRV281SjgvNVFK?=
 =?iso-2022-jp?B?ekJzRm1YV0RlcXV1a2hxcjVtMmN4V1ljRDdRRW82azVvUVZhQ1VsSXds?=
 =?iso-2022-jp?B?RTBWdlRVYUtweW5GbFhWclRTTVVrWFRQQUE0ekE2MDJCUWtFdVJMcUZR?=
 =?iso-2022-jp?B?Y3RySzJpaXpnYlFFZDY5ZEV4MW1CMWhmVmRlejhEd2JvRVBjRUY2WU9k?=
 =?iso-2022-jp?B?cGUvZklmOFB0NXQ3Wm84cFJUbURZZ1pzNGo3VVIvT1JLZUNrOGhnQzV2?=
 =?iso-2022-jp?B?OUhyRlFUQ2Q2aXhDMWZiNXhjYkJWV1VZckpTcXJXdGNCNDh5Sk1pTnBC?=
 =?iso-2022-jp?B?cXF1Y05WaVM1bU85RitZcnVGd1A4WnpyZERLeGsvYWtGc3hSZDlKOHBX?=
 =?iso-2022-jp?B?eUJnR0hGZUYrTWtydHpBelBHN2hocHNhR3diYXYrRHg2bHFLR05ERk1s?=
 =?iso-2022-jp?B?eHNGSXJvMk13bjI4dXJuZVlzOXF6UE9PUG8zOSt5T1h6T2ZtSk1CazF3?=
 =?iso-2022-jp?B?L0E9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8401.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(13003099007)(7053199007)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?a0JCZXZ5dXNHem1hcERjVEorKzZMT1lhbThCdEdraWNZdUVMVEk5c1cv?=
 =?iso-2022-jp?B?SzhnNDJNRFMrK3ZoZmdPQWNGOWc2YWVMOUg2VWpVcHMveUhwRTBWVmdW?=
 =?iso-2022-jp?B?SEtzYUtMYzdUOE1nSHRhOHFuMmRldHd3ZkFMZjNtNUpGS0t6cWlOTHY1?=
 =?iso-2022-jp?B?Nmhxb2dTaS9pZXZyaExUUHJ1akpoMlVMTFF5Ty9HUWorcDdTN0dTRk5I?=
 =?iso-2022-jp?B?R2NDd1lTdVoyVUpwT0J5MnM4aCtEQ0ZvcWFGUWlvaXZGVmRIOXJZenFY?=
 =?iso-2022-jp?B?TEhUWnl4c0VQKzJVVXFvc1NsaDJqY2hyMVg0R2ZEVURqOGx4MWFHbHRZ?=
 =?iso-2022-jp?B?T2RZTEJqZzF1bDZRK3ZGTDVvUFBYMFFLZGdDdjIxakprR2syU3JQeU9Z?=
 =?iso-2022-jp?B?Q2hPSllYL05Ob1E2WW52b1FROUtrcm5XckRtRmsvREtycWI2SjllVEZu?=
 =?iso-2022-jp?B?MGJrbjdYcTlYTFZ1NVFwUk5yTjFLdElvR2xWejJVM2txem1OU2kxSVJ6?=
 =?iso-2022-jp?B?MkhUKzVQSkZPaksrSUlVT0ozQnkvaTJseFZQY1MycksxSFhnT2V0ZTcy?=
 =?iso-2022-jp?B?UDhXYjRuV0VWQzUzSUp0eUhZRzg4U1VIeTVrUDliY3dITWVpOFdDRCtG?=
 =?iso-2022-jp?B?SVIranIrQTl6dmlRU1lyZ1lpbmVaT2c3UlNDOTJsYzU4ZU9VZS9BY0Zq?=
 =?iso-2022-jp?B?SXh1TFQ3M0pLdUNIS1NYTG4rZldPQmpGcDhUWWRDVDFBZjk0Y0Fla3ZU?=
 =?iso-2022-jp?B?eWN3L214eC9uNU45WWp5RXZGazBYWkt6d2NwNkNiUzZ3a0o2MStGUURZ?=
 =?iso-2022-jp?B?cU5ZSnF2SWYycElURDZ0YjB2SllTWHJYRnd4MldTZmxqcENFUzQ1ZGFU?=
 =?iso-2022-jp?B?L2hMRktPeStFb1dxa2F2Wm1WcWcvUlBpTzBrcG5YR05hb3RmL0IvQWxv?=
 =?iso-2022-jp?B?eTFnb215OFNCUk5HdFMwUzJsVStLY0hyb1FhSmdWeU05UVdqb3ZOay9P?=
 =?iso-2022-jp?B?bUVJOUlaNFhTMU9KQktxRk5hSzh2Ym1RU1JRaUZDY3JsT3NjM0RFTVYx?=
 =?iso-2022-jp?B?RjdON3NJb1pPTEc2cm5maDFHNm9oMWJxcVpHMHkrSk9ETC9zb2FnSEF2?=
 =?iso-2022-jp?B?S3BONnBzSUJOVkFubFd5M3V5blQwSmZOYi8vL0lQQzd2cm5MeW5QMHBB?=
 =?iso-2022-jp?B?Skg2dC8yc1NOYnVDbjhSc1EvaGZsUGZpSmdXZ1Z2Zk9CbytZeUxnb3Fa?=
 =?iso-2022-jp?B?LzlvQ2JHT0R3SHZhZk54QjVhM1hsb1htY2FzNFEyTkxKSlE3OEw0Qmxk?=
 =?iso-2022-jp?B?L3JHRWdUOGZ4b1pZS2gyaGZKTGJUbUFHS1Z2QnFzeGE0NGhzaVNkTEhP?=
 =?iso-2022-jp?B?ZW1XSHhkZzl2ZUNwRnF1TUFUb0xPRVlJQnBVVFJKSEF5T0xEMXkreGFp?=
 =?iso-2022-jp?B?L0JtTEtqbkl0aGJwQ1VUWmN3aG1CTlZkR2hkWVRhdXZSKytBa3dxajVD?=
 =?iso-2022-jp?B?ZGVsczFocHczeWZLdHpUTUtOb2cyOUhVTHEvNlhrMGRibzdBbkg5a1NF?=
 =?iso-2022-jp?B?NTREY2FROEhvODlZUkd0aFkzZUJ6RFJDVUFqYmZrWWx3TTNoWSs4RVAw?=
 =?iso-2022-jp?B?N1dNaUY3cjdxV1A2TEwwMHY2b1Fld1B0a2NRVmFvazVXQnVzeFBhdXE1?=
 =?iso-2022-jp?B?dTZCa1ZIanBiSlFDaDZOazJUSnlsWnpOVHAxeGMwZ0xqMHhjN2hMUTVl?=
 =?iso-2022-jp?B?aG1reFpmZW93Y0ZZRGFMOVZlTVUvei9CVzIzMmZaUEw2U1RhSlB6OE15?=
 =?iso-2022-jp?B?QlZwcnpLWStseERYOFFXZXQ4bkVPVE5WWTBTV2FDbUZOeHUza3V3SkR4?=
 =?iso-2022-jp?B?VkFxV0NYZUFyeXVPTkZJeTNNZmZCSkdjN004Q042RTI3cU1MbHMxdjJR?=
 =?iso-2022-jp?B?ZHRUS0J0WUFLL3VuelUyZW5Mbi85ZlVJV1dUVUNYb29aSURrWFhwbnZ0?=
 =?iso-2022-jp?B?STN5WGdIdzhnM2RzRXRQUSszMCtuWituSTRDeEliVFYxWUlBZDBNYnNB?=
 =?iso-2022-jp?B?V0g5YS9TZ2IzWlhicERwQmIzaXFRU1o5S0gySTFxSmlZUHUzRjcwbWJK?=
 =?iso-2022-jp?B?R1cyU3FCNWdXTkFjSUIvNmtHNXpST3pCYlhmRDNOK2htdWFBNXFmT3lj?=
 =?iso-2022-jp?B?Z2cvTWdIVzYwZS9jRXRDUmc5czlnMlJDTUtWbm5wb29UR2hQMkY3c1BM?=
 =?iso-2022-jp?B?RDZyZWZ4dnBFUFkzL1p6bEk0SFdNL05xNFNDN28rRkoydUp0U2ZyYkY4?=
 =?iso-2022-jp?B?UW5OVHV4dytLK213YzJYM25kTVQxZVFpaHc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OSZPR01MB8401759CA7B581E1C8D0BE2AB7E62OSZPR01MB8401jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8401.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9733a0f2-ec64-4ca4-9cb0-08dd3a0feecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 11:37:06.1408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rk2CtmC3mMIVsRo1ZD1MNF/LOOIOMAN8Eht43iTvOvEqoW4K9cU3JFJjjqt4aqd/exOq8vARPXV3kBfkc/Mbk5q+Lvbae46udWqFY0AukPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10688
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Jan 2025 11:37:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17557

--_000_OSZPR01MB8401759CA7B581E1C8D0BE2AB7E62OSZPR01MB8401jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Sai, Quirin,

Currently there are two MCOM =1B$B!H=1B(Bdevice-types=1B$B!I=1B(B in LAVA: =
x86-siemens-mcom [0] and mcom-mtda [1].
It looks like the latter is being used for the SWG testing.

Is there a physical difference that means =1B$B!H=1B(Bstandard=1B$B!I=1B(B =
testing cannot be run on the mtda-4-mcom device?

Ideally, I=1B$B!G=1B(Bd like us to move to having a single =1B$B!H=1B(Bx86-=
siemens-mcom=1B$B!I=1B(B device-type for all MCOM devices, and if specific =
SWG jobs can only run on the mtda-4-mcom [2] device then we make use of =1B=
$B!H=1B(Btags=1B$B!I=1B(B in the LAVA job definition.

[0] https://lava.ciplatform.org/scheduler/device_type/x86-siemens-mcom
[1] https://lava.ciplatform.org/scheduler/device_type/mcom-mtda

Thanks, Chris

From: dinesh.kumar@toshiba-tsip.com <dinesh.kumar@toshiba-tsip.com>
Sent: 17 January 2025 10:42
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: kazuhiro3.hayashi@toshiba.co.jp; cip-dev@lists.cip-project.org; Sai.Sat=
hujoda@toshiba-tsip.com
Subject: RE: ltp (syscall) failed test in CIP Security image with isar-cip-=
core v1.6 on M-COM

Hi Chris,

Thanks for your response.

Sai has added comments in the MR. Please review them.

Please refer my response inline.

Thanks & Regards,
Dinesh Kumar

From: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>
Sent: Wednesday, January 15, 2025 7:27 PM
To: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>
Cc: hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro=
3.hayashi@toshiba.co.jp>>; cip-dev@lists.cip-project.org<mailto:cip-dev@lis=
ts.cip-project.org>; ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba=
-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
Subject: RE: ltp (syscall) failed test in CIP Security image with isar-cip-=
core v1.6 on M-COM

Hello Dinesh, Sai,

I=1B$B!G=1B(Bve created a MR that adds build/test support for the x86 merge=
d config [0]. Please look for exactly what=1B$B!G=1B(Bs been done.
Currently it adds support to all the CIP kernels.
Do you also want support added for the stable kernel versions?
[Dinesh] I have reviewed the changes you have made. It=1B$B!G=1B(Bs good no=
w merged configs are being tested at least on some targets.
                As of now can you please also enable running ltp tests on x=
86-siemens-mcom target? With kernel 6.1
               At the moment our primary focus is from IEC perspective so r=
unning only 6.1 kernel is sufficient, but if other CIP members have require=
ments to run other stable kernel versions that can should be discussed in T=
SC meeting,

               However, please note that as this setup is not running CIP s=
ecurity image so we will explore options to run ltp tests on M-COM device w=
ith merged config with kernel 6.1 via isar-cip-core pipeline. (This is stil=
l not discussed with all members)
               But this setup is also important in case if we want to compa=
re any failure cases etc.
               If you have any ideas how to run ltp tests on security image=
s on M-COM using Linux-cip-ci pipeline please let us know.

I=1B$B!G=1B(Bve kicked off various pipelines to test these changes. Links c=
an be found in [1].

[0] https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/merge_=
requests/65
[1] https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/merge_=
requests/65#note_2298307207

Kind regards, Chris

From: dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com> <=
dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>
Sent: 20 December 2024 16:56
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>=
; cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>; Sai.=
Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>
Subject: RE: ltp (syscall) failed test in CIP Security image with isar-cip-=
core v1.6 on M-COM

Hi Chris,

Please reply to this email as by mistake Ashrit included SWG.

Regards,
Dinesh Kumar

From: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com<mailt=
o:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Friday, December 20, 2024 7:43 PM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>; cip-members@lists.cip-project.org<mailto:cip-members@lists.cip-p=
roject.org>
Cc: hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro=
3.hayashi@toshiba.co.jp>>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Portin=
g) <dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>; c=
ip-security@lists.cip-project.org<mailto:cip-security@lists.cip-project.org=
>; cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
Subject: ltp (syscall) failed test in CIP Security image with isar-cip-core=
 v1.6 on M-COM

Hello Chris,

Hope you are doing great.

SWG locally executed LTP tests on M-COM x86 device booted with CIP security=
 image. The kernel used in this image is built with cip x86 merged defconfi=
g<https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master=
/6.1.y-cip/x86/cip_merged_defconfig?ref_type=3Dheads>. After generating the=
 results, we found some failed tests in the syscalls suite.

We wanted to compare them with kernel test results in LAVA and noticed that=
 cip x86 merged  defconfig<https://gitlab.com/cip-project/cip-kernel/cip-ke=
rnel-config/-/blob/master/6.1.y-cip/x86/cip_merged_defconfig?ref_type=3Dhea=
ds> is not being used to run LTP tests on x86 targets. Can you please look =
into that ?

I am attaching a document with the results summary of LTP tests when run on=
 M-COM x86 device with v1.6 security image. Please have a look at it. I am =
also attaching the failed test cases in syscalls suite.

We need opinion from members if we need to hold back from sharing the v1.6 =
x86 generic isar-cip-core evaluation to BV members in case those LTP test f=
ailures are effective.

Thanks and regards,
Sai Ashrith


--_000_OSZPR01MB8401759CA7B581E1C8D0BE2AB7E62OSZPR01MB8401jpnp_
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
<style><!--
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
	color:blue;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#7030A0;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
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
<body lang=3D"EN-GB" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Hello Sai,=
 Quirin,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Currently =
there are two MCOM =1B$B!H=1B(Bdevice-types=1B$B!I=1B(B in LAVA: x86-siemen=
s-mcom [0] and mcom-mtda [1].<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">It looks l=
ike the latter is being used for the SWG testing.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Is there a=
 physical difference that means =1B$B!H=1B(Bstandard=1B$B!I=1B(B testing ca=
nnot be run on the mtda-4-mcom device?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Ideally, I=
=1B$B!G=1B(Bd like us to move to having a single =1B$B!H=1B(Bx86-siemens-mc=
om=1B$B!I=1B(B device-type for all MCOM devices, and if specific SWG jobs c=
an only
 run on the mtda-4-mcom [2] device then we make use of =1B$B!H=1B(Btags=1B$=
B!I=1B(B in the LAVA job definition.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">[0]
<a href=3D"https://lava.ciplatform.org/scheduler/device_type/x86-siemens-mc=
om">https://lava.ciplatform.org/scheduler/device_type/x86-siemens-mcom</a><=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">[1]
<a href=3D"https://lava.ciplatform.org/scheduler/device_type/mcom-mtda">htt=
ps://lava.ciplatform.org/scheduler/device_type/mcom-mtda</a><o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-GB">Thanks, Chri=
s<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> =
dinesh.kumar@toshiba-tsip.com &lt;dinesh.kumar@toshiba-tsip.com&gt;
<br>
<b>Sent:</b> 17 January 2025 10:42<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> kazuhiro3.hayashi@toshiba.co.jp; cip-dev@lists.cip-project.org; =
Sai.Sathujoda@toshiba-tsip.com<br>
<b>Subject:</b> RE: ltp (syscall) failed test in CIP Security image with is=
ar-cip-core v1.6 on M-COM<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">Hi Chris,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">Thanks fo=
r your response.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">Sai has a=
dded comments in the MR. Please review them.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">Please re=
fer my response inline.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">Thanks &a=
mp; Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">Dinesh Ku=
mar<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> =
Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Pat=
erson2@renesas.com</a>&gt;
<br>
<b>Sent:</b> Wednesday, January 15, 2025 7:27 PM<br>
<b>To:</b> dinesh kumar(</span><span lang=3D"JA" style=3D"font-size:11.0pt"=
>=1B$B#T#S#I#P=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif"> TMIEC ODG Porting) &lt;<a href=
=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.com</a>=
&gt;<br>
<b>Cc:</b> hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font-size:11.=
0pt">=1B$BNS=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt;font-fa=
mily:&quot;Calibri&quot;,sans-serif">
</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$BOB9(=1B(B</span><s=
pan lang=3D"JA" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif">
</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$B#D#M#E=1B(B</span>=
<span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&qu=
ot;,sans-serif"> =1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-size:11=
.0pt">=1B$B#D#I#G=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt=
;font-family:&quot;Calibri&quot;,sans-serif">=1B$B""=1B(B</span><span lang=
=3D"JA" style=3D"font-size:11.0pt">=1B$B#M#P#S=1B(B</span><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">=
=1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$B#M#P#4=
=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a>; ashrith sai(</span><span lang=3D"JA" style=3D"font-size:11.0pt">=
=1B$B#T#S#I#P=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;fon=
t-family:&quot;Calibri&quot;,sans-serif">) &lt;<a href=3D"mailto:Sai.Sathuj=
oda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsip.com</a>&gt;<br>
<b>Subject:</b> RE: ltp (syscall) failed test in CIP Security image with is=
ar-cip-core v1.6 on M-COM<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Hello Dine=
sh, Sai,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">I=1B$B!G=
=1B(Bve created a MR that adds build/test support for the x86 merged config=
 [0]. Please look for exactly what=1B$B!G=1B(Bs been done.<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Currently =
it adds support to all the CIP kernels.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Do you als=
o want support added for the stable kernel versions?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">[Dinesh] I have reviewed=
 the changes you have made. It=1B$B!G=1B(Bs good now merged configs are bei=
ng tested at least on some targets.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; As of no=
w can you please also enable running ltp tests on x86-siemens-mcom target? =
With kernel 6.1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; At the moment =
our primary focus is from IEC perspective so running only 6.1 kernel is suf=
ficient, but if other CIP members have requirements
 to run other stable kernel versions that can should be discussed in TSC me=
eting,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; However, pleas=
e note that as this setup is not running CIP security image so we will expl=
ore options to run ltp tests on M-COM device
 with merged config with kernel 6.1 via isar-cip-core pipeline. (This is st=
ill not discussed with all members)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; But this setup=
 is also important in case if we want to compare any failure cases etc.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If you have an=
y ideas how to run ltp tests on security images on M-COM using Linux-cip-ci=
 pipeline please let us know.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">I=1B$B!G=
=1B(Bve kicked off various pipelines to test these changes. Links can be fo=
und in [1].<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">[0]
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-=
/merge_requests/65">
https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/merge_requ=
ests/65</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">[1]
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-=
/merge_requests/65#note_2298307207">
https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/merge_requ=
ests/65#note_2298307207</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-GB">Kind regards=
, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp=
;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.=
com</a> &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@t=
oshiba-tsip.com</a>&gt;
<br>
<b>Sent:</b> 20 December 2024 16:56<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hay=
ashi@toshiba.co.jp</a>;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a>;
<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsi=
p.com</a><br>
<b>Subject:</b> RE: ltp (syscall) failed test in CIP Security image with is=
ar-cip-core v1.6 on M-COM<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">Hi Chris,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">Please re=
ply to this email as by mistake Ashrit included SWG.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">Regards,<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">Dinesh Ku=
mar<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> =
ashrith sai(</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$B#T#S#I=
#P=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&q=
uot;Calibri&quot;,sans-serif">)
 &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshib=
a-tsip.com</a>&gt;
<br>
<b>Sent:</b> Friday, December 20, 2024 7:43 PM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;;
<a href=3D"mailto:cip-members@lists.cip-project.org">cip-members@lists.cip-=
project.org</a><br>
<b>Cc:</b> hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font-size:11.=
0pt">=1B$BNS=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt;font-fa=
mily:&quot;Calibri&quot;,sans-serif">
</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$BOB9(=1B(B</span><s=
pan lang=3D"JA" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif">
</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$B#D#M#E=1B(B</span>=
<span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&qu=
ot;,sans-serif"> =1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-size:11=
.0pt">=1B$B#D#I#G=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt=
;font-family:&quot;Calibri&quot;,sans-serif">=1B$B""=1B(B</span><span lang=
=3D"JA" style=3D"font-size:11.0pt">=1B$B#M#P#S=1B(B</span><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">=
=1B$B!{=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$B#M#P#4=
=1B(B</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-s=
ize:11.0pt">=1B$B#T#S#I#P=1B(B</span><span lang=3D"JA" style=3D"font-size:1=
1.0pt;font-family:&quot;Calibri&quot;,sans-serif">
</span><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,sans-serif">TMIEC ODG Porting) &lt;<a href=3D"mailto:dinesh.kuma=
r@toshiba-tsip.com">dinesh.kumar@toshiba-tsip.com</a>&gt;;
<a href=3D"mailto:cip-security@lists.cip-project.org">cip-security@lists.ci=
p-project.org</a>;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a><br>
<b>Subject:</b> ltp (syscall) failed test in CIP Security image with isar-c=
ip-core v1.6 on M-COM<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-IN"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:black">Hello Chris,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:black">Hope you are doing great.<o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black">SWG locally exec=
uted LTP tests on M-COM x86 device booted with CIP security image. The kern=
el used in this image is built with
<a href=3D"https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/bl=
ob/master/6.1.y-cip/x86/cip_merged_defconfig?ref_type=3Dheads" title=3D"htt=
ps://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master/6.1.=
y-cip/x86/cip_merged_defconfig?ref_type=3Dheads">
cip x86 merged defconfig</a>. After generating the results, we found some f=
ailed tests in the
<b>syscalls </b>suite.&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black">We wanted to com=
pare them with kernel test results in LAVA and noticed that
<a href=3D"https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/bl=
ob/master/6.1.y-cip/x86/cip_merged_defconfig?ref_type=3Dheads" title=3D"htt=
ps://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master/6.1.=
y-cip/x86/cip_merged_defconfig?ref_type=3Dheads">
cip x86 merged&nbsp; defconfig</a>&nbsp;is not being used to run LTP tests =
on x86 targets. Can you please look into that ?<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black">I am attaching a=
 document with the results summary of LTP tests when run on M-COM x86 devic=
e with v1.6 security image<b>.</b>&nbsp;Please have a look&nbsp;at
 it. I am also attaching the failed test cases in syscalls suite.<o:p></o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black">We need opinion =
from members if we need to hold back from sharing the v1.6 x86 generic isar=
-cip-core evaluation to BV members in case those LTP
 test failures are effective.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black">Thanks and regar=
ds,<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-IN" styl=
e=3D"font-family:&quot;Aptos&quot;,sans-serif;color:black">Sai Ashrith<o:p>=
</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-IN" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_OSZPR01MB8401759CA7B581E1C8D0BE2AB7E62OSZPR01MB8401jpnp_--

