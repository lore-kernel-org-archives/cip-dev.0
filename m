Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D02C48BF6
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 00:42:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.31195.1708303335144464919
 for <cip-dev@lists.cip-project.org>;
 Sun, 18 Feb 2024 16:42:15 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 41J0fqnU4161950; Mon, 19 Feb 2024 09:41:52 +0900
X-Iguazu-Qid: 2rWglQcuLYu1MQbbEG
X-Iguazu-QSIG: v=2; s=0; t=1708303312; q=2rWglQcuLYu1MQbbEG; m=liolSXf1z/JZspuGcroDX2f1v/WtCw8DWMcdSKLxY3E=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 41J0fnJO579118
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 19 Feb 2024 09:41:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ld79esDNwoJP3yTDL0t/wlXJLRfgXyXOQ76BNMnhizkwCFJjuOaGnybGbd68p8Dm19shEHzlHnFmx4OM3YTyYxlGaPwqYEJnbm2axfWYdc9k2cmc7F9mLM1YCbJttLJU0cVD0sf3fEBuVQlq40Vbs/ptUYl9m7I0aUDC9skrv7lpeLXQDunPSwXBhN5WbP+dC1X63oSIzHG3adSoxlzPP8prt31L7BumJUB1Sd2rQtQw1UFi/3xkiF14dnQBtkqN42TJBMXdHFUER+bnAWh3W4BPyMr5zVOSAen6TgusoKKbsbc7WGif3IvMH7oxRAQTnGflfSYhd740x52WG7ckkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtsoCH9X+yGe4rxcjSlgtiX4DpkRvWaA81M3yYQvh0I=;
 b=IU2vSVdDE2Qcyg/8RRAgAPkiOA9ORzW58S9Q1O8L5hqmAr7AsH4r6u6232XUsJiGaUfp3kkjuusoiZiWl4kfiBgfcqgGTX7pwMfl50aHDo7RvjFroEuug+xLR6frN5x67MqmVLM/IHu9YP1I4ZMr+iK9/V8bJyyOX0KHz0iB1d3S9R/hQNh7TJhsTnPG7VxPafegCzCYNmnnCOZCacdDYGmXJLDXr090pJu7E4/ZexeaP6yBwJB6m9e9Of/+IkHl8N5LlE/C6L4SWOA6ZVlysPrNy/v9vPKx6uTdZzl7n/uEwor5jGuWmhBA74xw2sEvOajqdczhx+Ls7GBZkNOKog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.306-cip107
