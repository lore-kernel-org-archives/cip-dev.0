Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04ADC19F4F
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 13:04:40 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.72])
 by mx.groups.io with SMTP id smtpd.web10.15633.1714048098000324644
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 05:28:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zfGg9LFy;
 spf=pass (domain: siemens.com, ip: 40.107.14.72, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3/BebwGcVsejzcRtK1Mp41svJ19H1bTXgLVlXVKbhJIGQhoRepOdUVswipn6Gzv31/+xWlebefR53whW9i25Y/XGbxRqzyKQsIoIFTDTrsZoMAHDI3RPKBRf8FCjGBdTjgIU2e0DJJrOKi0DrJvTsmpZ6fkKD8bXAgHQR7gWnI8fl4++yIVPRj//nGVOsRW12sidykGZcJeiW2LVcS8Bg1IzwLu5BHGZimZwhHWpAqLHGRGUC603ILTouEWgboFmurgouIGANEhTGIb+7iA6wvFEH3RmPkNZR6nDXGb5/Sn+HLN4ryaTlGK33CIa1rSp8kHYAj1yr/1RJz6tP1+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xclwHIMinzgC67A/0O6ZWhHrC0lMwWq2xAuHREx4Yyw=;
 b=YBcyfoP+uwvSnNNqYv8ybHK+H+4Hg2TAVG2N87AY5MGHoGDrp2kl3BnIXehuj39oTVmFAp8pkTzgOS58GDB3VDt5jqwLTbyxmU9npiQay7n53IMMGNozXl5SPMDQi0bPEKxHlUe1viJamyDK56yKZIQMSBZ2gRM7brRQFO7M6+YdNAmIKv9LoGyT3XAxmPN3jpnlpFI2BAkNsgjv9s0txDwmYx5734yA/tMpaPh0vzPeym+Jq/UT3f/HbQEPFGLm8X1Id6CkX82BLec5x0LKxt1RAkVri1MmLCJqd+BxPUVX1c4U4UY02ZENqrJvz9aJwkWvoWzJZd+I2QKQ09Ld4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xclwHIMinzgC67A/0O6ZWhHrC0lMwWq2xAuHREx4Yyw=;
 b=zfGg9LFyq177rbB0qgghgysp2XSPf7240dlY8cwnCXRIRJr2Amkajm4dm4n2TJ8KKu8R9Xm06lHU6X+WoSUwAHlEbsxAEsquZywFOy+B9nySjIOgGXN2S+fKXu98HplWOmHa3ioPPeylNC7XlwpuRp1GrRi0E/e3RD43V5mKYfYvRV5HPC5hU52QvYgHzPt00aEuqDaG2OqJlYz8FXsnk8ABWuKTgLJC4uh7dYKM90ayK11PY1kxYf9GnguKCaD7HzpW4XyPbSS1gLLzlZe53pJQXDvaeMUoqmtt4TC+wCA7Xst600KsKmG7fp7YRQ6wW7QzU+J2ohfdjFpr+TDcNA==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by PAWPR10MB7319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 12:28:10 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 12:28:10 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "johnxw@amazon.com" <johnxw@amazon.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 9/9] README.swupdate: Add section about partition selection
Thread-Topic: [cip-dev][isar-cip-core][PATCH v3 9/9] README.swupdate: Add
 section about partition selection
Thread-Index: AQHalwbmFTRa273bFEGecGPN/+zVsrF46gKA
Date: Thu, 25 Apr 2024 12:28:10 +0000
Message-ID: <cc09646c16f25b03f7ebaa5a06db59d4a2c3897f.camel@siemens.com>
References: <20240425115119.813384-1-Quirin.Gylstorff@siemens.com>
	 <20240425115119.813384-10-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240425115119.813384-10-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|PAWPR10MB7319:EE_
