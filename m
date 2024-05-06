Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B58C10F16
	for <webhook@archiver.kernel.org>; Mon,  6 May 2024 08:47:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.16125.1714985232681642318
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 May 2024 01:47:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4468l9wj3883083; Mon, 6 May 2024 17:47:10 +0900
X-Iguazu-Qid: 2rWhGbqYiMogLaEWif
X-Iguazu-QSIG: v=2; s=0; t=1714985229; q=2rWhGbqYiMogLaEWif; m=STBGoTgScvtdGVZNMoghzz0b6GauEy+2q095EoFxoDk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 4468l748535246
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 17:47:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feHjaXaiXpO0spHdbw3rXDOWItaZHttCTiSW+hbudA5116/kCLrFVRNvVCoslIlVY9hMkcOvYMoztxOFIcaKgqKnX+tT5/vRMmmz9Gi/k4Vkjm9VsVYtXnlW3VjWXppkLOM8htexaIbC+lh+fAzv6kl/C1km0N8b+RjNRjw9Cc0jzLsptGomPybz1Dkpeut3wwUYTLIh+j6a3x9mhk8cn4ZP3NifeJUjJN6/c+2yVUly02UmPp8Zz74qseCrOw4gWgZrtpTMD7fK8g15QoGa0TNMomfctIBJP/QCPc8RFeqh6/lrNMVoeRwZPNhGwixefZDHw6nc2LQ1cPHPuak+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQ4kjUZWPYULBkCu29tF03MbxGaManzVPeYugRfvIbs=;
 b=CPzvxL3VoDxU/w0zYhvrvzAh06kxXXwVFqaqfe2YQJE5ESzZiczRlCsQVDnHodbTBEH7+BdA60uMcQJpcFuZa58x5muAVGlOH5/MpL/M3JGO9BnBTRY4cnP91ovT82zQgiigF22lP1cB1uZgtGMUm+3dE38V27rs0ZVSBb5kFIWS3qS6IAshUpZvKeaKDmd9os4BY73zYn8P9GQzYaSIDDl4sRs6p1B89AgGEiduAUAYuHUHMAzoSVUOqc+dxHYLZWADcw5aKRSnFH1q8dIf32LfRuDOsDjTgHzEH/wdaNzMG5fw+9OGpkwoPFI7Vl5Ze5x9O4JxnxDwkDsa223+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>,
        <quirin.gylstorff@siemens.com>
CC: <felix.moessbauer@siemens.com>, <Shivanand.Kunijadar@toshiba-tsip.com>,
        <Sai.Sathujoda@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core][PATCH v4 0/3] Integrate Delta Update
 with rdiff_image and delta handler
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v4 0/3] Integrate Delta Update
 with rdiff_image and delta handler
Thread-Index: AQHan47+4oYt0jWSzUq5q283gzidibGJ5IzQ
Date: Mon, 6 May 2024 08:47:05 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669132581B052EDE6105F7DC41C2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20240425094444.404036-1-Adithya.Balakumar@toshiba-tsip.com>
 <e197cfad-fad4-4309-9132-f443ff0c0987@siemens.com>
