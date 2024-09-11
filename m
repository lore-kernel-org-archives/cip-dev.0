Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C059AEE021E
	for <webhook@archiver.kernel.org>; Wed, 11 Sep 2024 08:57:52 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.88])
 by mx.groups.io with SMTP id smtpd.web10.16735.1726041111714456470
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Sep 2024 00:51:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sp6DylNy;
 spf=pass (domain: siemens.com, ip: 40.107.21.88, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRTq17oAvlhFTyDvqMHTD5tgPoDkt9H/eaNX5GJl2F3gKOmDppj/LYn1+O7WMvkAQlSdG2AH0fHTnxA94UrZ0Ru49Pvfg14sV/wMkjHvjE9JBXmu6uXtX7WU9PLzCyCg8ixXPx0MCFmZBosaKvlkXgfgCGDjwvgIVUrmbi3NiBIhjy31zZpajm6xzVR4t8Dq5cbrIesiEBDk0z6mlPMbh3jj4Y1g1caTrcelS4AA035llJCzk1HlcP14jALZinPY4jM6tfvts5TPJAqAv5oMgIGBkFpBx8K5Hv0n4BkMshyNHpZClJNhjJLz9uF5430nIOX6aJI56If1MErGNFJpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyOFpO/1tTCZvmY7i57/Y5eHfNaX4o6zzTNBR0cY8dM=;
 b=doMEYnsLz2LNbDgQ/VFTh6i6GV5DTLacXYbFZOoGmeyR7HYg4YNdxqHNKOvMcA2/GPufZAmk+cTODN468CnSFuFzx2xR+PXRXj2Zy6ywYDL/72uyC9mRZtFouZqHMEAm2jLfSaUyHXafVKENW998xktxMAuKy03sVh40PljuZOzxflrYg7qSO7d5oVduB6hBUwnHRSTrmCvHViaW83zi2IT05YAMHWUcZ22Wk2mdJyU7fBp/pO66dSo/ex3md/Vfe8x5o67TyuvC9GNEkYN/8bSPprWjOpw1luGIWd2WK1kmCN/CBS1jaHlA7T7KCO8BhzsuP/yag87NRq/kk0E9bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyOFpO/1tTCZvmY7i57/Y5eHfNaX4o6zzTNBR0cY8dM=;
 b=sp6DylNyGf/5uvCq/Hxu6FgLYGlyxGdEaYgnvDj4klw5eOLHUfU12Z7bunxKqF+4bCVuXIeH4x7+U0byvRqBiA8t/gRCIguw35kw4+tPr7dq8sLXhg5DX3gC3mXpaPfAxWS3A4VEXCsGdBeEsq0MVpOf5aF7lFx5mznbExaIDso0cnKAXsDKrcs91U5hKS7AOorwY+/PA0jPp7NSKfqpABW500OG+gmtAWuw/ElgPX+JZQi38Htn0J/4Sco+Q5k3wljeApvt0VDOmZqGbtxSlKPoVFAKwGPa7kLlppsC4f69P+l0HXby6CMOXR1ptEWKtycqcBtu9GH7ty00E1DqGw==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 07:51:48 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 07:51:48 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][RFC 3/3] Update README for swupdate signing
Thread-Topic: [cip-dev][isar-cip-core][RFC 3/3] Update README for swupdate
 signing
Thread-Index: AQHbBB904NSeEAsiAkGUQzm6M74wLg==
Date: Wed, 11 Sep 2024 07:51:47 +0000
Message-ID: <d25be0d3b59c1cc988b102468210bb3aeef4a968.camel@siemens.com>
References: <20240909112309.1028531-1-Quirin.Gylstorff@siemens.com>
	 <20240909112309.1028531-4-Quirin.Gylstorff@siemens.com>
	 <647a038e-f6ce-41cf-b878-0b153b605a33@siemens.com>