x-ms-office365-filtering-correlation-id: b4dc27a0-2f37-4476-a4bb-08dc65232b48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Q1FoYlFyOHhNU1Fqc2xVV2FKYUpUcUFmSy9IaEU0YUJKdEczM1RQZkcwMlNL?=
 =?utf-8?B?RThrNVFuV2lHQzVjVW1UL2w1anhUVjBPZXQwSy81dlVjdlBvNFQ2ZlJMTWdz?=
 =?utf-8?B?Q0l0eGgrTGx1Wk5yT1RsbDBXK3FFMFBLYmRTY2VpRFdVWnNGdDdrUDBoSzZK?=
 =?utf-8?B?V0o3SW9nWEo3cHVVUjhWN21zek5HVGt1WGlJWHZveWwrVzZXbE5VZ3E0anlY?=
 =?utf-8?B?Z0d5cjJ4NmJBd25UNWYwUVFPK2p3STZ2ZkVmYmZ1TlFvQmU1NVE3R3p3aU9X?=
 =?utf-8?B?QUk0WUxXeHRvZ3BTZGRoQjUyeHJCQmU0UE5CdTFLSERFaTBkdGNLS1ZrczJu?=
 =?utf-8?B?RHYyRzFFc2VIS0U0VmNZQ2V2Rzg5YmdqUjR4TitIUWJ6YStnRWRueFVoMzBq?=
 =?utf-8?B?QXlIUUd4aElJNllybEo5SW51T0hlZTJOcmZEZGd1eDNvQ1RNaFlJMTN4Wjda?=
 =?utf-8?B?Ylk2RFhhQlg4bWZab25PM1JTc09jUGJrVDhUaU1wbUdVUUVsSGM5U3J5QVV4?=
 =?utf-8?B?R0E3MWpWZllEY3N4MEZNMjBDMDdlMWhDUEdPbmlNVi85M2lkUXhJaDBLR2ZZ?=
 =?utf-8?B?Y2J2aDVha0ZYRTdVSG5ORUhKZnVLcjZxV2hhNExmOVNtNWNyOExQWHVnQWdF?=
 =?utf-8?B?ZnZ5dDNCZWtwZ0E2RlVaUkd4NkhPSlZ5a25DU2lzMFdzaG5LVTBTbUg1eGh1?=
 =?utf-8?B?QUFwTXRNMmRJdGtEWXRlUTNCZ0U5UE5USjVoRk9NRGc2aHdZcGZxcFZWcGtJ?=
 =?utf-8?B?QXQ0cXZoS2Q3YjU0YzBXeGVsdURRTDhudkh4Umk0cmYwc3l6cEFVZlY0UHNI?=
 =?utf-8?B?NUh4OE1UOHhOZXNSOGp5NkNIM3NBQVc2YlFxWVlacUg4YTNpWDV3Y1RYTUpP?=
 =?utf-8?B?RFVQeEhSVStyZVB1L215TUorRi9uN25YcXMrQTFTWXBkTGlNVmdSNTIxd05Q?=
 =?utf-8?B?TjRhUlRpVWtmRG9lTk9KbUZrUElBU1VqVmxSL2pJQU04ZUlTOXNwRnVqYnZY?=
 =?utf-8?B?dkRzM3hYQ202SWQ3K2JkMGp4dGhWc0FoRit4ZWlQeTJmdXYwbTE4d05KdjFt?=
 =?utf-8?B?Q001OSszc3RLVEg4Zjl4TnY2ZXVqU1NJUG94OEpXZTBuRTFBRWZNekhFYTFz?=
 =?utf-8?B?M0dVaW9kS0U0V2JVL21yZHl5ZisrVjh3Ums4ckZELzVPN3RCcWxoTktRcWlM?=
 =?utf-8?B?VEVZTXI3cXplSnlGQXp2eTlNeXA4bHFNS0VBeXFKazZZaTE1dlVXV1ZRa29C?=
 =?utf-8?B?c0lhM2FEdldJVHBPSEdnYy9XSnduYk8ydGxnekRWaXhTWmNUSGpIQXQ2cmQ5?=
 =?utf-8?B?c2c1aTBHM2pIdm5zL3NOVDBOb1h1aElQcUxGR0Vzc0loMW10eHlXK2JROXp2?=
 =?utf-8?B?TTdaR2oyVlJFWEZERkVoRm91UXJkTGR5dzdSU1lCMjIwUlZuakY4dzJaWmtO?=
 =?utf-8?B?ZXV0QkFER056eThCT3ZUd2lvWHlERTR1ZUtnaysvb3Y2aEZxOUUrcjFMOHFS?=
 =?utf-8?B?emYrQVJXSWtieE40UU4zc1hNR1d4Uk1jOUw4NFhtMWg5WkJUQWFTb2YybjUx?=
 =?utf-8?B?TmM0SzBYNTZMZXhLLy96azZseEJQejFielZxdEtGbzFCbkRGOEV3T1pPOURE?=
 =?utf-8?B?SmVHVlZQVktVazN0Z2Q1VWR5SzRNUXdibVlOU3g0TzZsd0ZHRmEwTzAxTGpC?=
 =?utf-8?B?NUxuODRHaWNUbkR4SDY5c3ZLZURMbTVhZE9HSC84UGNYd1hXaXlBK0FqMU1p?=
 =?utf-8?B?cHEyMXdYdU5EUjdQTzE3MWFUMFRrKzNmK2xyN2VIMzJLZkluK3VBVFlrUUN0?=
 =?utf-8?B?dHhxdjh3L1JSUTRhVFdaUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Yms0Y0lJLzNaSHZCUDQrK3lKaVFPRE5nbVVOMFJ2OWV0OEdxUjRtaXJXYm9P?=
 =?utf-8?B?aGdmYUp6d1pXUW5aSDFpYTJjZVpzeDVEQUZqcnRER3dlSytHb2wwODMxZjNk?=
 =?utf-8?B?T1dYMEFtSHhtbHRUWVBTcmxQTmQ2eTRXSGNNeEVoSTFPSmZTVjdQQXhJQzda?=
 =?utf-8?B?MVQ1VlFlZzdNai9TSFpPWkxxZFNCN1pVRlZiZ0JyYnd2RUFIWWNvZEJEMnQ3?=
 =?utf-8?B?MzBxalBKbmdpa3hzaXRZMjloeE51V3FPUGw5VjNnUHdnSVBPOHluTURIQmg2?=
 =?utf-8?B?V3dLSVkxTTJ0QmsxZlhQc2ovSXM5TXB2d3VlWTVxYjBvK1hFOGFHU0dZbnlY?=
 =?utf-8?B?eEVUdktmdlplL3RYZ1JMRmRDVmdITTYyVUZ4M3ZJK2dIUlZTR1AwVWxSR21B?=
 =?utf-8?B?UCtQc2VrTWNQTDlZWlk3cE9IMllyWmR2T2ErNk95eU5sbDF3WTNsWUlTUmlh?=
 =?utf-8?B?d2lYRW1nd2ZIQ2Y2WC9KdUNjUUtVM3hoZHRXbEFZMzJmbmxpbVJnWGNORlR4?=
 =?utf-8?B?aUJwcVRSNW1Kd0ZWQzZuYUVXUkI3elU1U0FBWkNCcmNpL2VRZ1daRUJkWEZN?=
 =?utf-8?B?bEx3UEZPK2dJbzRqMC9jNlZKbWF1NythaXBsRVpqb3ltOUJRaS8yRDg2RkFL?=
 =?utf-8?B?Y1RrZVZXL1BISjVCUjN3ODhMT2J4eWxZdXlyYmMzejN5c1FFTENBZDFZNldU?=
 =?utf-8?B?SDJhMExuam9QSWlzL1ZrZWRyWk9iMXJFMmFNMkxSbGhBSDlocWR6K2JJQ1JI?=
 =?utf-8?B?OFRIaHZ2Umg1QUlKdHdsWUx5SU44QUFnRTZTVTcyNkg1QlhVT1R5Y0ZHYVE2?=
 =?utf-8?B?S1d6NFNDdUdqR215dlpkNGJRdnJ1cDVjVE1uNlJmSjhZbU1LMHBwTEJQbWdO?=
 =?utf-8?B?YXZ1Vng2dC92VHQrT0ZSelQwN2hueEtSNVEwZFlwa1REMDhpbU1ZRmN6dTNv?=
 =?utf-8?B?bFZwdk5kZE1Zc2c1YTdzdzlPVVNKWEF6NnJTeVc0c0lLdHdwazB5NU11d3hi?=
 =?utf-8?B?UnllZ1lLSnJUUU1QTUVjQWVOdnBtM0xZWmFRY3ZVcEkxVWpRc09tc2JHU2JF?=
 =?utf-8?B?KzBWSzltWExTQ043eDEvZG9reithSFFheG41eHhRME4zWjJpUlpVcS9lWG5o?=
 =?utf-8?B?aEJqQ1pWdXdpSTUxallGc1ZVek8xM3g0S3hEVmFyZzc5bEhONFZDbi80bEpv?=
 =?utf-8?B?VzU1VVFWZSsxYmtVQklLSEtIeHhmQlJoN2FFWDNEQkNOT1ZEWDc1ZTJEdDBp?=
 =?utf-8?B?blZwR1B6UGx0eFNJcEUrQmhSRlhJRkdEMHBadGZXaC81bHNFRWM0R2RtUGpM?=
 =?utf-8?B?cjk1RmJEYm9PZWg5TTNXQ29iWklxR1ZKcFNVWnJZaU00a3dVNDl5b2ZmdE56?=
 =?utf-8?B?ei9zNVhhWWdzMW5QK2t0dHlaMFE1WCtVV2pOR2pqRWlVSXZFYlp5NlpOREdN?=
 =?utf-8?B?NHAxWUpQWUFKUTJPb3grc0dtLzdtR0hqWE1zZlltak1JMS9ZSjcxY2JtVnRS?=
 =?utf-8?B?SXFZckhBOGhPVlljUHF4WWF3NTBTblIwMDBseURnNWN0ZXc0dmNwM0FVUjMr?=
 =?utf-8?B?a2FYMEVFYlpVSVhWTzNJcEgwWWd1SjF1dDNubVMvZ1QvWE1JN2Q4ZnloRzlq?=
 =?utf-8?B?aTgveUQvQWdDTFF1eE5sWEszVWFPemx4aU82NGwyY29iTk5oVFhTVnJHVmJ5?=
 =?utf-8?B?cmRoZE5vNkt2WEJYVlpSY2VINUZSNVRJSWF6dCtNTEYzYjJoVlRGdk1uam5h?=
 =?utf-8?B?Ujd0TnpuQ3RsNFdjWC9aNlZnNDZpMzI2bDA3OEZkZHA4amhjQmQ2TEhPSjIx?=
 =?utf-8?B?S2ZUL1RqS3dBaGE5ODRaSUU4cWVQZnBrSW8zSndjcWRJVWVYS2V4TDdoL0lN?=
 =?utf-8?B?QmFnSjdkY0pySzJsTW8xeTNXS09TYS9pYkJwYUlLTS8rR2RNOG5vbkJwR05j?=
 =?utf-8?B?RDY1U2dSbGczS3Zxd2dJN2FiOUdFUjhoM3QwdGNBbzZabUFscHQ5YldjNnZB?=
 =?utf-8?B?bVQvbWNmMzl4UFZpakpFd1EyM1dRcjhLVGhhK0RxVzAreVJZN0ZrVHVBT3hi?=
 =?utf-8?B?dUlRdk96Y09rNys5TE5jZHNGWWdHdThQUjdDS00zT0tWSHVPY2c0QVdod2xa?=
 =?utf-8?B?MjJnbm11SXVIVmZmcHRpb2RaNDBtS2Vxb0hrMHhTeVNMYXkvWVNGLzNuRWVh?=
 =?utf-8?B?Vlp1WUlqd2NuWG5nTVZtbjU1WlM4a3FFYisvLyt6RUkycTk1c0RIZjlkUHJK?=
 =?utf-8?Q?XMLLTKUlA+mwywXdWb344xNlUu07n9KNxpqUXUi0nY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dc27a0-2f37-4476-a4bb-08dc65232b48
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 12:28:10.4083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZFt6tsTytNVS85Xj+l3fMEgMUXbXkVJbdLRY56woYht4ms/CboC0fiiyxxhJ26vIlIP8vaOqasn+hoeFSZfvulg0dDY6nQD7NPZE+hToUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7319
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF0E89ABED30514DBBF7512880E116E9@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Apr 2024 13:04:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15768