In-Reply-To: <e197cfad-fad4-4309-9132-f443ff0c0987@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TYCPR01MB10730:EE_
x-ms-office365-filtering-correlation-id: 2cf021ea-6d81-418a-66d4-08dc6da91b76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VFVjdEcwV0NCZXRrYXMzNmwrOWo5MDBFTTVYU25IejY4MXg2SWxjM3lCd05O?=
 =?utf-8?B?S0t0NDkwVElIeC9RbXNhbWladWZ2MUNRS1pYN2RFcU9ncDdteHRQckZPOHRs?=
 =?utf-8?B?aTVYYnFlTXJ2QWdiaGVid3RUQWd1NTJLNzA5SWcxWWJYZUprcG1SQVV6QklG?=
 =?utf-8?B?RWQySW85V3JUVERmRk9qaWFDN0ZTU25BclQ3OXVtSER0cGswQ1ExSG5HRTlO?=
 =?utf-8?B?ak9sc2VuSjVPd0Z2QWtLZFg3V0dSMXE1cmNTVXd2cmRlT21wbHhPNEZ1akxy?=
 =?utf-8?B?b3dmR2lnZVUzRVpKanhkcW1Ddk5pWXBmZE1oNWxFM3BKbWlFeTlUekZmdVRM?=
 =?utf-8?B?NWE5K3F5MHlyRmpsMDlkWEZxT3hYQWlWaFR4ZkdJMHpYUGp3V0hLRU0vWlhY?=
 =?utf-8?B?d0NlMWlqVGU2bWhqcE5Ba1dncW5neHFsYjJKaGl6YlQvSFcvTVpCeHpYbWJr?=
 =?utf-8?B?YTFsdmt6TnMyTEhxR1l4Yy82STE2cEU3Q3IraWJrMWlkaG5qTXlqMEhqV3cw?=
 =?utf-8?B?S3RIekJIbVNVMU5BQ2psdnFaa2s2cjVSZG5neDU4akxNaFZOZTdQK1hQaC84?=
 =?utf-8?B?eVBMSkJJSG00c3owelJSMWtROE5aWkEzWjJST1BRS2NNc0V4eEdCbjc1NFEr?=
 =?utf-8?B?MnNJMFZBQStIc3UxTndwM3BaY2p2WTZwTGpIT210Q0FDb3ZLU0lERG1GUjd0?=
 =?utf-8?B?K3VpUm0zVmxlTWhkOE81NG1TNnp4aDNWRW1SenkvZUdnR3dOL1o4NEI0d1c0?=
 =?utf-8?B?ZUFpYjlMbHA0N3VMeFdHZXJ6a1hOd0p3MkhJcXpDUnBlSjlyN2JrRnpWMXFN?=
 =?utf-8?B?VGFMRnhvR2EySHdmNGk3QkZvSmp0ZFRJNXpXY3pmQ3lZRVRkdzZyTXd2Yk9h?=
 =?utf-8?B?MVU4VVE3N04xWVd1bDlWWGFraURVN1YxZGFJTk1yS2VhaEhFWXBraFNJd3hh?=
 =?utf-8?B?bTJRWkg1MmV0SjlSemM4UW9uYSthUEFaZDdiWTlOcjJleWlYb1BmUTNsbnZr?=
 =?utf-8?B?OElwb3piY0dBbVRFejVBRDloWmZEcXdVTGNoM2xvVGNGcW4rMGIvOXNlbXVO?=
 =?utf-8?B?Um5jUUZGRkRrbzVlQjl2Z2VTT0EzK3JqaDZrRWg1TkdwKzNZd0hka3pWcktR?=
 =?utf-8?B?L0MxYVpwTFoxWU9WcDVIM0NMODFtU1FTRzhwQWNDNkdsVklYOS9EbGtyMDRn?=
 =?utf-8?B?eUdSWlMyNjdTaXIxTjJZMmdxL3I0Nm5CZ0VKTklXU1hHSXlnZ3RvOExyWGFm?=
 =?utf-8?B?bGtLS3BZUWlJYkhhTlNUemM1SXNqcmpJYVNxUEQxMldTclV4ZDJROW4yV3o1?=
 =?utf-8?B?VVgydUFnQmdld0ZJWmZQVy9BWllJUllqVmdyMTUyeDRHVE5Rd2ZMYVhZRTB2?=
 =?utf-8?B?Snp1N2lGN21hSXQ4UVAvVm1sYlpCSWY1bkYzY0dYeEV3ZTFUQTJxcGlOK21U?=
 =?utf-8?B?MVRoNXgwd01OeWtrS0Q0MjhWckIyaEJ4TUl3QnkvdFpmUXMxVHZwaXVkTUIv?=
 =?utf-8?B?Yndhb3pkakFMTVZmaVg2bWFJc0MxMFpaMXVMcDdZS3pMdEtmSnQrSXBIOXhH?=
 =?utf-8?B?UjVJQlF2bFdsZlhSL2Y4S1I3R0NDVDlCL3FRbUFYeTBoQmdKcXN2VVRpOUhu?=
 =?utf-8?B?ekdSb01jQ3BBT1lXQ3EvZm52ei80SHlsU0ZnSXh5Q2Z3RUVMSEZKNmxCQ1h5?=
 =?utf-8?B?OVordSs0SmgxVlY3VnBVbFovUFVZbG8raDkrWnNVdHlucU43OHhLSzZiZlJT?=
 =?utf-8?B?STFTVnp4dkZmeUZhaUF3bGI5bWVWeDdkVkFBUDNsM1h6YTRUcTNIQ3NxZkRl?=
 =?utf-8?B?Z3JJUTlyVWFpbzNjdUNIUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U3BrOHVQTnprS2Z4N0xFOWtkaDJRZDllSjNSTHk1Q1VRTXNVWGpaMjlaTlV3?=
 =?utf-8?B?b1BwZVgrcjZLc2dSYTJtRUtHTWFEVFZsWW5oZVlsYVNYNTYvc0NXbzUxSk9r?=
 =?utf-8?B?MjhVa0ZrRUZnMlpLd0IrbUxsUGRrS2VTdkJkL2l2cEZHSkM0T2VRRm9weW9G?=
 =?utf-8?B?aXpjazZydU1kTkVKRzJSOXUvM045LzNJS3JSVStVNzlxMlZtV3hGdVpISTJB?=
 =?utf-8?B?Q0o1Qm9WOXpVYncrSlEwcW5aSmQ1YXUzVERrZFFFOVYwQjRlUWJEaFdQb3R2?=
 =?utf-8?B?TVRSVkhmdm9IWjRzNWlSRmFubndZY1NQOWZZOG5JVlQ4ZktVK0FmcUZFK3Fq?=
 =?utf-8?B?ZmoyVDhVdWN2d1hqdmswSm5UVlNoenF1RDFBMmF1UmNjQlRubFFrUUNSTEZ6?=
 =?utf-8?B?Yk53bkl2YTlsQmdhYXhuU2E5T2lsTVFhYW9nY05DS2hKcVZ1VEtXZkdyYnZY?=
 =?utf-8?B?cVlCcGxBM3dGckx5cW5QSGRFTE5VVHNVa3NLRWRZNWJXOEF5YnpYQURzWGYy?=
 =?utf-8?B?LzdqdFFMcjJuK2YvSzRMV0FlTTZRRDVqVnJWVkIxa1Jsb0phM200cDhzeDUr?=
 =?utf-8?B?SkNjMVlTWWhSRExyVDd6UXp3ZmtDdXY4QXdQWmxTSVpBdmRaL0FFdDRsV0lJ?=
 =?utf-8?B?Z290UDJScEZQSm1pNU1ablhWdVZTazBFb0VoN05OaFRObmNwMlJYc3oyT2ZP?=
 =?utf-8?B?MThFZkxVZUpBMDArUmhIWUE4TGRMenRXWDhNeTR1MFl3bDdGRmFkMlhNaGp5?=
 =?utf-8?B?VHUwUVZrYUptUXd0eHhUN1l3ZjlSOWo5QTZPUWg2K0ZmVi9PMXgyLy9yQW1Q?=
 =?utf-8?B?cHNWUUdhbnJBSFNJUkVJMDJRTlFnZURJUnJjUzFTOUhaMTBvSU9BUmk2QVgw?=
 =?utf-8?B?Kzc2bHA0Wnl4dlVnUWlmYUZId1RvM3RiT3NOZHRUbUtxcnJXSGQwbGk5SUhZ?=
 =?utf-8?B?MjdQa1ZMaERybUNJTFVWS0h1MWpvYTBmRXkrSjVDKzdadVBzeVhaN00rN3lq?=
 =?utf-8?B?SDRrUXJzNEtHSU16UEFybElUL3dSTFpxaGRGeEdhb1JQeGlNYUswUUNCOHZt?=
 =?utf-8?B?SytJYWVsTlN2VmpOQ3B1bEE1V0UrSXVHSnhscjhIc3kyRStDcVAzVkJxZFQy?=
 =?utf-8?B?V2xZV2FBMkk4NmNPNkpTbW9BRW5NdGs0YjdROUpLNFM2WEdFcjlMaGVuQ1FW?=
 =?utf-8?B?ZVg1QzhjcGhiUW1jM0VTNkdEN3J5STJmaG1LZ1JacEJNdjlhM0hDS0dJSE9V?=
 =?utf-8?B?SHp3RWhud2F4WXZTcTM0Wm9tTW1BNzl1WGFmOVpTZzZmeW82Uk1lbVBDZTFI?=
 =?utf-8?B?TzcyeXJVYkpSZjJHZGo4dlprUXIvZ1dmNUs4T205Y3RvczNxcmlWa0dDZkhr?=
 =?utf-8?B?RXB1V1E0aVQ4aUpzMmhmby9GVmlvam9VSzRnYXBUcm1PenoyUGpaYWZPNzJs?=
 =?utf-8?B?UlFjRUR1WENGdFk1cVRmSlNKT0ZoWmhweWxuRCtmVTVUakthYUVLTklRR1la?=
 =?utf-8?B?Uk9UZHRHaUk2WGl6QWZOdFY3YlU2SHUrTGZuckVjc1Iza3kvVTNkSm1zS2lL?=
 =?utf-8?B?TlZoeHVHbU1OY1JqcU9URUJvM3RFcWZvVWEvYzdOR3Q5VjBoaGJUMlprM3JX?=
 =?utf-8?B?Yk85bzdnd0pNckJXb2lON3ZhYmR5aU53dllEdWZKdjNhNDdXejN0dzVzbkZ6?=
 =?utf-8?B?eFVkMm9md014a0hNdSsxZG9zMXFJNi9odVVOVmRUV3Y0dHBpcGtmTUNnODNm?=
 =?utf-8?B?NW8xam1ISktyazFLRDd6NDBaUHAxMkdwbnppMmI2OTc1QTEzOFBKaEhiV3VI?=
 =?utf-8?B?ZjJRajY3NFpCYVN4aXB5NXJ2WFRWUU9jWVdGSjVCaTBiSGVzVjJTRk9vdmkx?=
 =?utf-8?B?emhFRVNpVys1cWMxSXlWU3RWNWVTODFpVTRwbkpHTE0za1BPeWp4anUrSnFE?=
 =?utf-8?B?OHU2NzZCRW5UN3p2VkdWdlFJOGJaSjZFemtxMXE1d001RFhOVURvRG1uTFMx?=
 =?utf-8?B?MlJwLzdDMkgzeWJaZFJYcFFXOWxNMHRQdVdxQzRDQUNLOXc0T0FYQ3hia01S?=
 =?utf-8?B?aW5kVERLN3ZienliRmVBVGhlZHdQakg0aGhwYWtYZW4vcXRQYnBGenFyaUFI?=
 =?utf-8?B?Rmw4RFBjNFB2Zi9MTlg0TWo0MjZab2RNV0xMR21zRFZsT3UxK1FSQnQ3QXNS?=
 =?utf-8?Q?g3SmuozfO8QbWHkKptRI/bY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf021ea-6d81-418a-66d4-08dc6da91b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 08:47:05.7318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/PDyC2CAvrGn5cpsaEAum4+tlFoDPw8BcZZqcdreiaUJiZU/RMup2T6YfxRJ4hTdy7Lgp9Bs1zzQiKcg5sLrxvduFggDJXshK8Pai7H7nWBXp4wlsYvv6HWkH9g3GOG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10730
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 May 2024 08:47:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15827