Thread-Topic: [ANNOUNCE] Release v4.19.306-cip107
Thread-Index: AdpizBfukngTWstVQGyLm56ngN6pSA==
Date: Mon, 19 Feb 2024 00:41:46 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388B40A6EEE4574C0F76F1292512@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYWPR01MB9922:EE_
x-ms-office365-filtering-correlation-id: 118e8228-07ae-4b0e-06fe-08dc30e38d54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 J9mc4kiGBhvP/dFwC+JdjWQFQIj9q33m5h99UTRcmgQ/k7qXkoOGhrsMTE9kSE6I6Id2DtBPlaSDSmeStvhEROfnWFM4Y/M3PcKCijLiruNoiHDpG8ItumvPawHycpcN/pv7AZYQmGw5NYceO2KZ6wgX6+K6y/SZSgoE45mYye3NJao0sI45VboNL+zOZLaSyuJ74yUVfsphUYMoQtplQV5TwRxUJIrSciUO/q17UZjq+hAj/L0d64y/nFw7Fp0aujx3uGLAYWEjQK+iJcRCOaMs3dDa/wpGowHK7XN92TktyOB3Po6pvtTEJJhAD8D3XhYdwjNSWaDtHfEc00KLpaEl+mpBxmFCBteDv1O7fvsK4t1NgXqd6LSi9VoEhO6Ascz8Kz5gz41FYfdmi9sVtpdLwGcnv6sVRTd9JA9eG29mZWFppuBjNEK4/xlOrLXfiEmTGsTBrTmh56pfhRhUZGt7AKqDKVlSELfSbpJEM4bBNSEQogjw2mVfOaiO/q+GSEZDgcYiQ9HHENReG4mEV2q0Y9Ae7sHrj9HPMHuqu4ptB+C/ZV1sCin41Uji4mRIBBthrIYGgGNUrQ27axGWwIkLeQFRlZsRyinAXuxlphvqHPTc22ECRsfS0Jzdn/Kn72T3RFo19OlX8q/UKEdYzw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2906002)(55016003)(5660300002)(26005)(8676002)(8936002)(316002)(52536014)(66476007)(66446008)(64756008)(6916009)(4326008)(66946007)(66556008)(76116006)(41300700001)(83380400001)(38070700009)(38100700002)(33656002)(7696005)(71200400001)(9686003)(478600001)(54906003)(966005)(6506007)(122000001)(86362001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YXVCQ3dhRGhocG5JUFFYUC9oRGxMRU9Ed0ZaVzZXUzArbUZIaFdxOHRR?=
 =?iso-2022-jp?B?dHFaazBPNFVmeUxlcmtBWU42ckJFUTRCaEorQTI4TzUwMkg1K3BTU3ZE?=
 =?iso-2022-jp?B?NGVGTWRJUXNETHR3N3Z0R01LM0ludjJPWE90ZTZOeXIxY2lkM0tFZ1kr?=
 =?iso-2022-jp?B?RUhlNDFFM0orTENNYjB0d0QyQzBldFlHdVd3ZkJiTTlBZk9zQ1Q2b0t2?=
 =?iso-2022-jp?B?aHNmbk1tNG4vdnpadXRiVVVURlp3dnNwWElJS2w0NmVKSW5jQms3cVp5?=
 =?iso-2022-jp?B?dW1QMEx5eG4xZWo3VktEUnlYNFJnWXA0QWU2OXJkZExyMmNKaE9yVzRv?=
 =?iso-2022-jp?B?Ymo5dVdDUmUwT1krQlYyN3NPbjZUU21DWW05UjBIVDB2T1E1TnBJQ1o4?=
 =?iso-2022-jp?B?LzhPUjJtY0l2Vzk2aVZLWnFKbFE2QWV5ZEVjSDdienNzQXIvU2Z1MXJy?=
 =?iso-2022-jp?B?TmE3cHQzL1RhZzBHYk1SWTRsbytRZnZjYkNMVkVJQm5KV09ORTBYYlBX?=
 =?iso-2022-jp?B?enVLa0Y5UGxvZFhCelR0TXorb0JaWU5tbmZiVmNwcVhNeGhkcnhQK1pa?=
 =?iso-2022-jp?B?KzhMZlR2K0IwOXVnZVhuWlJqalVaczN3VGpVckQ0YkFTdjJ5RlRuRnli?=
 =?iso-2022-jp?B?VExrWkovSWo5NzJqVlZsRHYyNSsyYlFMaDJ1U042ZzVkUnJuQW9URERT?=
 =?iso-2022-jp?B?WUhyTXZXb0Q2eXZIY1YrSjV2RGtYcEVNZzNaYW5wazBkaXRKM3piNjNy?=
 =?iso-2022-jp?B?MUxLcytjdWtHSFBVNW9lcTF4SFEvVzlWRkJMcFFFYndCNzR6MGhxNlJ3?=
 =?iso-2022-jp?B?ekx1dU5ReEllLzFGcmVIRTlXcTFBNGNLUjBqdVp5ZVVOUWJEcU9WZEpp?=
 =?iso-2022-jp?B?bE1HV3ZpY2xkV080bHkxRDVUUHFjNlVBWmJ3dy8xRTRmbDZYdFE4SUsy?=
 =?iso-2022-jp?B?SzJMYlVjV0NnYWwzaklIakpUNzBUUDJIeTZzeUl6VUcvN1VhK2FDL2o3?=
 =?iso-2022-jp?B?Mm5MZkpod2pURVlYUjVpN3NxNHlrbmF2TnBobEwxOXpIT2tBd0taUGFI?=
 =?iso-2022-jp?B?QS9lbTdQL09VOStHYmJuOUptSVFzRDV4M0l3SDFZMU55UVM3Snd1V2hp?=
 =?iso-2022-jp?B?cE5qdmlkSEo5aU9IdVB6NHRIc1NudjdXSlRCSjIrVEU0QWE1WXlYQjN4?=
 =?iso-2022-jp?B?NzNnYWVOYzQvVnI5TVBYV0F3a25DUHNYR2tMb25UOHVObEw2T2hBSWhL?=
 =?iso-2022-jp?B?TThNbDNLanlyclVEd2EyVnUzZUdiMWRFM3oycWVPV0RQbnp4SHBFamVx?=
 =?iso-2022-jp?B?QXJ2WW81SEt1NUpRbnBlcE9zYTkwY3VZOXhLYk45eTJUaWFBVzFUWDd4?=
 =?iso-2022-jp?B?NHBnQkJER2k4L0Q0cGI0eGo5Zm1mQXptQ2Mra09BaVpoQXZySXMzemxq?=
 =?iso-2022-jp?B?UWlYc3dmdnpZSzVTdkw3L2tRMTNzY2RRYS9PbjlvUVptSDkyMUVjMXJh?=
 =?iso-2022-jp?B?WUd1YXBEcnlVeGw5YjVwYnM2Z1g0TThYNUxjUzVJWkFhU0ZldUNwQ3pS?=
 =?iso-2022-jp?B?Q2F4cktsRUVWZy9qbHl5eEtQVWQvN1prdEJYWUtTa2NrSTlObkRGbkRt?=
 =?iso-2022-jp?B?NkdIcU1UcGk4SGs3SUlDMkY3L2QwanRBWjk5UER0ZEVla2hoeWg4dCtB?=
 =?iso-2022-jp?B?YTNORkwxZHkzSFZKWGpKc2lJcE96dCtGWTkwMERQVzBrQnVqM2tYNERL?=
 =?iso-2022-jp?B?R2dkaTJMRnlFTmdmU2drRlAyeVlDdDFJS1pja2hmU3lyVFE0enVxZHBn?=
 =?iso-2022-jp?B?TDJLMWNyVmVqZzI2amtRQ1o4dTdoNkt4WXhLUzNyY2pVS2VvQk5QcGMz?=
 =?iso-2022-jp?B?cG43ZVROQStTcDVlVC9xT1F6d0E5RHRtL1V4dlNxV3d2aTg4NUY4WkNi?=
 =?iso-2022-jp?B?eDVLUGtIeEQ1dGluQ0RyRmZlYWRZdFV4c3oxV29JYzY0cWdYWDllS0Qr?=
 =?iso-2022-jp?B?RWR6NGx6bTdqUGlsQVRYdWNmK2RKNXkyQU9pUUs3R1dhMVZubnRRK0d6?=
 =?iso-2022-jp?B?RUZCdjhBaTdtclRUdlRpYU96V0g2VzZpUk1Oc1p3eVVCWGNYb21tUGxG?=
 =?iso-2022-jp?B?ZzdYOXl2VVdiLzRjODNBd0RWdlJTN05tcnpKN3FZL3h6WlJYUmtDYTlH?=
 =?iso-2022-jp?B?OWNmQzNOKzRGVEJHL2h2Tnh2STdGZkdUTjBSYUl1M1dEWitaWlhibU9P?=
 =?iso-2022-jp?B?SzNIdUhjZWxTdUNuZGM3QVBYWDVRK3VveGFFK2g1dzdsMnBEVjEzMysz?=
 =?iso-2022-jp?B?SUVLV292OXRnSTF6a2tyTU9iL0ZTSUhOblE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118e8228-07ae-4b0e-06fe-08dc30e38d54
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 00:41:46.6528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/b9s+NI5ALkHuJ/25EGk6rzUgvbOF98f4ALDUjE0BfeK1kM1oE3qNqyFmMHZmJZX+7ouhud8flvS90jnNxqWkoyfX+pfpswaH3XCqj/jd1+y15kmogbEgK/jgjyZhYn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9922
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Feb 2024 00:42:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15022

Hi all,

CIP kernel team has released Linux kernel v4.19.306-cip107.
The linux-4.19.y-cip tree has been updated base version from v4.19.304 to v=
4.19.306,

You can get this release via the git tree at:

  v4.19.306-cip107:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      800dfc28d1a90b195d50f75fa7711d00cc1825bf
    Fixed CVEs:
      CVE-2023-46838: xen-netback: don't produce zero-size SKB frags
      CVE-2023-52340: ipv6: remove max_size check inline with ipv4
      CVE-2023-6040: An out-of-bounds access vulnerability involving netfil=
ter was reported and
               fixed as: f1082dd31fe4 (netfilter: nf_tables: Reject tables =
of unsupported
               family); While creating a new netfilter table, lack of a saf=
eguard against
               invalid nf_tables family (pf) values within `nf_tables_newta=
ble` function
               enables an attacker to achieve out-of-bounds access.
    added commits:
      CIP: Bump version suffix to -cip107 after merge from stable
      ravb: remove undocumented counter processing
      ravb: remove undocumented endianness selection
      ravb: update "undocumented" annotations

Best regards,
   Nobuhiro


