Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C1EC433F5
	for <webhook@archiver.kernel.org>; Sun, 24 Oct 2021 08:59:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.16729.1635065945430591959
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 Oct 2021 01:59:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 19O8wiZ3000438;
 Sun, 24 Oct 2021 17:58:44 +0900
X-Iguazu-Qid: 34tMQoLjeBWa6VPKYC
X-Iguazu-QSIG: v=2; s=0; t=1635065923; q=34tMQoLjeBWa6VPKYC;
 m=anYuFGmwztCWzr4dm2UZDpkT58QTbQfrVECMeS5pdLY=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1512) id 19O8wfZi037469
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 24 Oct 2021 17:58:42 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id D4D061000E6;
	Sun, 24 Oct 2021 17:58:41 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 19O8wfaO008087;
	Sun, 24 Oct 2021 17:58:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9wpnBPvGL0DbEgQ74JjwgBDMmchCDxlyij1dZ5wM7QmVXxLJkoZLKyRfrM6J51ImTSKKv9zdFIyyNhzRFtV+kwdh6YoDylOELz8Qf3XWgQzo40SVgTkQ1isOQL6UMFAc/SIVUrYx78pcGTNR4qAKGzQ8kI1hC2CPMrvGHuqAZWgBQz00R410AkHabFvKV1olcfCx3sUuEA8NdamrUPyTI0OAf6MgXQv/j4LDq1joQpdyaEHWwh/xlq0pdvvnTpmKJS+l2PJ3kSJxzdjn7GqdEggDlPf7QPuitkQWr5teCM/dLGCICaC3LbIwAbudGOQlBI3LqXqLcAnH10NMlWRDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJSgdoYUr1Z66nrceWf8d/kEoTR5Vb+vsELrTIyFYV8=;
 b=M5LLiYtpyzPPQjZO3OIOyU/GAvOm18i7F9oyZ37O8EfYCLrZzuYVhwIf7byvt9DTYqHYG7Rq2u6mqsTPO52UxvsNECUxq+3/78fFGCt8ZbGTw1NaI1agFaVbkH/7GJnn0yPAqoPM4c+6seLrS0B+WNsjqVDhWt6QUsK9QRBmHbmODvhs6KXjm6ljgO2NNQBZQGMGiC7Rn0HSmj/tNMXz9YjjlqCw02+D+C5EVnfex5Mo1lgTYf4is/5BJ01fclaLUuYaSA6Q8p6booYccww5MqyI90EriGLnvKQggkqRm7nzTb4X4rONRVJeftuFtZ8IGZr1QhdTKZpSsfAcL2X+uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <masami.ichikawa@cybertrust.co.jp>,
        <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.19.213-cip60
Thread-Topic: [ANNOUNCE] Release v4.19.213-cip60
Thread-Index: AdfItLc/JJE3iJcmQDyvgT+DYZYJig==
Date: Sun, 24 Oct 2021 08:58:38 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB625225A71F7456A9D26831FE92829@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.cip-project.org; dkim=none (message not signed)
 header.d=none;lists.cip-project.org; dmarc=none action=none
 header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae034a37-1954-4e5a-c8d7-08d996cc782c
