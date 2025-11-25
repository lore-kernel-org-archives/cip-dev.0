Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D53CD0E6D2
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 12:40:49 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16145.1764074438947812376
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Nov 2025 04:40:39 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 5APCeahr1717143; Tue, 25 Nov 2025 21:40:36 +0900
X-Iguazu-Qid: 2yAauG5CeX8rNGCznk
X-Iguazu-QSIG: v=2; s=0; t=1764074436; q=2yAauG5CeX8rNGCznk; m=eYwdy77mDPOnbI6jaZuwNlispSXy5f5mTAN2Hei3vxA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dG2NM60xGz1xnc; Tue, 25 Nov 2025 21:40:35 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovPlqGuJVQRqjmeKJ5jiCADYsdHvM3eHH3mDsi36c8po5l8v00edEtjHejYAA/u7bUXIsT0mO0H8/HRjl1ZY+ufphg8AtLy1czUgoAsj9ahIJQl+4PdeWBJc4drkXPnkhPDyKLGBr0ZVeAOcVa3G23xSTDpsfcsRMLllQemtTi4Edx58TccIfkxfsPXIb9XnVsPUIRFZbC5mWya5Z6isWOZryXujJXL5d/VhYei3ZlBn2fmj1xcYSLso4PVkZ6n6LNDV0hgimXUBqYmhsj4k6twpC7jtbCgyGKL8VZL9qE9jLJEWE7KThsD1Wn3P2jFodO/zKzQkxuFQ07McK1XvSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmU6ckB53gzYBErFbRmN08iyrzKyvuezA9EqyFIRyfY=;
 b=S6sPs047ORD7I11j6/3JxhhYmcg5RfFif0mD0DhgGIswdyNEV4IiGiGkhb6AZ9k2+4My4tQKjB7M9OGCu0PZXC9M/ntMLvz5owqe2ZncYH+vv54rDHakl6c28dMXzAkRsM+ygk++dYqIZGRPJKR0FfnG8y8aObMAIIWvwA5DEXDHhVXzOojIv8B9yGF/ySIPWoIizqCvAcCJZXsRLNGdDFHN4ukpJUerW/tvxygQzvHRZqAuelkNQ65bhRJM2CNERkaeVbDbO/eyV23rHA4mfkTkNB6DO3Xg3a4kGoy4zGPRdZmvctyps3zk0TCVkbUMGRvt64TtgSvi0xWIsKBNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <Shivanand.Kunijadar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro.hayashi.f74@mail.toshiba>, <gourav.singh.ext@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH] fix(security): add
 libpam-systemd in Debian trixie
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] fix(security): add
 libpam-systemd in Debian trixie
Thread-Index: AQHcXQ69R6Q1BApOAkuzqAWsEybwfLUCBxxHgAFNOhCAAAIcjA==
Date: Tue, 25 Nov 2025 12:40:28 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669E7DC641E610491AC078CC4D1A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20251124050607.876836-1-gourav.singh.ext@siemens.com>
 <345f8c1e-0166-4946-893b-02dba9dd71ce@siemens.com>
 <KL1PR0601MB4697CEAF6AACC78EAB99E5CBD5D0A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
 <e3ea7e4e-7679-4ddb-9074-fab4f51c8c8a@siemens.com>
 <KL1PR0601MB4697F954236371E6E07F0C35D5D1A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
 <d0b5fe55-f030-487e-b75b-a7fd9d761648@siemens.com>