T24gVGh1LCAyMDI0LTA0LTI1IGF0IDEzOjUwICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0b3Jm
ZkBzaWVtZW5zLmNvbT4NCj4gLS0tDQo+IMKgZG9jL1JFQURNRS5zd3VwZGF0ZS5tZCB8IDE5ICsr
KysrKysrKysrKysrKysrKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RvYy9SRUFETUUuc3d1cGRhdGUubWQgYi9kb2MvUkVBRE1FLnN3
dXBkYXRlLm1kDQo+IGluZGV4IGI3ZTEzZjcuLmRlZmFiYTYgMTAwNjQ0DQo+IC0tLSBhL2RvYy9S
RUFETUUuc3d1cGRhdGUubWQNCj4gKysrIGIvZG9jL1JFQURNRS5zd3VwZGF0ZS5tZA0KPiBAQCAt
Nyw2ICs3LDI1IEBAIFN0YXJ0IHdpdGggY2xvbmluZyB0aGUgaXNhci1jaXAtY29yZSByZXBvc2l0
b3J5Og0KPiDCoGBgYA0KPiDCoGhvc3QkIGdpdCBjbG9uZQ0KPiBodHRwczovL2dpdGxhYi5jb20v
Y2lwLXByb2plY3QvY2lwLWNvcmUvaXNhci1jaXAtY29yZS5naXQNCj4gwqBgYGANCj4gKw0KPiAr
IyMgVXBkYXRlIFBhcnRpdGlvbiBzZWxlY3Rvcihzd3VwZGF0ZS1oYW5kbGVyLXJvdW5kcm9iaW4p
DQo+ICsNCj4gK1NXVXBkYXRlIHVzZXMgdGhlIGhhbmRsZXIgW3N3dXBkYXRlLWhhbmRsZXItDQo+
IHJvdW5kcm9iaW5dKGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtc3ctdXBkYXRl
cy9zd3VwZGF0ZS0NCj4gaGFuZGxlci1yb3VuZHJvYmluKSB0byBzZWxlY3QgdGhlIHVwZGF0ZSBw
YXJ0aXRpb24uDQo+ICtUaGUgaGFubGRlciB1c2VzIHRoZSBmb2xsb3dpbmcgaW5mb3JtYXRpb24g
dG8gc2VsZWN0IHRoZSB1cGRhdGUNCg0KLS0tLS0tLV4gdHlwbw0KDQo+IHBhcnRpdGlvbjoNCj4g
KyAtIGJ5IGVmaWJvb3RndWFyZCBzZWxlY3RlZCB1bmlmaWVkIGtlcm5lbCBmaWxlLiBJbiB0aGUg
Y2lwLWNvcmUNCj4gcHJvdmlkZWQgaW1hZ2VzDQo+ICsgdGhlIGJvb3QgcGFydGl0aW9ucyBhcmUg
bGFiZWxlZCBCT09UMCBhbmQgQk9PVDEsIHNlZSBbZWJnLQ0KPiBzeXNwYXJ0cy5pbmNdKC4uL3dp
Yy9lYmctc3lzcGFydHMuaW5jKS4NCg0KVHJ1ZSwgYnV0IHRoZSBsb2FkZXIgZG9lcyBub3QgY2Fy
ZSBhYm91dCB0aGUgcGFydGl0aW9uIGxhYmVscy4gSXQganVzdA0KcHJvYmVzIGFsbCB2ZmF0IHBh
cnRpdGlvbnMgZm9yIEVCRyBlbnZzLiBUaGUgbGFiZWxzIHNob3VsZCAoYW5kIGRvKQ0KaGF2ZSBu
byByZWxldmFuY2UgZm9yIHRoZSBlZmlib290Z3VhcmQgRUZJIHBhcnQuIEhvd2V2ZXIsIHRoZXkg
YXJlIHVzZWQNCmluIHRoZSBzdy1kZXNjcmlwdGlvbiBpbiBzd3VwZGF0ZSwgYW5kIGJ5IHRoYXQg
YXJlIHJlbGV2YW50IGZvciB0aGUNCnVzZXJzcGFjZSBwYXJ0IChhcyB5b3UgZG9jdW1lbnRlZCBi
ZWxvdyBhcyB3ZWxsKS4gTWF5YmUgd2UgY291bGQgbWFrZQ0KdGhpcyBtb3JlIGNsZWFyIGluIHRo
ZSBkb2N1bWVudGF0aW9uLg0KDQpGZWxpeA0KDQo+ICsNCj4gK1RoZSBbc3ctZGVzY3JpcHRpb25d
KHJlY2lwZXMtY29yZS9pbWFnZXMvc3d1L3N3LWRlc2NyaXB0aW9uLnRtcGwpDQo+IGNvbnRhaW5z
IHRoZSBtYXBwaW5nIGZyb20gYm9vdA0KPiArcGFydGl0aW9uIHRvIHJvb3RmcyBwYXJ0aXRpb24s
IGUuZy46DQo+ICtgYGANCj4gK2RldmljZSA9ICJDOkJPT1QwOmxpbnV4LmVmaS0NCj4gPiR7QUJS
T09URlNfUEFSVF9JRF9BfSxDOkJPT1QxOmxpbnV4LmVmaS0+JHtBQlJPT1RGU19QQVJUX0lEX0J9
IjsNCj4gK2BgYA0KPiArVGhlIHZhcmlhYmxlcyBgQUJST09URlNfUEFSVF9JRF9BYCBhbmQgYEFC
Uk9PVEZTX1BBUlRfSURfQmAgZGVzY3JpYmUNCj4gdGhlIHJvb3RmcyBmaWxlIHN5c3RlbSBhbmQN
Cj4gK2NhbiBjb250YWluIGFuIHBhdGggdG8gYSBwYXJ0aXRpb24gZGV2aWNlKGUuZy4gL2Rldi9z
ZGFYKSwgbGFiZWwgb3INCj4gdXVpZC4gVGhlIGhhbmRsZXIgc2VhcmNoZXMNCj4gK2ZvciB0aGUg
bWF0Y2hpbmcgZGV2aWNlIGFuZCBTV1VwZGF0ZSB3cml0ZXMgdGhlIGltYWdlIHRvIHRoZQ0KPiBz
ZWxlY3RlZCBkZXZpY2UuDQo+ICsNCj4gK1RoZSBkZWZhdWx0IHZhbHVlcyBmb3IgYEFCUk9PVEZT
X1BBUlRfSURfQWAvYEFCUk9PVEZTX1BBUlRfSURfQmAgaXMNCj4gdGhlIGNvbnRlbnQgb2YgYEFC
Uk9PVEZTX1BBUlRfVVVJRF9BYC9gQUJST09URlNfUEFSVF9VVUlEX0JgIHdoaWNoDQo+IGFyZSBk
ZWZpbmVkIGluIFtzd3VwZGF0ZS5iYmNsYXNzXShjbGFzc2VzL3N3dXBkYXRlLmJiY2xhc3MpLg0K
PiArDQo+IMKgIyMgU1dVcGRhdGUgRWZpYm9vdGd1YXJkIHVwZGF0ZQ0KPiDCoA0KPiDCoDp3YXJu
aW5nOiAqKklmIHRoZSBlZmlib290Z3VhcmQgYmluYXJ5IGlzIGNvcnJ1cHRlZCB0aGUgc3lzdGVt
IGNhbg0KPiBubyBsb25nZXIgYm9vdCoqDQoNCi0tIA0KU2llbWVucyBBRywgVGVjaG5vbG9neQ0K
TGludXggRXhwZXJ0IENlbnRlcg0KDQoNCg==