x-ms-traffictypediagnostic: TY2PR01MB3065:
x-microsoft-antispam-prvs: 
 <TY2PR01MB3065A6E03BCFE77DB54FA5E192829@TY2PR01MB3065.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DTa57sz/1wFnSAqE+ICkZwwYoal1SaZLHqqhGebfyYhij6RleQcWOlwxhwBjxuaEco4+e7bZw0gUBTlLvLrwtZMYHOUeUiRtAAOdhapjQXk0IY9xZogZX8hotzGwV+tAnd9aE0Pdz3gU6WYZ5HO0STh8IgbSJiN+C4zaTylE9crqAONjAfcOl/ZrjoPMuU1GGDaTjwC/9ssK/KCbrICjjLWRWlfshJZjzHWwmHUqF7ubCjCbh7bB992hDN57rIZgUn8zGtNbnvmLHuzgwHl34L0AI8L1LGXFBZGfAGAkuSrNyRj6VMFoG50p1IYei9cJAGrqaGD3xVdawj7ZtLE02mbe622QSYcTZZFTuaEw0YuJUWntly8pflmVn8+iGXnSLsEsTkFjCUpEyn6ZoC9vqpGwLS3sv9oNcWo8G/rwrpuAYkFdpo2bON7v8O48ttlnyN1ufWFVtbqibfPqaDHqeVSFNlF/wGIVUOOEIdrUmWWqhoFqtJr8IMIwt/JImbOmn6VwRIP3oEIYpzQhy2iQ/mX/dpU1tfod96DHm6RaxZ+GcXNvKMreJVfCE7aGKESwMm3XjdLE43ghmp+6/qJCUfgar01dqMjuemmkpnhb0LO5M/aeMthZ7z9ZaFyY98BFw5oi8rhlCrXPyVrJcEU9qm3wS4s1YQJ1v3SC2mHhRyPXRSUt7R+1nTS21SbxtwKSZvNcy106QdS9VfPtRSz1VUvHifwJwMtolPS/CNWa5O0knulSZXYpvowT9YkS0mvHOJpwJ02A11b+cx6mdaRut8eza7mRpOd3okTzMbRAnBs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(66476007)(64756008)(83380400001)(55016002)(6506007)(52536014)(71200400001)(4744005)(76116006)(38100700002)(66946007)(8676002)(66556008)(66446008)(6916009)(8936002)(9686003)(508600001)(5660300002)(26005)(38070700005)(86362001)(2906002)(33656002)(54906003)(316002)(186003)(4326008)(966005)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NmV6ZnRzV0VraDBkUExIMVZ1TFlSY2ZRbTBOYjlXd0p3d3FGQVhSYW0rRDkv?=
 =?utf-8?B?emQ2bk5FbWZMSFk5djJqQ1dKcUlqelhGbUFvaVFaR09KS1AzZGxpRVhGNTJR?=
 =?utf-8?B?RW41TCtqSmlQYmlmQ0cxc01WN2htdEN3T1VwZUR2dnpsSU14d21rdDRNaE9I?=
 =?utf-8?B?TU5GYUNZKzBPa2p1a1oxaUR1ZUd4Y3ZwSzVxeDZQWWhLWVJuekVnRmk0YXhk?=
 =?utf-8?B?NW5Idko2SFhqeDh6ZlBIa3J4YjNyNjNUckVhYTJWYkluZXY0MUprMW1VWXpa?=
 =?utf-8?B?VmpJVHlQdWlPY3RPTkE2TTFtZEg5U2QxMGw1NUtmUnd4bWtEWDBWVmk3bS82?=
 =?utf-8?B?NWhHN1k0bjhhNGQxOVRtTWxWNGF3SVdhS090L0M5akp2YnhPY0pOeVpXRHZm?=
 =?utf-8?B?V2ZwOFp6emVYWkFuVEZRdUFXVWlBaXBCdk1YQkVycHFrRlFIWnQ3Uks2MWE1?=
 =?utf-8?B?UkdSQjFxZjFLTkg1TzBvd2dMdDFtZW9FNUwzdjh5YTlYK0liOHhzS2tJa2RM?=
 =?utf-8?B?OXZWZXQ3Y1NKWEdBUy8xVFFWTTM0ZHByLzQzYTFGcS9pd3dWNzNDNHF1QlNi?=
 =?utf-8?B?NzU1bCtILzNhZWExdVBtN0ZCMkdURnhzbVN4WC9ZbDBUUE5EVDk4R3QrQ0FM?=
 =?utf-8?B?cXZXc24yN1ZKRTVmY2dCMTduakx4UE9mWFYvYTlFdjRXcUZaVTRPSEoyd0Zq?=
 =?utf-8?B?d1ExSDBQM2d0TDkyVTdOaHBsQmdQc3QyMEtNSFJoeC9pRW12eGxSWXNWaGdn?=
 =?utf-8?B?bGVLbmk4bjgzY2hYek9GaVNPMnYwZWhBaHo2NGcrNFE4QUE0ZiswazBxVnh1?=
 =?utf-8?B?NGtCZEVoZVA1SkRGek5HWW9SNWE4MXlOTHhQdEpCbVJseWJoQlFCcWg3a3Ux?=
 =?utf-8?B?SVAzKzJxbjM4SFh6amU5V1NPRldyaG1hbmtiZ3A5YWEwb0ZwYU9ocTV1amN4?=
 =?utf-8?B?amhPelZFK1lrUUtJNGltNUZPb3NpZWRZakpIMXBCQ2RCTlBWYUc1WHRIWXAr?=
 =?utf-8?B?T2tLb0VMN0NoNGNHSDNvM1ZEUEZmWWVPQnRzSnpBek5aZmxYS2VzY0NPb3JX?=
 =?utf-8?B?SXljSldTOGdNOXBvcWxlb0N6eVRqMHRTakU5WHBxUjl0a3RBRWMvMlZwYVRn?=
 =?utf-8?B?TlBsL0VNL0YxTUFHZnJZaEtNaCtiaG9EVXY5T2Fpd3g4RXRvZ3hFQUp3MUxv?=
 =?utf-8?B?WTk3S1l1Y3BSTDJHZFM0WUpIOXV4LzFUVHdOS1lOaVE2ZGN6dHRIS2xMeWRV?=
 =?utf-8?B?YkJ3TmxPa29DbkVmSHQ1cUJtUGZVamYxR2ZyTTdxSEhleHFVQzR1WjVQdlFr?=
 =?utf-8?B?cWVqS1pLcGVSN0ZUdUNMM2V0SW1aVWI2RWpJOXFYeHdOZndkOC9VaDJUZTU5?=
 =?utf-8?B?Y1VnbGxPSEJJMTBxT21sa2VVaW96K0F2V0pGYmQ0S2M3ZlJMUnhzcGxRTWYz?=
 =?utf-8?B?aVg5UzMwZDZYdmVsOGl3YjdTdzJmNk5KUXpPNmVkM0JSQ1JIVWh1TG81L2JO?=
 =?utf-8?B?N1JkMWtIcFY2c1huSEhaVVZUQ0pIVVJPdTNNRnFpVmE5bDhNV1cxT1RTNjUw?=
 =?utf-8?B?NkhzYnd5WTg2d2x2Nk1uT0dOV1F1WHlLeXJENlBab09lNW5waExFL0g4NzR4?=
 =?utf-8?B?VSsxTUNDdW5ubnFSQWd1S091aHplYitvY1gza0diZDZhS0NldlZPckFLNkZL?=
 =?utf-8?B?SGJpMGZMWkNIaGpuZFFmN0VGRGxRcThFY3h6a0tNMkJjQkRLZzYrTkYvMy9Y?=
 =?utf-8?B?SUNNelBKT3htN2xhN1BrMktwRi9NVFk4UjFGR1RmaWw5THNqYnpNS2ZiTHND?=
 =?utf-8?B?aXZlak83UjJ4aFQrSi9qTnlpNWMxcGdtbm9ZYnhkdFdaT3duVmV0MVNHZHJp?=
 =?utf-8?B?UkpHYjJSdVlsSFpXNkd2OWlyMURjSUZBUUZDb3poUXk5QlJUdFpKTzhxOFpq?=
 =?utf-8?B?STNxOWdLVHVMRUVwRGRmQkxIRXl3RHk3bXVqblc2VmFpZ0RYMVd1Y003enBS?=
 =?utf-8?B?aUpNUm5SamVOR0JvVVBJWXRabDRrdjdKd200UkVRYnF1QVU1UEk4NVZnckZK?=
 =?utf-8?B?YnFvTk1mNmZycEtwUm5raFFJUG1EWVBPY09Lc1BUYnhyb29FajhNMFIxdTlI?=
 =?utf-8?B?enRNUDdTZCtaNm5uUS9RK2lKazUxanRrMFFYaEZYVVk4YWt4M1hMQkRJZCs0?=
 =?utf-8?B?TXhlVDdLT2U1T3dLTXBFL244cyt2TG1iTzl6MEN6S2MrZDZaYnJXYzdGNnhV?=
 =?utf-8?B?ZFBlUG81SjViT094SE9hNStkV3J5cFM5aTBHaHhWQ3NTS1JQZ0ZYTEEwNytD?=
 =?utf-8?Q?TK2FY05/3A3/+CC2vv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ae034a37-1954-4e5a-c8d7-08d996cc782c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2021 08:58:38.2535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 ABQ+EBKX0F466sF/vXFBAisbuOBwWITEgOgS86eWxXOkCO4OP6yRFbipu+LnRm/2GREgjE5/Wa/9SSJoxYr0NbiLzTgnpCE1LXFbNmF/JsUinp4kdTxb38mVNFb5TeA4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3065
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 24 Oct 2021 08:59:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6839