SGkgUXVpcmluLA0KDQpZZXMsIHdpbGwgc2VuZCBvdXQgdjUgdG9kYXkuIEFwb2xvZ2llcyBmb3Ig
dGhlIGRlbGF5Lg0KDQpSZWdhcmRzLA0KQWRpdGh5YSBCYWxha3VtYXINCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAt
ZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mIFF1aXJpbiBHeWxzdG9yZmYg
dmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KU2VudDogTW9uZGF5LCBNYXkgNiwgMjAyNCAxOjU1
IFBNDQpUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGphbi5raXN6a2FAc2llbWVu
cy5jb20NCkNjOiBmZWxpeC5tb2Vzc2JhdWVyQHNpZW1lbnMuY29tOyBrdW5pamFkYXIgc2hpdmFu
YW5kKO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGluZykgPFNoaXZhbmFuZC5LdW5pamFkYXJA
dG9zaGliYS10c2lwLmNvbT47IGFzaHJpdGggc2FpKO+8tO+8s++8qe+8sCkgPFNhaS5TYXRodWpv
ZGFAdG9zaGliYS10c2lwLmNvbT47IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgVE1JRUMgT0RH
IFBvcnRpbmcpIDxkaW5lc2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT47IGhheWFzaGkga2F6dWhp
cm8o5p6XIOWSjOWujyDvvKTvvK3vvKUg4peL77yk77yp77yn4pah77yt77yw77yz4peL77yt77yw
77yUKSA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4NClN1YmplY3Q6IFJlOiBbY2lw
LWRldl0gW2lzYXItY2lwLWNvcmVdW1BBVENIIHY0IDAvM10gSW50ZWdyYXRlIERlbHRhIFVwZGF0
ZSB3aXRoIHJkaWZmX2ltYWdlIGFuZCBkZWx0YSBoYW5kbGVyDQoNCkhpLA0KaXMgdGhlIHBhdGNo
IHY1IGluIHdvcms/DQoNClF1aXJpbg0KDQpPbiA0LzI1LzI0IDExOjQ0IEFNLCBBZGl0aHlhIEJh
bGFrdW1hciB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnIHdyb3RlOg0KPiBUaGVzZSBzZXJpZXMg
b2YgcGF0Y2hlcyBlbmFibGUgdGhlIHN1cHBvcnQgZm9yIGRlbHRhIHVwZGF0ZSBmb3IgdGhlIA0K
PiByb290IGZpbGUgc3lzdGVtIHdpdGggc3d1cGRhdGUncyByZGlmZl9pbWFnZSBhbmQgZGVsdGEg
aGFuZGxlcih6Y2h1bmspLg0KPiANCj4gQSBjb3VwbGUgbm90ZXMgYWJvdXQgdGhlIGltcGxlbWVu
dGF0aW9uOg0KPiAtIEluIHRoaXMgcGF0Y2hzZXQsIERlbHRhIHVwZGF0ZSBpcyBvbmx5IHN1cHBv
cnRlZCBmb3IgdGhlIHJvb3QgZmlsZSBzeXN0ZW0uDQo+IC0gVGhlIG5ld2x5IGFkZGVkIGRlbHRh
LXVwZGF0ZS5iYmNsYXNzIGhhbmRsZXMgdGhlIGNyZWF0aW9uIG9mIHRoZSBkZWx0YSB1cGRhdGUg
YXJ0aWZhY3RzLg0KPiAtIFRoZSB1cGRhdGUgaGFuZGxlciB0eXBlIGkuZSByZGlmZl9pbWFnZSBv
ciBkZWx0YSBoYW5kbGVyIGlzIHNldCBpbiB0aGUgdmFyaWFibGUgIkRFTFRBX1VQREFURV9UWVBF
Ig0KPiBpbiB0aGUgc3d1cGRhdGUueW1sIGZpbGUgYWxvbmcgd2l0aCBzb21lIHZhcmlhYmxlcyBy
ZXF1aXJlZCBmb3IgZWFjaCBoYW5kbGVyLg0KPiAtIFRoZSBjcmVhdGlvbiBvZiBkZWx0YSBhcnRp
ZmFjdCBmb3IgdGhlIHJkaWZmX2ltYWdlIGhhbmRsZXIgcmVxdWlyZXMgDQo+IGEgcmVmZXJlbmNl
IGltYWdlIChhZ2FpbnN0IHdoaWNoIHRoZSBkZWx0YSBpcyBjb21wdXRlZCkuIEN1cnJlbnRseSB0
aGUgDQo+IHJlZmVyZW5jZSBhcnRpZmFjdCBmaWxlICguc3F1YXNoZnMvLnZlcml0eSkgaXMgcGFz
c2VkIHRvIHRoZSBidWlsZCANCj4gc3lzdGVtIGJ5IHBsYWNpbmcgdGhlIGFydGlmYWN0IGluIHRo
ZSBwYXRoICIke1RPUERJUn0vcHJldmlvdXMtaW1hZ2UiIGFuZCBzZXR0aW5nIHRoZSBuYW1lIG9m
IHRoZSBhcnRpZmFjdCBpbiB0aGUgdmFyaWFibGUgREVMVEFfUkRJRkZfUkVGX0lNQUdFIGluIHRo
ZSBzd3VwZGF0ZS55bWwgZmlsZS4NCj4gLSB6Y2h1bmsgYmFzZWQgZGVsdGEgdXBkYXRlIGlzIG9u
bHkgc3VwcG9ydGVkIGZvciBzaWQgb253YXJkcy4NCj4gDQo+IENoYW5nZXMgaW4gdjQ6DQo+IC0g
Q3JlYXRlIG9ubHkgMSAuc3d1IGZpbGUsIGVpdGhlciBkZWx0YSBvciBjb21wbGV0ZSBzd3UuDQo+
IC0gQnkgZGVmYXVsdCBjb21wbGV0ZSB1cGRhdGUgc3d1IGlzIGNyZWF0ZWQuDQo+IA0KPiBDaGFu
Z2VzIGluIHYzOg0KPiAtIFJlYmFzZSB0byBjdXJyZW50IG5leHQgYnJhbmNoIA0KPiAoNjFlOTk4
ZTFlMDU0MWUyNzEzYzA1ZmNiZjIxZGYzOWZiYzg4MmEwYSkNCj4gLSBTZXQgIiR7VE9QRElSfS9w
cmV2aW91cy1pbWFnZSIgYXMgdGhlIHBhdGggZm9yIHRoZSBwcmV2aW91cyBpbWFnZSBhcnRpZmFj
dCBmb3IgcmRpZmYgdXBkYXRlLg0KPiAtIFJFQURNRSB1cGRhdGVzIHRvIHZlcmlmeSBkZWx0YSB1
cGRhdGUuDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIFJlbW92ZWQgemNodW5rIHN1cHBvcnQg
Zm9yIGJvb2t3b3JtIChkdWUgdG8gdXNlIG9mIGJhY2twb3J0cykuIEN1cnJlbnRseSB6Y2h1bmsg
YmFzZWQgdXBkYXRlIG9ubHkgc3VwcG9ydGVkIGluIFNpZC4NCj4gLSBSZW1vdmVkIGRlbHRhLXVw
ZGF0ZS55bWwgZmlsZS4gUmVsYXRlZCB2YXJpYWJsZXMgaGF2ZSBkZWZhdWx0IHZhbHVlcyBhbmQg
Y2FuIGJlIHNldCBpbiBtYW51YWxseSBzd3VwZGF0ZS55bWwgZmlsZS4NCj4gLSBVc2luZyAuc3F1
YXNoZnMgZmlsZSAoLnZlcml0eSBmaWxlIGluIHRoZSBjYXNlIG9mIFNlY3VyZSBib290KSBmb3Ig
cmRpZmYgZGVsdGEgY3JlYXRpb24gaW5zdGVhZCBvZiAud2ljIGZpbGUuDQo+IC0gcmRpZmYgaXMg
c2V0IGFzIGRlZmF1bHQgZm9yIGRlbHRhIHVwZGF0ZSB0eXBlLCB0aGUgYnVpbGQgc3lzdGVtIGxv
b2tzIGZvciB0aGUgdjEgYXJ0aWZhY3QgaW4gYSBkZWZhdWx0IHBhdGggKGltYWdlLXYxLzxhcnRp
ZmFjdF9uYW1lPikuDQo+IC0gQ3JlYXRlZCBhIHNlcGFyYXRlIHRlbXBsYXRlIGZpbGUgZm9yIHN3
LWRlc2NyaXB0aW9uIG9mIGRlbHRhIHVwZGF0ZS4NCj4gLSBSZW5hbWVkIGRlbHRhX3VwZGF0ZS5i
YmNsYXNzIHRvIGRlbHRhLXVwZGF0ZS5iYmNsYXNzLg0KPiANCj4gQWRpdGh5YSBCYWxha3VtYXIg
KDMpOg0KPiAgICBBZGQgRGVsdGEgdXBkYXRlIHN1cHBvcnQgd2l0aCByZGlmZl9pbWFnZSBhbmQg
ZGVsdGEgaGFuZGxlcg0KPiAgICBzd3VwZGF0ZS5iYmNsYXNzOiBHZW5lcmF0ZSBzd3UgZm9yIGRl
bHRhIHVwZGF0ZXMNCj4gICAgZG9jL1JFQURNRS5zd3VwZGF0ZS5tZDogVXBkYXRlIHN0ZXBzIHRv
IHRlc3QgRGVsdGEgc29mdHdhcmUgVXBkYXRlDQo+IA0KPiAgIGNsYXNzZXMvZGVsdGEtdXBkYXRl
LmJiY2xhc3MgICAgICAgICAgICAgICAgfCA5NyArKysrKysrKysrKysrKysrKysrKysNCj4gICBj
bGFzc2VzL3N3dXBkYXRlLmJiY2xhc3MgICAgICAgICAgICAgICAgICAgIHwgMjcgKysrKystDQo+
ICAgY29uZi9sYXllci5jb25mICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+
ICAgZG9jL1JFQURNRS5zd3VwZGF0ZS5tZCAgICAgICAgICAgICAgICAgICAgICB8IDU5ICsrKysr
KysrKysrKysNCj4gICBrYXMvb3B0L3N3dXBkYXRlLnltbCAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDUgKysNCj4gICByZWNpcGVzLWNvcmUvaW1hZ2VzL3N3dS9zdy1kZXNjcmlwdGlvbi50bXBs
IHwgIDUgKy0NCj4gICA2IGZpbGVzIGNoYW5nZWQsIDE4OSBpbnNlcnRpb25zKCspLCA2IGRlbGV0
aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBjbGFzc2VzL2RlbHRhLXVwZGF0ZS5iYmNs
YXNzDQo+IA0KPiANCj4gDQo+IA0KPiANCg==