In-Reply-To: <647a038e-f6ce-41cf-b878-0b153b605a33@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|GV2PR10MB6138:EE_
x-ms-office365-filtering-correlation-id: 19b86c2f-26e0-4b92-8043-08dcd23696cc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?S2FWTGMxTnVwUGUzc0dleEQxbTRFM28ySDFNSXB4Z3pIZ01MaUJrRVIyQ0w4?=
 =?utf-8?B?Ujg3SFZmcnM2bVU2L0VaZU9TRHV0bnErbERFTzQwanJyazd2ZTA2Y25mVFRW?=
 =?utf-8?B?dlJRZ0ltVG9NQStQT3RjbnpZWkdiaEFjOXlRcnk4cjZNZFNDblVUNG92R3pS?=
 =?utf-8?B?QUlFVDA0bTg4amtQcndDWmpxamxJTTR1UGlPdEEzUDFiYWxzMTRVaEpuNENH?=
 =?utf-8?B?NUltNXVxR0VRRVd5c1JVcFY3OE5VMDdTR1JNaUZGK1lHQk9MY0dVcFhZTytM?=
 =?utf-8?B?OHNoaFp3dVo4UUJ4NUhHVEhMSE5NS0tURFpvSWthdWFlU3NpWnFrc3NnOVdS?=
 =?utf-8?B?bndkMjgxNTV0MFdDY202RFkwendVYmY3dDhzZUVCZVdGZVFRUWg4MUI3MTJR?=
 =?utf-8?B?alBjUVNvYXFpRkNpdS9yN3JzNWpBenJxNzJaWFYxcXNmQXNkWmZMOTFvaVJw?=
 =?utf-8?B?bytONXVwV0V0U0FVRGhKTHhGMk41RTlZRHB2VTRmR0phMWVOUkt1NWtCQnJr?=
 =?utf-8?B?UW9iWGt2K0FyaGlTcGJYdU1MbmRsS3RQR2JMeHdGb3VteXJiOXY0STlIbFda?=
 =?utf-8?B?NXNlV2F4UzJzcVVJdGhaRXgrQlhqVDJBM2s1QUNmYVdvUktPdHhiaW9iNVpj?=
 =?utf-8?B?TVBGcDAyaUVVelFzUC9XQUx4ZWorSUdncVVRUDNlcTRldUl2TFpSMzNKSlFD?=
 =?utf-8?B?elZMenhOMFFOc01uMXZKMlA1dlNuQVdmSmlRYTd3M21tSTZnTFNBVlVsUmpa?=
 =?utf-8?B?SzhZNHNiUXpXb0xTeEhsUWRaeGRQQ3dDQk51YW1mNS9ydkVSSCtRaEY5WElh?=
 =?utf-8?B?QnNDREZtaVJvd3RoSjQ3SXFUVVlNbFdFMUJUOXpFZ3dGcE1xN043TmQ0WTIz?=
 =?utf-8?B?WEk5dzlZa3g4Wk50WlV3bDE2ZVg3WnYzenZONFIwOTEwYVdGcjBIVWV3M2tX?=
 =?utf-8?B?WG1rN3lXWURUeWpTdlowMitOcmIwVzcyZTJIVmhsOGJXQzIyS2tPbEFNZHFI?=
 =?utf-8?B?V1N0U1BvdHRFZXk2UG9iY3hQQkZ3TnUzaEU2czhleENGMXFDRk1rVk14Ynd3?=
 =?utf-8?B?UTFUTXJialM1d2IveWM0Q2VvMGhuV2dCM1FPYlR3VXdKNTVVSzExVGlTMXp5?=
 =?utf-8?B?bFF2WkM2TExPOFFXN2RGVUo0bVR5Vm5FSFJhWXRqOG5PeXJEMjRONnZSSWcv?=
 =?utf-8?B?U2NJUHlmeFJwaTZLRHJkL1lDcFVzZXREWjZMYVY1QUZhVUQrc3dCdEJpN1BQ?=
 =?utf-8?B?bmRSWWYxTk9QRk42a1ppVVViWFlwdVFld0prVVc1d1p4eDFSNlJyaUYzUzF0?=
 =?utf-8?B?R2xHaU9ZckFrUlB2WFIzbkUxNTRVTWR6Mlk5TThWZXpMS0lzZ0tjZ2ZxTFpB?=
 =?utf-8?B?aHVyUUVWZ05hVExGK3pCOG9ReUZ1cll4QWhzNFNRR2hvTUd2MVNPcnpwa2VC?=
 =?utf-8?B?a216TjBnMU5zOG41VFNqNUhjaEgxQTIvZE5CK0ZKam9RbW41SUZUbnZCVmRW?=
 =?utf-8?B?VlVneDZ0eHlRd0U1dDNsc2hvbmFZcGZWZkh2VDB2SWIyUFpTTWVvQW94WjA3?=
 =?utf-8?B?MUNaNDdaZThXNTNlS1VsOGF0TFY5bUIyNWwrbTdvQW9KYUEvOXdoK2pGTVJL?=
 =?utf-8?B?cURtYnVlZnNVWGQwUjI0NVRoRloxS0tQclN5RTVWL20xWGx6Y3p2V0VVYWxM?=
 =?utf-8?B?U1k0N3QreUdWT2cxVjlVNEUzUTMwYkZNdTFEejY5Sk5HSmF5TjN3Z0pYcllQ?=
 =?utf-8?B?ejhEYjdPeEU4VEpFR1Iva2NDSUJ6T1Q5blZEZ0U4eGpING5mci9LWUpSZlNp?=
 =?utf-8?B?dTlvVkdGblRtYmM2Y2dOS0RZYmJxVHdHNE9FREJzbDRzVHozem9Demh0YVZ5?=
 =?utf-8?B?V0FSdnpvb1J5VDMrUS9PaVFSL0o2Nm51WlRwaXpPRlFiMmc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WFNtWWNxRlc3aUprLzU1N2FBR2NkS3ozRWdHc0xwVWJsTGJtcGt5SFRaZ2or?=
 =?utf-8?B?T09oNFNld09wWk1UUnY1K2V1SUx0VDNtemxNOVJsZm0xbldFODBHQWtPQWtP?=
 =?utf-8?B?c1BlaWFMR09mZTRDMTE1eDNlQnh2a2FqRTdWV2lFbTJBR1hrSGhzd3h2OHFr?=
 =?utf-8?B?YjkvVkRnd1dHbUd1aXlydkVlVVNyWGUrZ3V2RVBseVhJdmUwbmNQSFhlVzdW?=
 =?utf-8?B?a3RLaE1WYmZVeFhZVEZ0NFBWemR4TDVPaHZiRVVEcVZSYVhOUHduNyticnBI?=
 =?utf-8?B?dGVOZDA2blR1R2NhRk9aL0lCWmJLb3pKNEdMZE1RSmU3M2N6WnZsS3BtZENY?=
 =?utf-8?B?TVJJdm1zWTdSVW1oTzQ3LzI3TWVUM0h6by95WUxrMVgvb2p0WDF4NFZ3bGVJ?=
 =?utf-8?B?MWhaMEJVTERmRUFVd0RSTHlxMVR2WDlETTBTL3huVkU4cEd5aXdSNEYrTUlr?=
 =?utf-8?B?NDlLNHZGZ01TTHJ5cGF3bkRHR000Z1poWFVsanltTlArZzJvYzNhRDk2V3NY?=
 =?utf-8?B?VkhOUHF1RTV0R3UyZFlBd1BjTFo2YlBDSm5pTEMyaGRiSVM2QXZVOTZvY0w5?=
 =?utf-8?B?Uy9aRFdZSjFWMnh3d3VtZmJ0YW04YkFhQ2pXR3Y0M0JITU54cHhEdGVnYnl4?=
 =?utf-8?B?bUdJQWNxZmdYZElIQTVhQ2czZU0reVZWQWlLK205R2dVSG5Udk9hL0hxRzln?=
 =?utf-8?B?SWlLS2lkSHc1c3NDN2VTMVRYd1hLajRMOXVUTi9FaW53c0ZuUGFSY09aMEQ1?=
 =?utf-8?B?NXdpYkQyc0RxSk16NlNMWk5JeEtxRGx5UHZrcExoY1JsVVpmL0tueEdLdjI4?=
 =?utf-8?B?MlUwY0pHUDBDblQ5Y2JYWWlRMmt5K25hR25aRGJucU9XUFBpRU81RkdOS3NV?=
 =?utf-8?B?NGZWYVpCYkk1QmUvVXQvdTVRdVJnZjBibE4xNFU1RjhpaER5SXpuTWtFVmFv?=
 =?utf-8?B?eUl4SEg1b0NmSG4rOXVJbTNnNUJGQlQyRFpwTzJWZ2lTTml5TzhyRzFjbzdu?=
 =?utf-8?B?dE5OSlJpQzZyNXd0VGgxVmZ4dklGbHlicjBOeG9ZUStIMWVMbW9Ia0RxNUJk?=
 =?utf-8?B?TGdJQ1FWNFh6Q3d6OXBpeWd3WHdOQXhuSDlMWXRzbkhzYk50REhUelRYOFo5?=
 =?utf-8?B?eGhBaWFZL0ZhN1d4dWZCWUF3SGZKOHRSOWxvNWorQmNRY1V3YWJMK0ZJNmhu?=
 =?utf-8?B?QXBMN29YL01QSE1IYUphTlNLOGZ5NXZyZUlzcGE2bmJmbTZaaThoSnJqVktz?=
 =?utf-8?B?YkJ1MG9RVDU1VFJ4N3h1RUZMemhHaTF1Nm41clI4YTdtQWs1czdvL2JIQ29q?=
 =?utf-8?B?RE9nbmlPRSthVXUzY1U3eU44aVpDN0pqNEtJQzNXTnZGY3o3Y1cvcnFNZU9j?=
 =?utf-8?B?Snh5TzhwMDV0MEhKOXhWOEViS05QUjh3ZEZ2Qk5UaUIyKzkyOWR4THk0ZHBw?=
 =?utf-8?B?OURnTnBMMm1xN2VkQ3d0SWpoOHd5clhpcUh4eEVhWkJ2NUt0TW1aQ1poSWxM?=
 =?utf-8?B?QUJhTThoVFFKSk9VVVBLb0U5RWpEQWozWTEwWGpFTjBkREJKZHpCUmdoaDB5?=
 =?utf-8?B?VGFad1A3ZDRvdUVud0plK1hqR1BJSjFuTCsxZTR5MnllaVgwa3ZpNTVIbXJW?=
 =?utf-8?B?ejVhbE52Ui8rWHZIeXl1b1ZpbHRHblhCZ3luTE1ZZ3VSUkVtU1V6UnlNNXBU?=
 =?utf-8?B?cElyVi9rUjE1Y09HUXA3RWVtU3NJeTJCVjVGQ1J1NWs2WkRCMjFEckJkdkJU?=
 =?utf-8?B?b0hocjBHRjBPUkk1cmk3Z3hIQ1BmZW5rTm0wVVdKQ3FJZlg0MHpwMU9lTlRI?=
 =?utf-8?B?S05ZRDdsaHlDTDdQbDA0V3JBUDNMbnd6dkFMU3FoNDFtVFlnYzJBYUFNKytD?=
 =?utf-8?B?TlNqWmpuVitHVVA3azN2UWZRUG1UOS9rMzJnaE9HUUs1TkFUQWEzcjc4dXlZ?=
 =?utf-8?B?dGJqNW95bGVhSkthdjM5VWpvVmk0Q29sNmE3SmM4dUNKeVB5N2d4MG5JcC9Y?=
 =?utf-8?B?WHdkU0hzQ2NhbmNZWXFMUXRVOUF3emFaV081S21MUFh5YnR0eU01NVp3V21S?=
 =?utf-8?B?eUxIQS9RNXZlNjN2MzFYaEUvU1FvQUY3MGlVNG10c2R2OGFDUlI5cC9ySDU5?=
 =?utf-8?B?YUk3TEpnanB6VWdHSUJKeENwVFVUTVA5YitGbFQxSnFsN3pnV3ZSRDRKcHg5?=
 =?utf-8?B?Y0QwZE1UbmFXMVdLejQzUHBIbjU4aDhjZXQ0N2JZb3YzN0xUNkpEUUw3Q2VH?=
 =?utf-8?Q?DOKFpKPOkA5KuU5E3ny4ZVvMemYBN1HvVKCmmzA+c0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b86c2f-26e0-4b92-8043-08dcd23696cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 07:51:47.9514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTyA3itxfwHPW7SQMNWxgCWflpmC9czRul4plCDyO06ev5dYauQu1E5Ha4uOXWQ17SKHl5fo84/Y+jwS3ve83ELrfrGE2nZfCDMu2JWJEO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6138
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACC69F940CF56D4BBFBA3D2A81B33ED4@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Sep 2024 08:57:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16881