SGkgYWxsLA0KDQpDSVAga2VybmVsIHRlYW0gaGFzIHJlbGVhc2VkIExpbnV4IGtlcm5lbCB2NC4x
OS4yMTMtY2lwNjAuDQpUaGUgbGludXgtNC4xOS55LWNpcCB0cmVlIGhhcyBiZWVuIHVwZGF0ZWQg
YmFzZSB2ZXJzaW9uIGZyb20gdjQuMTkuMjA5DQp0byB2NC4xOS4yMTMsIGFuZCB0aGVyZSBhcmUg
bm8gYWRkaXRpb25hbCBwYXRjaGVzIGZvciB0aGlzIHJlbGVhc2UuDQoNClRoZSBpbmZvcm1hdGlv
biBmb3IgdGhpcyByZWxlYXNlIGlzIGFzIGZvbGxvd3MuDQogIHY0LjE5LjIxMy1jaXA2MDoNCiAg
ICByZXBvc2l0b3J5Og0KICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvY2lwL2xpbnV4LWNpcC5naXQNCiAgICBicmFuY2g6DQogICAgICBsaW51eC00
LjE5LnktY2lwDQogICAgY29tbWl0IGhhc2g6DQogICAgICA3ZjY5MjA1YWNmZWExMmRhNjNlMTBi
YTNkY2FkMDg5OGI1ZmQ4OGU1DQogICAgRml4ZWQgQ1ZFczoNCiAgICAgIENWRS0yMDIxLTIwMzE3
OiBsaWIvdGltZXJxdWV1ZTogUmVseSBvbiByYnRyZWUgc2VtYW50aWNzIGZvciBuZXh0IHRpbWVy
DQogICAgICBDVkUtMjAyMS0yMDMyMTogb3ZsOiBmaXggbWlzc2luZyBuZWdhdGl2ZSBkZW50cnkg
Y2hlY2sgaW4gb3ZsX3JlbmFtZSgpDQogICAgICBDVkUtMjAyMS00MTg2NDogYnBmOiBGaXggaW50
ZWdlciBvdmVyZmxvdyBpbiBwcmVhbGxvY19lbGVtc19hbmRfZnJlZWxpc3QoKQ0KICAgICAgQ1ZF
LTIwMjEtMzgzMDA6IGJwZiwgbWlwczogVmFsaWRhdGUgY29uZGl0aW9uYWwgYnJhbmNoIG9mZnNl
dHMNCiAgICBhZGRlZCBjb21taXRzOg0KICAgICAgQ0lQOiBCdW1wIHZlcnNpb24gc3VmZml4IHRv
IC1jaXA2MCBhZnRlciBtZXJnZSBmcm9tIHN0YWJsZQ0KDQpCZXN0IHJlZ2FyZHMsDQogICBOb2J1
aGlybw0K