In-Reply-To: <d0b5fe55-f030-487e-b75b-a7fd9d761648@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TYCPR01MB6622:EE_
x-ms-office365-filtering-correlation-id: 8ed7be17-9e02-413c-95fe-08de2c1fd09d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|13003099007|7053199007|8096899003|38070700021|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?RC9SQkl1WkE3M2EreWdiYXRsZnJLWmN6OC8yL3lZMk1sS3IxSFRjbHBL?=
 =?iso-2022-jp?B?NEJROUdhOUpXbThheFBNQVlaU3d6MzYxUDcwRjhOUnZNZjZoc1I5ZWNu?=
 =?iso-2022-jp?B?UFZuZjROK0xySEZ6YnVkTVNmclhCaGlyMXBOOFRHNkR3WU1LTFhlWnIz?=
 =?iso-2022-jp?B?WFZBbzJTdUVFR0hoZ1pkTWhGdGkvbkNpbjUxeVp1UUlhT0d2aWNTNkdT?=
 =?iso-2022-jp?B?cDNkZ2lidGQ5bXhqL1R2bWF4VVplSzRnWjFBM21aeEVKSXdQc2p0SEE1?=
 =?iso-2022-jp?B?c0RDVkU2dEdGQkpCdHByT2RLSjNGeWRQL3NrLy9XUFFJalU1TitKQ2Z5?=
 =?iso-2022-jp?B?bG9UZzVtNWI4Vi90d0VDMDVGZzJmUWpQSUtSN002dC93ejF1Q25HNGtL?=
 =?iso-2022-jp?B?eE0xVkNBWjM2bFljVVl0STA4aldiVWFsU21xT2EwbFRObWRmcjlyV0tI?=
 =?iso-2022-jp?B?Y2daNGpxd0UwYnd1ZnFYUHJ6WWJQTUs0SzFNMjBITG1RYWkyak5LTm1u?=
 =?iso-2022-jp?B?cUJXTjE5RlRlK1Rzb1RhV0daTW5DSUw4RTNxSGRMQ0dOYTZ6K0tQZXUr?=
 =?iso-2022-jp?B?aEtMM1d4WThYMnJvSEdJcTl1ajdVc2k0NVFsc0tyRmFrMnRCenVoOVRL?=
 =?iso-2022-jp?B?c3Z6TWc1UkR6cnViY1lzMkZmTFNHR2VOdmwyakQ0Z1lxUE1iTjdVak1a?=
 =?iso-2022-jp?B?dEpjb1h1SHNwMWFXM2dZYnVyNExPSUYwTDhoZDNNaVpZMFkwa0tORXpE?=
 =?iso-2022-jp?B?MHFYa2dKZ2t6eFQ4NXZ4aVJiK3ZGamJBUitKTDZtM3NyZnk4OE5aM2oy?=
 =?iso-2022-jp?B?WXJaekVlamtIZUZaS1V1bjZRN3EzTUZRSmxuUmlXL25oUytFOFdWeEJD?=
 =?iso-2022-jp?B?OEZtdG5uZ1pDUDdndTY2aGl6dEljQ0pHK0VPbFFtaVBSZnZSOXdCMXJQ?=
 =?iso-2022-jp?B?aUlIbkJMR2xvRGl0RTNuZUpiL0xsUnc4Qk1LUnNkQ2s4bHZvR3BJcjVh?=
 =?iso-2022-jp?B?SUYyRDVBN2l1cjZTNG9VbldqcWNjeERBMGdUbTAzc0tGRUtzMzJ2SzBW?=
 =?iso-2022-jp?B?b3B4MFJhcXBNMWVVTnJuM282TXBSWHhDc01BeXZIVHhmcUhXOXJ3OWdz?=
 =?iso-2022-jp?B?anF0NE9vVUx4aHd0YjFjVXA3ZzRtNUxnTWRHbVJ1T1NjejhORUdmbDl4?=
 =?iso-2022-jp?B?bGlPMUo1SDJ1YWxybmlrclNLNkoxRHJQa3VIUFdGZlcvSDd6L25kTjJC?=
 =?iso-2022-jp?B?eWJ4dFZxYWtwRXlhcHI3aVdLQmtjaWJnTnFqMlRYbnFZaXRiSmtjMjdD?=
 =?iso-2022-jp?B?d0l6NFpISUg2TDRyWTZwQ1ZUdktycUdrNWhhckd5K3VzZ0dYaFpJRWtx?=
 =?iso-2022-jp?B?TEFxbEZiQ0lwVnRRRFc2dDk3VGtVOWY1WnNHZ1FSM2cxUE54L2RhbE4z?=
 =?iso-2022-jp?B?SFQvOWY4OEU2dFN6aWFNZkxSMnhVRVVkTzVxMlNVZmFYaW1wejhBRVVr?=
 =?iso-2022-jp?B?OGNvTHgvVVYrd2phSlBoeTdOTmZHRUdQVGtXaDVlZjIrWXN5K1BzTW9w?=
 =?iso-2022-jp?B?STh6Z2hQNlZsVWRCTUUvNzR4eUFDdUMvZ0dEbXg5WDlKR1Q1UFBtOWxq?=
 =?iso-2022-jp?B?bDB3MHEvZVQ4MjhvdUFHNithTHZaN0hReGFmNDk5Y1FpVUEwMzU5bHND?=
 =?iso-2022-jp?B?aGJ0Szl6L0J5UHVqdFVhM3dRdHZuRTJNNGpiSDhlUmJVWEhUS0FMc3I2?=
 =?iso-2022-jp?B?L04zYVIwRjlWVU5OcU1nVTRMSjJoK0Q1aE9aSkZTS1BaWmx3dWJoWDhi?=
 =?iso-2022-jp?B?V1ZlWjZrcDNoejh1UFlvSnhyNnRjL0NvbXpBekVsbHAwWllrNkFUUXZs?=
 =?iso-2022-jp?B?M29uL2lxekNiN0JxRDFBb2Uyc3VNUUpYR25FUEJrcTY0MGMxNXRndlNp?=
 =?iso-2022-jp?B?MVpnd1YwODYzb2E5Um5MUEhXc3RtWVZ4dVBIRUgrMXhKZWFqaGtaTmlV?=
 =?iso-2022-jp?B?M0pxSk5lN1dzZGdLdFFyOVpFN2g3YzJmTkVnaUtFT2MybmtoQXZrK2VW?=
 =?iso-2022-jp?B?dWNyVk41QTlVa1ZtL2d6MmVrSGlpYjBJdmJpVGtrdlRkaTNDbXBMdnFv?=
 =?iso-2022-jp?B?M2ZDc2Q5T0dsWE9oNjQvTVJZc1NtaDZQdEk5REc2MlBRUVV0akJOWWMx?=
 =?iso-2022-jp?B?V1pMVDJYU2FjWlJMcmNTQWU2T1M4cWFKQno5dlo4Y2doeTYvWlJxWDZ6?=
 =?iso-2022-jp?B?MFlqRTU1aC9TMmp4VU9iVXJvcWg5WFdoMD0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(7053199007)(8096899003)(38070700021)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RDUrTm55MzdQUXduUFZtZXhCQzNLdHM4UE9icGFjWHdhbUo5VTBGYTVs?=
 =?iso-2022-jp?B?aFZ3ZWs1YzJiLzRGclBDV3hjNGdoajI4bHRBd2VyNUg1N09hVnNRWjFH?=
 =?iso-2022-jp?B?WElPRXFxRVkyLzZxWEFHcGJOUFV1R2FvNjdxc2tpMDBDaG5uZ05jb0Ra?=
 =?iso-2022-jp?B?ZGdLTDEzNjhITzdadXNkZ3Z3WEkvekdXQmtEZThldlRjOHNmY2l5K3o3?=
 =?iso-2022-jp?B?K1R3dTAzTEFCZk1aRVdJeVI1bHlTaFoxSWtjeFg0bUNjVGo0M1VBRjNq?=
 =?iso-2022-jp?B?UjhTaVlhZm1ldEpJbENWbWkxdDB1OEVYSXhiZnJWUEt2VFhUNmJTd3Nz?=
 =?iso-2022-jp?B?Zko4Qy9qTFYwYzRBRHBrc0dQQzZEbGRScVorREwreE0yc0EzTThwRkUx?=
 =?iso-2022-jp?B?WXBPbWc1cG02VjRxZjFJcTh4SjdQejVoOUIrdmJGdjNSUDgrUk1mWjl6?=
 =?iso-2022-jp?B?SGRGMnlMNzVZdjFTTzJvVlcxOFFMOS9ISzNzaVV1cGtNOHBkVENCY2l6?=
 =?iso-2022-jp?B?YmR4aGppckFkemdYbzRZWW9UdmNGODJuV2R2N2gyZU9VVUh6c0NON05V?=
 =?iso-2022-jp?B?UjFlYUcvU1FaeEFCSHVUaGw4M2VoclRZeHJ0TDEweXVqems5VEZPOHRa?=
 =?iso-2022-jp?B?TzJBTE00Vms3Q2hKSHYxTzZ0dnYrZGwvY2ZlRm04M1gxbnFTc24wd2di?=
 =?iso-2022-jp?B?MTMrcElDdC96M2cxakVGS3BXRTJWRGI4TjZyc0tBZlA1OEpwYU4ydkJa?=
 =?iso-2022-jp?B?MWJubjFVSUpaZG8xcnBKYVlEZ0pwRUI1ZWlpc2drUGRaWm9ZeGRtNXB4?=
 =?iso-2022-jp?B?a3lsdjBsZkRmc2h5TDJReE5GZEwvSFg2TWVuZ040QVFGcmIrVDVwSUxq?=
 =?iso-2022-jp?B?Q0xrNVVjcFpjTzd6VFpXcUR4RHRvUnc3WVZlb1VwVmZPbWk3ZUZjQUdp?=
 =?iso-2022-jp?B?ZHJIc29EdGI3eVF6dHM4bUVZM0h4dllubFB6cXBGWks0bk9VcXhISHZy?=
 =?iso-2022-jp?B?c2E2MEludGppYjcyZEpzamx5bWxuL1FWUXM1Ly9vb3F2eW9LZDFSNlhE?=
 =?iso-2022-jp?B?VEhjdWs5ZW9HR2EzL2dSRm02UlBwcWxnRXdxWjk5SkJZNGNEUDU2WWFZ?=
 =?iso-2022-jp?B?ZlJLVUpacWlLSlBMNjdkWXVac3A1TUVJU2ZPdUNDOEUrK1U4eG1xWlhk?=
 =?iso-2022-jp?B?ckJqMnNFR3lQMy9wWHBFNmduOEJZMG5WLytlMEMyVVdaTzJwQnFRN2Mv?=
 =?iso-2022-jp?B?TGc5T0srcWdzMzVjWGhPR2FKMk42ZEhlRnlqZ05wc0hSQTlqNGtFNjdX?=
 =?iso-2022-jp?B?QmFXOC9sVjJOeFNvMjEyWVp5T3FGVzgzZ3RKL09QcDh3MllWZ21QdGYv?=
 =?iso-2022-jp?B?eDJuSzJXeGJjb0htWFIvNkhxZ3lQUEMrWEZocXllcm9hY015R3RWdUtr?=
 =?iso-2022-jp?B?QkV3MkIxd2pmYkJRaGhkMVdVRWxpd1dxSFhIS1dCdWVrbjIyTGxBbjFN?=
 =?iso-2022-jp?B?Q1UxUWFEMEdPeERhVURnN3ljYjlXNWpHMFhzcTl3cy9Wd1pqRzBHeTMv?=
 =?iso-2022-jp?B?NW0vVjZ4RGtzWFNNV3JESU1EYlRlbm5RaS9lTHF6KzN4TDlGMjdOYkFw?=
 =?iso-2022-jp?B?LzdleGZyMEwzK1FlRFovdzE2R3UyaFRVdWdQM2NuYldESmMvTDFjZnli?=
 =?iso-2022-jp?B?ZWhDV0VMeENPN2JnU0ZzSWNQQkU1RHRrMlpZY2NOU3FtUCt0NjVIVUU2?=
 =?iso-2022-jp?B?VnBBZXE0ZmtRTGpFZWV1eDhTbVVrS2crbVR2TjhCWnZ6RjdaSW9EblJM?=
 =?iso-2022-jp?B?aVRpY3h1K212WEt6cWVxVVdWK0lWbGROV25Qd1ZKZEFSRDJvcGcrM2Js?=
 =?iso-2022-jp?B?T2pOaTMreUVhYnhtMlloeG9aS3YxRHVveGgxYUlOMzBOZmhZMDN0OHdX?=
 =?iso-2022-jp?B?YmNsNnI1Z2tZZ0I3NUhOUHRZZ1pZYU8wMGllQWU1dHc5RVovMjVJVkx6?=
 =?iso-2022-jp?B?bU03WXh4cFdaZnVCUURVK2pIeWxOMG11L1BsbXZERW1zRzVua0tHTWI0?=
 =?iso-2022-jp?B?MmtUcWtqWVoxVkxMTURiZzlVc0JBL2U2YXJ2SGpJVlgrWFg3NCttSTdq?=
 =?iso-2022-jp?B?bVJUcTNBUHI0OTJEdFg5Sm5ZbUU1TGRmN09XamQrZlN5aFEzZjlwbmNF?=
 =?iso-2022-jp?B?RDZTcE5YUEU4QUxQMXY1Q3E0dWo2S0NhRk83dHcwbE00Mk5TVUlwMDlV?=
 =?iso-2022-jp?B?NCtMeGlpODI5VmZKcGNlWDFsQTRGbzFjcDRNajA4R0JNQnF6ZDI5bUFB?=
 =?iso-2022-jp?B?NWxKd0VoM3lKQURIc2dSUkxXOWhUV0NPWXc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB9669E7DC641E610491AC078CC4D1ATYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed7be17-9e02-413c-95fe-08de2c1fd09d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 12:40:28.8046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCqShmHXJLyBverFCFMljI4DTMGs+xPThw96MykKN0Uvk4iH7t+eq7DzIOikdkUIqgiPTjDCDRtdnKUHd1np5gjvr0m86lTT5Jq+qO6QucZzaq1iONL7pICS/QAZlc16
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6622
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Nov 2025 12:40:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20726