T24gTW9uLCAyMDI0LTA5LTA5IGF0IDEzOjQzICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAwOS4wOS4yNCAxMzoyMSwgUXVpcmluIEd5bHN0b3JmZiB3cm90ZToNCj4gPiBGcm9tOiBRdWly
aW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5j
b20+DQo+ID4gLS0tDQo+ID4gwqBkb2MvUkVBRE1FLnN3dXBkYXRlLm1kIHwgMTYgKysrKysrKysr
KysrKystLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RvYy9SRUFETUUuc3d1cGRhdGUubWQgYi9k
b2MvUkVBRE1FLnN3dXBkYXRlLm1kDQo+ID4gaW5kZXggYTVmYmFiOS4uNDIxY2ExYyAxMDA2NDQN
Cj4gPiAtLS0gYS9kb2MvUkVBRE1FLnN3dXBkYXRlLm1kDQo+ID4gKysrIGIvZG9jL1JFQURNRS5z
d3VwZGF0ZS5tZA0KPiA+IEBAIC0xMzgsNiArMTM4LDcgQEAgUFJFRkVSUkVEX1BST1ZJREVSX3N3
dXBkYXRlLWNlcnRpZmljYXRlcy1rZXkgPQ0KPiA+ICJzd3VwZGF0ZS1jZXJ0aWZpY2F0ZXMta2V5
Ig0KPiA+IMKgUFJFRkVSUkVEX1BST1ZJREVSX3N3dXBkYXRlLWNlcnRpZmljYXRlcyA9ICJzd3Vw
ZGF0ZS1jZXJ0aWZpY2F0ZXMiDQo+ID4gwqBTV1VfU0lHTl9DRVJUID0gIjxzaWdpbmluZyBjZXJ0
aWZpY2F0ZSBmaWxlIG5hbWU+Ig0KPiA+IMKgU1dVX1NJR05fS0VZwqAgPSAiPHNpZ2luZyBrZXkg
ZmlsZSBuYW1lPiINCj4gPiArSU1BR0VfSU5TVEFMTCArPSAiJHtAJ3N3dXBkYXRlLWNlcnRpZmlj
YXRlcycgaWYNCj4gPiBiYi51dGlscy50b19ib29sZWFuKGQuZ2V0VmFyKCdTV1VfU0lHTkVEJykp
IGVsc2UgJyd9Ig0KPiA+IMKgYGBgDQo+ID4gwqANCj4gPiDCoFRoZSBmaWxlcyBgPHNpZ2luaW5n
IGNlcnRpZmljYXRlIGZpbGUgbmFtZT5gIGFuZCBgPHNpZ2luZyBrZXkgZmlsZQ0KPiA+IG5hbWU+
YCBuZWVkIHRvIGJlIHN0b3JlZA0KPiA+IEBAIC0xNDUsOCArMTQ2LDE5IEBAIGluIGByZWNpcGVz
LWRldnRvb2xzL3N3dXBkYXRlLQ0KPiA+IGNlcnRpZmljYXRlcy9maWxlcy9gIG9yIGluIGEgcGF0
aCBkZWZpbmVkIGJ5IGFuIGJiDQo+ID4gwqANCj4gPiDCoCMjIyBzaWduaW5nIHNjcmlwdA0KPiA+
IMKgDQo+ID4gLVRoZSBwcm92aWRlZCBbY21zIHNpZ25pbmcgc2NyaXB0XSguL3JlY2lwZXMtZGV2
dG9vbHMvc3d1cGRhdGUtDQo+ID4gY2VydGlmaWNhdGVzL2ZpbGVzL3NpZ24tc3d1LWNtcykNCj4g
PiAtY2FuIGJlIHJlcGxhY2VkIGJ5IHNldHRpbmcgdGhlIHZhcmlhYmxlIGBTV1VfU0lHTl9TQ1JJ
UFRgLg0KPiA+ICtUaGUgcGFja2FnZSBbc3d1cGRhdGUtc2lnbmVyXShyZWNpcGVzLWRldnRvb2xz
L3N3dXBkYXRlLXNpZ25lci8pDQo+ID4gcHJvdmlkZXMgYSBbY21zIHNpZ25pbmcgc2NyaXB0XSgu
L3JlY2lwZXMtZGV2dG9vbHMvc3d1cGRhdGUtDQo+ID4gY2VydGlmaWNhdGVzL2ZpbGVzL3NpZ24t
c3d1LWNtcykuDQo+ID4gK1RoaXMgc2NyaXB0IGNhbiBiZSByZXBsYWNlZCBieSBzZXR0aW5nIHRo
ZSB2YXJpYWJsZQ0KPiA+IGBTV1VfU0lHTl9TQ1JJUFRgLg0KPiANCj4gIldoZW4gcmV1c2luZyB0
aGlzIHJlY2lwZSB0byBpbmplY3QgYSBkaWZmZXJlbnQgc2lnbmluZyB0b29sLCB5b3UgbWF5DQo+
IGFkanVzdCBgU1dVX1NJR05fU0NSSVBUYCBhcyBuZWVkZWQuIiBKdXN0IHNldHRpbmcgdGhhdCB2
YXJpYWJsZSB3aWxsDQo+IGxpa2VseSBub3QgaGVscC4uLg0KDQpJIHByb3Bvc2UgdG8gY29tcGxl
dGVseSBkcm9wIHRoaXMgaW50ZXJmYWNlLiBJZiB5b3UgbmVlZCB0byB1c2UgYQ0KZGlmZmVyZW50
IHNjcmlwdCwgcHJvdmlkZSBpdCB2aWEgYSBkZWRpY2F0ZWQgcGFja2FnZS4NCg0KPiANCj4gPiAr
DQo+ID4gKw0KPiANCj4gT25lIG5ld2xpbmUgb25seSBoZXJlLg0KPiANCj4gPiArQWx0ZXJuYXRp
dmVseSBhbiBvd24gc2lnbmluZyBzY3JpcHQgY2FuIGJlIHVzZWQgYnkgYWRkaW5nIHRoZQ0KPiA+
IGZvbGxvd2luZyBsaW5lczoNCj4gPiArYGBgDQo+ID4gK0lNQUdFUl9CVUlMRF9ERVBTOnJlbW92
ZTpzd3UgPSAic3d1cGRhdGUtc2lnbmVyIg0KPiA+ICtJTUFHRVJfSU5TVEFMTDpyZW1vdmU6c3d1
ID0gInN3dXBkYXRlLXNpZ25lciINCj4gPiArSU1BR0VSX0JVSUxEX0RFUFM6c3d1ICs9ICIke0An
PG93biBzaWduaW5nIHBhY2thZ2U+JyBpZg0KPiA+IGJiLnV0aWxzLnRvX2Jvb2xlYW4oZC5nZXRW
YXIoJ1NXVV9TSUdORUQnKSkgZWxzZSAnJ30iDQo+ID4gK0lNQUdFUl9JTlNUQUxMOnN3dSArPSAi
JHtAJzxvd24gc2lnbmluZyBwYWNrYWdlPicgaWYNCj4gPiBiYi51dGlscy50b19ib29sZWFuKGQu
Z2V0VmFyKCdTV1VfU0lHTkVEJykpIGVsc2UgJyd9Ig0KPiA+ICtgYGANCj4gDQo+IFVnbHkuIEFu
IGFsdGVybmF0aXZlIHBhY2thZ2Ugc2hvdWxkIHNpbXBseSBQUk9WSURFUyBzd3VkcGF0ZS1zaWdu
ZXIsDQo+IGFuZA0KPiBvbmUgc2hvdWxkIHNldCB0aGUgUFJFRkVSUkVEX1BST0lWREVSX3N3dXBk
YXRlLXNpZ25lciB0aGVuLiBUaGF0J3MNCj4gbW9yZQ0KPiBiaXRiYWtlL09FL2lzYXItbGlrZS4N
Cg0KRnVsbHkgYWdyZWUgd2l0aCBKYW4uIFBsZWFzZSBpbXBsZW1lbnQgaXMgc2ltaWxhciB0byB0
aGUgc2VjdXJlLWJvb3QNCnNpZ25pbmcgcGF0dGVybi4NCg0KRmVsaXgNCg0KPiANCj4gPiArDQo+
ID4gK1RoZSBwYWNrYWdlIGA8b3duIHNpZ25pbmcgcGFja2FnZT5gIG5lZWRzIHRvIGluc3RhbGwg
YSBleGVjdXRhYmxlDQo+ID4gdG8gYC91c3IvYmluL3NpZ24tc3d1YC4NCj4gPiDCoA0KPiA+IMKg
IyMgU1dVcGRhdGUgSGFyZHdhcmUgY29tcGF0aWJpbGl0eQ0KPiA+IMKgDQo+IA0KPiBKYW4NCj4g
DQoNCi0tIA0KU2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENlbnRlcg0KDQoN
Cg==