--_000_TYCPR01MB9669E7DC641E610491AC078CC4D1ATYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Sorry to jump in

>but we still have a red pipeline for bookworm right now:
>https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/12206266133.
>I hope it is not regressions.

The above failure is due to [1]. We're waiting on the updated merged config=
s for arm.

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/140

Regards,
Adithya Balakumar

________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Jan Kiszka via lists.cip-project.org <jan.kiszka=3Dsiemens.com@lists.=
cip-project.org>
Sent: Tuesday, November 25, 2025 5:59 PM
To: Singh, Gourav (ext) (FT FDS CES LX PBU 2) <gourav.singh.ext@siemens.com=
>; cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Cc: kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Shivanand.Kunijad=
ar@toshiba-tsip.com>; dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh=
.kumar@toshiba-tsip.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$=
B""#D#I#T#C!{#C#P#T=1B(B) <kazuhiro.hayashi.f74@mail.toshiba>
Subject: Re: [cip-dev] [isar-cip-core][PATCH] fix(security): add libpam-sys=
temd in Debian trixie

On 25.11.25 12:08, Singh, Gourav (ext) (FT FDS CES LX PBU 2) wrote:
> Hi Jan,
>
> After applying these changes, the IEC test suite now passes all test case=
s on the Trixie image. I've verified this on my end, and I'm attaching the =
results log file for the test suite run on
> the cip-core-image-security Trixie image.

The patch is now also in next. I lost a bit track when what started to
fail, but we still have a red pipeline for bookworm right now:
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/12206266133.
I hope it is not regressions.

In any case, I would appreciate if people familiar with the test suites
could sort out what the pending issues are. The bookworm-based pipeline
for qemu will stay BTW even when we moved with the defaults to trixie
because it remains relevant for the security WG.

Thanks,
Jan

>
> Thanks,
> Gourav
>
> -----Original Message-----
> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
> Sent: 24 November 2025 22:07
> To: Singh, Gourav (ext) (FT FDS CES LX PBU 2) <gourav.singh.ext@siemens.c=
om>; cip-dev@lists.cip-project.org
> Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>; dinesh.ku=
mar@toshiba-tsip.com; Kazuhiro Hayashi <kazuhiro.hayashi.f74@mail.toshiba>
> Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd in =
Debian trixie
>
> On 24.11.25 17:30, Singh, Gourav (ext) (FT FDS CES LX PBU 2) wrote:
>> Hi Jan,
>>
>> Regarding customizations or configurations for the `libpam-systemd` pack=
age, which provides `pam_systemd.so` - a new systemd mechanism that replace=
s the traditional `/run/utmp` for tracking active user sessions in Debian T=
rixie - it is necessary to ensure that `pam_systemd.so` is included in `/et=
c/pam.d/common-session`. This replaces the traditional role of `/run/utmp` =
in session management.
>> Ref:
>> https://list
>> s.debian.org%2Fdebian-release%2F2024%2F05%2Fmsg00150.html&data=3D05%7C02
>> %7Cgourav.singh.ext%40siemens.com%7C69f7415c2bc3402b8cde08de2b77b21d%7
>> C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638995990271096290%7CUnkno
>> wn%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXa
>> W4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DzbwdGBW1zzz
>> p3xN5q0UW3qN5o1MXmzbBmJv3uQdILhY%3D&reserved=3D0,
>> https://ddp-
>> team.pages.debian.net%2Frelease-notes%2Fen%2Fhtml%2Fissues.html%23the-
>> last-lastb-and-lastlog-commands-have-been-replaced&data=3D05%7C02%7Cgour
>> av.singh.ext%40siemens.com%7C69f7415c2bc3402b8cde08de2b77b21d%7C38ae3b
>> cd95794fd4addab42e1495d55a%7C1%7C0%7C638995990271126607%7CUnknown%7CTW
>> FpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIs
>> IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D5ry3XapBLPScmMpiz5
>> bdwF%2F9MVx0%2FG6reUH%2Ba5pYxXA%3D&reserved=3D0
>>
>
> This all makes sense so far, and if no one complains, I will merge it soo=
n.
>
> I furthermore assume that our IEC testsuite will "just work" (again) with=
 this applied, right? Switch-day for the CI to trixiw is now Wednesday, or =
more likely Thursday.
>
> Jan
>
>> Thanks,
>> Gourav
>>
>> -----Original Message-----
>> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
>> Sent: 24 November 2025 12:21
>> To: Singh, Gourav (ext) (FT FDS CES LX PBU 2)
>> <gourav.singh.ext@siemens.com>; cip-dev@lists.cip-project.org
>> Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>;
>> dinesh.kumar@toshiba-tsip.com; Kazuhiro Hayashi
>> <kazuhiro.hayashi.f74@mail.toshiba>
>> Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd
>> in Debian trixie
>>
>> On 24.11.25 06:06, Gourav Singh wrote:
>>> In Debian Trixie, /run/utmp has been removed, so traditional
>>> session-tracking mechanisms (used by w/who) no longer work.
>>> To restore secure and correct session accounting (needed for
>>> enforcing limits like maxlogins to comply with IEC 62443 CR2.7_1), we
>>> can add libpam-systemd.
>>>
>>> This ensures that PAM can register user sessions with systemd-logind,
>>> aligning with Debian's design for Trixie.
>>> See Debian-devel discussion: "/run/utmp is no longer provided in
>>> trixie ... replacement mechanism provided by systemd."
>>>
>>> Ref:
>>> https://list
>>> s.debian.org%2Fdebian-devel%2F2025%2F04%2Fmsg00011.html&data=3D05%7C02%
>>> 7
>>> Cgourav.singh.ext%40siemens.com%7C13545a99022f43a55dce08de2b25d0fb%7C
>>> 3
>>> 8ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638995638612273708%7CUnknow
>>> n
>>> %7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW
>>> 4
>>> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DtNzGl6b239zR
>>> 7
>>> GFA5WPQwQwSi0fRIhXp5hQchE7pxKw%3D&reserved=3D0
>>>
>>> Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
>>> ---
>>>  .../security-customizations/security-customizations.bb         | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git
>>> a/recipes-core/security-customizations/security-customizations.bb
>>> b/recipes-core/security-customizations/security-customizations.bb
>>> index 717e2d3..d8fa22b 100644
>>> --- a/recipes-core/security-customizations/security-customizations.bb
>>> +++ b/recipes-core/security-customizations/security-customizations.bb
>>> @@ -25,6 +25,9 @@ DEBIAN_DEPENDS =3D "customizations, sshd-regen-keys,
>>> libpam-google-authenticator,  # - libpam-passwdqc: Preferred for newer =
Debian releases (post-Bullseye).
>>>  DEBIAN_DEPENDS:append =3D ", libpam-passwdqc | libpam-cracklib"
>>>
>>> +# Append systemd PAM package to limit concurrent sessions in Debian
>>> +trixie DEBIAN_DEPENDS:append:trixie =3D ", libpam-systemd"
>>> +
>>
>> So, no configuration needed? And does this obsolete any other dependency=
 in trixie?
>>
>>>  do_install[cleandirs] +=3D "${D}/etc/ssh/sshd_config.d/"
>>>  do_install () {
>>>      install -m 600 ${WORKDIR}/ssh-remote-session-term.conf
>>> ${D}/etc/ssh/sshd_config.d/
>>
>> Thanks for tracking this down. I suspect that our certification efforts =
are still focused on bookworm as baseline, but this is an important step ah=
ead already. I also hope we can soon switch CI to trixie, currently waiting=
 on lava-docker updates on the workers.
>>
>> Jan
>>
>> --
>> Siemens AG, Foundational Technologies
>> Linux Expert Center
>
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center


--
Siemens AG, Foundational Technologies
Linux Expert Center

--_000_TYCPR01MB9669E7DC641E610491AC078CC4D1ATYCPR01MB9669jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Jan,<br>
<br>
Sorry to jump in<br>
<br>
&gt;but we still have a red pipeline for bookworm right now:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&gt;<a data-auth=3D"NotApplicable" class=3D"OWAAutoLink" id=3D"OWAf16a0ddc-=
6f65-f7d9-c598-dcdefd9a1b26" href=3D"https://gitlab.com/cip-project/cip-cor=
e/isar-cip-core/-/jobs/12206266133">https://gitlab.com/cip-project/cip-core=
/isar-cip-core/-/jobs/12206266133</a>.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&gt;I hope it is not regressions.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
The above failure is due to [1]. We're waiting on the updated merged config=
s for arm.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
[1] <a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issu=
es/140">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/140</a></div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Adithya Balakumar</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-proje=
ct.org&gt; on behalf of Jan Kiszka via lists.cip-project.org &lt;jan.kiszka=
=3Dsiemens.com@lists.cip-project.org&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, November 25, 2025 5:59 PM<br>
<b>To:</b>&nbsp;Singh, Gourav (ext) (FT FDS CES LX PBU 2) &lt;gourav.singh.=
ext@siemens.com&gt;; cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-pr=
oject.org&gt;<br>
<b>Cc:</b>&nbsp;kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;Sh=
ivanand.Kunijadar@toshiba-tsip.com&gt;; dinesh kumar(=1B$B#T#S#I#P=1B(B DIT=
C_DIT-OST) &lt;dinesh.kumar@toshiba-tsip.com&gt;; hayashi kazuhiro(=1B$BNS=
=1B(B =1B$BOB9(=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) &lt;kazuhiro.hayashi.f74=
@mail.toshiba&gt;<br>
<b>Subject:</b>&nbsp;Re: [cip-dev] [isar-cip-core][PATCH] fix(security): ad=
d libpam-systemd in Debian trixie
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">On 25.11.25 12:08, Singh, Gourav (ext) (FT =
FDS CES LX PBU 2) wrote:<br>
&gt; Hi Jan,<br>
&gt;<br>
&gt; After applying these changes, the IEC test suite now passes all test c=
ases on the Trixie image. I've verified this on my end, and I'm attaching t=
he results log file for the test suite run on<br>
&gt; the cip-core-image-security Trixie image.<br>
<br>
The patch is now also in next. I lost a bit track when what started to<br>
fail, but we still have a red pipeline for bookworm right now:<br>
<a data-auth=3D"NotApplicable" class=3D"OWAAutoLink" id=3D"OWA9d191cb6-9120=
-4656-ed54-e630fb7b3cff" href=3D"https://gitlab.com/cip-project/cip-core/is=
ar-cip-core/-/jobs/12206266133">https://gitlab.com/cip-project/cip-core/isa=
r-cip-core/-/jobs/12206266133</a>.<br>
I hope it is not regressions.<br>
<br>
In any case, I would appreciate if people familiar with the test suites<br>
could sort out what the pending issues are. The bookworm-based pipeline<br>
for qemu will stay BTW even when we moved with the defaults to trixie<br>
because it remains relevant for the security WG.<br>
<br>
Thanks,<br>
Jan<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Gourav<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: Kiszka, Jan (FT RPD CED) &lt;jan.kiszka@siemens.com&gt;<br>
&gt; Sent: 24 November 2025 22:07<br>
&gt; To: Singh, Gourav (ext) (FT FDS CES LX PBU 2) &lt;gourav.singh.ext@sie=
mens.com&gt;; cip-dev@lists.cip-project.org<br>
&gt; Cc: Shivanand Kunijadar &lt;Shivanand.Kunijadar@toshiba-tsip.com&gt;; =
dinesh.kumar@toshiba-tsip.com; Kazuhiro Hayashi &lt;kazuhiro.hayashi.f74@ma=
il.toshiba&gt;<br>
&gt; Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd =
in Debian trixie<br>
&gt;<br>
&gt; On 24.11.25 17:30, Singh, Gourav (ext) (FT FDS CES LX PBU 2) wrote:<br=
>
&gt;&gt; Hi Jan,<br>
&gt;&gt;<br>
&gt;&gt; Regarding customizations or configurations for the `libpam-systemd=
` package, which provides `pam_systemd.so` - a new systemd mechanism that r=
eplaces the traditional `/run/utmp` for tracking active user sessions in De=
bian Trixie - it is necessary to ensure
 that `pam_systemd.so` is included in `/etc/pam.d/common-session`. This rep=
laces the traditional role of `/run/utmp` in session management.<br>
&gt;&gt; Ref:<br>
&gt;&gt; <a data-auth=3D"NotApplicable" class=3D"OWAAutoLink" id=3D"OWA8598=
6530-d0e5-f5fa-ed3f-f034d86a4070" href=3D"https://list">
https://list</a><br>
&gt;&gt; s.debian.org%2Fdebian-release%2F2024%2F05%2Fmsg00150.html&amp;data=
=3D05%7C02<br>
&gt;&gt; %7Cgourav.singh.ext%40siemens.com%7C69f7415c2bc3402b8cde08de2b77b2=
1d%7<br>
&gt;&gt; C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638995990271096290%7CU=
nkno<br>
&gt;&gt; wn%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiO=
iJXa<br>
&gt;&gt; W4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&amp;sdata=3Dz=
bwdGBW1zzz<br>
&gt;&gt; p3xN5q0UW3qN5o1MXmzbBmJv3uQdILhY%3D&amp;reserved=3D0,<br>
&gt;&gt; <a data-auth=3D"NotApplicable" class=3D"OWAAutoLink" id=3D"OWAd818=
b6a0-5ace-de44-626b-80794b819c30" href=3D"https://ddp-">
https://ddp-</a><br>
&gt;&gt; team.pages.debian.net%2Frelease-notes%2Fen%2Fhtml%2Fissues.html%23=
the-<br>
&gt;&gt; last-lastb-and-lastlog-commands-have-been-replaced&amp;data=3D05%7=
C02%7Cgour<br>
&gt;&gt; av.singh.ext%40siemens.com%7C69f7415c2bc3402b8cde08de2b77b21d%7C38=
ae3b<br>
&gt;&gt; cd95794fd4addab42e1495d55a%7C1%7C0%7C638995990271126607%7CUnknown%=
7CTW<br>
&gt;&gt; FpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4z=
MiIs<br>
&gt;&gt; IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&amp;sdata=3D5ry3XapB=
LPScmMpiz5<br>
&gt;&gt; bdwF%2F9MVx0%2FG6reUH%2Ba5pYxXA%3D&amp;reserved=3D0<br>
&gt;&gt;<br>
&gt;<br>
&gt; This all makes sense so far, and if no one complains, I will merge it =
soon.<br>
&gt;<br>
&gt; I furthermore assume that our IEC testsuite will &quot;just work&quot;=
 (again) with this applied, right? Switch-day for the CI to trixiw is now W=
ednesday, or more likely Thursday.<br>
&gt;<br>
&gt; Jan<br>
&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt; Gourav<br>
&gt;&gt;<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: Kiszka, Jan (FT RPD CED) &lt;jan.kiszka@siemens.com&gt;<br>
&gt;&gt; Sent: 24 November 2025 12:21<br>
&gt;&gt; To: Singh, Gourav (ext) (FT FDS CES LX PBU 2)<br>
&gt;&gt; &lt;gourav.singh.ext@siemens.com&gt;; cip-dev@lists.cip-project.or=
g<br>
&gt;&gt; Cc: Shivanand Kunijadar &lt;Shivanand.Kunijadar@toshiba-tsip.com&g=
t;;<br>
&gt;&gt; dinesh.kumar@toshiba-tsip.com; Kazuhiro Hayashi<br>
&gt;&gt; &lt;kazuhiro.hayashi.f74@mail.toshiba&gt;<br>
&gt;&gt; Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-syst=
emd<br>
&gt;&gt; in Debian trixie<br>
&gt;&gt;<br>
&gt;&gt; On 24.11.25 06:06, Gourav Singh wrote:<br>
&gt;&gt;&gt; In Debian Trixie, /run/utmp has been removed, so traditional<b=
r>
&gt;&gt;&gt; session-tracking mechanisms (used by w/who) no longer work.<br=
>
&gt;&gt;&gt; To restore secure and correct session accounting (needed for<b=
r>
&gt;&gt;&gt; enforcing limits like maxlogins to comply with IEC 62443 CR2.7=
_1), we<br>
&gt;&gt;&gt; can add libpam-systemd.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This ensures that PAM can register user sessions with systemd-=
logind,<br>
&gt;&gt;&gt; aligning with Debian's design for Trixie.<br>
&gt;&gt;&gt; See Debian-devel discussion: &quot;/run/utmp is no longer prov=
ided in<br>
&gt;&gt;&gt; trixie ... replacement mechanism provided by systemd.&quot;<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Ref:<br>
&gt;&gt;&gt; <a data-auth=3D"NotApplicable" class=3D"OWAAutoLink" id=3D"OWA=
21378cee-1aff-3f73-d4df-9c90d5a233c6" href=3D"https://list">
https://list</a><br>
&gt;&gt;&gt; s.debian.org%2Fdebian-devel%2F2025%2F04%2Fmsg00011.html&amp;da=
ta=3D05%7C02%<br>
&gt;&gt;&gt; 7<br>
&gt;&gt;&gt; Cgourav.singh.ext%40siemens.com%7C13545a99022f43a55dce08de2b25=
d0fb%7C<br>
&gt;&gt;&gt; 3<br>
&gt;&gt;&gt; 8ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638995638612273708%7=
CUnknow<br>
&gt;&gt;&gt; n<br>
&gt;&gt;&gt; %7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlA=
iOiJXaW<br>
&gt;&gt;&gt; 4<br>
&gt;&gt;&gt; zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&amp;sdata=
=3DtNzGl6b239zR<br>
&gt;&gt;&gt; 7<br>
&gt;&gt;&gt; GFA5WPQwQwSi0fRIhXp5hQchE7pxKw%3D&amp;reserved=3D0<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Gourav Singh &lt;gourav.singh.ext@siemens.com&g=
t;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&nbsp; .../security-customizations/security-customizations.bb&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 3 +++<br>
&gt;&gt;&gt;&nbsp; 1 file changed, 3 insertions(+)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git<br>
&gt;&gt;&gt; a/recipes-core/security-customizations/security-customizations=
.bb<br>
&gt;&gt;&gt; b/recipes-core/security-customizations/security-customizations=
.bb<br>
&gt;&gt;&gt; index 717e2d3..d8fa22b 100644<br>
&gt;&gt;&gt; --- a/recipes-core/security-customizations/security-customizat=
ions.bb<br>
&gt;&gt;&gt; +++ b/recipes-core/security-customizations/security-customizat=
ions.bb<br>
&gt;&gt;&gt; @@ -25,6 +25,9 @@ DEBIAN_DEPENDS =3D &quot;customizations, ssh=
d-regen-keys,<br>
&gt;&gt;&gt; libpam-google-authenticator,&nbsp; # - libpam-passwdqc: Prefer=
red for newer Debian releases (post-Bullseye).<br>
&gt;&gt;&gt;&nbsp; DEBIAN_DEPENDS:append =3D &quot;, libpam-passwdqc | libp=
am-cracklib&quot;<br>
&gt;&gt;&gt;&nbsp;<br>
&gt;&gt;&gt; +# Append systemd PAM package to limit concurrent sessions in =
Debian<br>
&gt;&gt;&gt; +trixie DEBIAN_DEPENDS:append:trixie =3D &quot;, libpam-system=
d&quot;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;<br>
&gt;&gt; So, no configuration needed? And does this obsolete any other depe=
ndency in trixie?<br>
&gt;&gt;<br>
&gt;&gt;&gt;&nbsp; do_install[cleandirs] +=3D &quot;${D}/etc/ssh/sshd_confi=
g.d/&quot;<br>
&gt;&gt;&gt;&nbsp; do_install () {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; install -m 600 ${WORKDIR}/ssh-re=
mote-session-term.conf<br>
&gt;&gt;&gt; ${D}/etc/ssh/sshd_config.d/<br>
&gt;&gt;<br>
&gt;&gt; Thanks for tracking this down. I suspect that our certification ef=
forts are still focused on bookworm as baseline, but this is an important s=
tep ahead already. I also hope we can soon switch CI to trixie, currently w=
aiting on lava-docker updates on the workers.<br>
&gt;&gt;<br>
&gt;&gt; Jan<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Siemens AG, Foundational Technologies<br>
&gt;&gt; Linux Expert Center<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Siemens AG, Foundational Technologies<br>
&gt; Linux Expert Center<br>
<br>
<br>
--<br>
Siemens AG, Foundational Technologies<br>
Linux Expert Center<br>
</div>
</body>
</html>

--_000_TYCPR01MB9669E7DC641E610491AC078CC4D1ATYCPR01MB9669jpnp_--


