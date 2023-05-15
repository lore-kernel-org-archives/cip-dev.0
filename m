Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BCCC77B7F
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 00:21:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.78144.1684110082709148825
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 May 2023 17:21:23 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 34F0L3LY020172; Mon, 15 May 2023 09:21:03 +0900
X-Iguazu-Qid: 34trk59YkCjy2dXvlJ
X-Iguazu-QSIG: v=2; s=0; t=1684110063; q=34trk59YkCjy2dXvlJ; m=p+DGbqfUNSossSgE8gVKFa4W5N9X6rxKaurQfUPMQoo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 34F0KxMS037769
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 May 2023 09:20:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJpjg+bWNV5SzAx5li6gBCmmmkYNjWs+2nc77HQ781SybcFbzTHMz+YfWNCuPY9+w6p7hAghs0fNILFWC8QBfSTicQdwOGwUVZeeZBqBHPiunK2SLJ/5bbu2PdX30V8ivRVy3hhCZ/+dIFspNVc9qazAlnIBu5k88OL2GSHx1CHSVIM6+TQ7bCypmmXRE1/rMVpHfa0T8r9KGRNaG31/JvREcc7Z6Pe2QxArLGBNH0VRif7SaCVLVsEIizrC/ej9PXEcBRdn17HCcPjvIcY66aD3TPuiPMo4adRMvKC4IyrVK3ald95HyGBIVlzOsB8C3CiVyGSCnPCLuWUwnYfD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPgvL9HEhWR7omJo4I90q+lngifK0o/0cIBzgeJsr+8=;
 b=AjpeEWvDVqf9JJhU6w7eJFkj8UrxRrPsFjnCikRwAPCu9ny6eM7meDjH7h2NTMYzEaj+qGATz2fLo9cL2jztTYgdxthNCYukH0OC4WCqpSdw8Z7pyh5opIwUrCf+OObYjRMCHfBakelEaiXQuuQkpXdWWknGlkbfhbR6+bnfGH7+n1+G1NzxyBzbOS/Vzs9BoyfLBbXB1uTR1FdqUt+5tnStavzHz8JzeM428jfX57lHtLYZf7IJV9GInvV2Fr8Sx+PCB3CdZFq+gTwQ5njIaM6BHljitBi6osZ8Cfv1/bKRwlAoERIsVXuvwJj+yJX4czHmW9tTBkHBWMTK1GR7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <uli@fpond.eu>, <pavel@denx.de>, <jan.kiszka@siemens.com>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: About the CIP kernel release in the second week of this month
 (2023/05)
Thread-Topic: About the CIP kernel release in the second week of this month
 (2023/05)
Thread-Index: AdmGwm+yLsUqtwjbSx21Thv6MRP6sQ==
Date: Mon, 15 May 2023 00:20:55 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420924E516E9B74C342E5AA92789@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TY3PR01MB11075:EE_
x-ms-office365-filtering-correlation-id: dc51ca7b-8a42-4470-e2cd-08db54da3fc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0gfKQZpvx5v3mz1fQLgLRglsldsHXpBa4Aa/gCf5raFD875CyFsyaJ5e0dwYca/XZ6JtyT69vG+Hp797N8k/HMNVQ79UPVgyiQWN5+FyCjaaqobr86bMV7HzP9jkftcw6En+TsPjJtA8TETq8N62zWRPXUwo9ekInjM0WdkKzSzPSXCSC4IOgiIEztHE4dWiv8B+h9xvG9S20niDpyjFdN9NC4dL8uB7DMBXoQa4kYZPRETIGeC3VX3ghLehQxm+eIc0N88AlI/OBzvZ2t/0QQz+G7I+M9w+GmVImei5uq6ImWgKqBdSc07FLc/rPXa/nYkxt++Ov6ws8rNerU4zYUbhPuG2L35Bw40tJDmVv/zevh65dBYEkeVVFChnYS9a56oowOqv3RVNvqKdXrzWPUg7kRmtFfCecSQpjusdDJWZvcerKYiGOlaVxOkJYVxUiYgJNZEtLW7X8KDSHn0nLjDRKPclqZdwaork225pWLRUhKWWcxk4QxdrE31gpmnCOeX7fdI5AurxnbCTe0a9NL1/ThCtqpu7/DlmUOU4q/wTjyAtcZHncjs9GMXbsAhP5gikOIXL1k55MKHGn/NPYPZQB5fe21faH2ylqiFYeaI1/+czWxtvfnowZdEH+/+dFRG6OErPc9gaYlLbA+s4TA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(71200400001)(122000001)(55016003)(38100700002)(186003)(26005)(9686003)(33656002)(2906002)(4744005)(6506007)(5660300002)(41300700001)(52536014)(8676002)(8936002)(478600001)(38070700005)(7696005)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(54906003)(316002)(4326008)(6916009)(86362001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?K2RRSk4wZ1hkTTZ5Y3pnTWJGT3Q4VUVhZ3Y2UUlOM3F0bFdxd0w4ckUw?=
 =?iso-2022-jp?B?c3JORGt3VEtBZFJhY3hFRmFHOEl0SHZNYWJZOFRvcGN1bElYdi94eDAx?=
 =?iso-2022-jp?B?dThJb0RGalFQSGJsWkZtR0RXcFlBT3F2VzdJMHZjRCtBL3BzcExENmtD?=
 =?iso-2022-jp?B?S2daZ1lNdTBmZktLd01qVlY0eEFLMnFhRjFGb0dDbmZzMFFXQzNIM0gy?=
 =?iso-2022-jp?B?eWZDd1pxZDdmYkRXaHBBcmpCZnA3ZnJWZGVkSUtYaUtQSlBqTHN4OUt4?=
 =?iso-2022-jp?B?ZHpGYy9LVUNTQ3VVdjFxS2NkbGhXK0ExL00rblZoTXUxNEVuWVdIR2p0?=
 =?iso-2022-jp?B?NnZUZHBlZ2FOU1B4VkhqZWxycldxTW54Y1N4ZEk4b0g5SStIeXJwTWgr?=
 =?iso-2022-jp?B?RTV0SWlKUjl0K0pPbnNkTU5ZWTRnMWU4U2x3UVd5alhJVXBpQ2xlUUFh?=
 =?iso-2022-jp?B?RitWV0xxRDdjNG0zWlFiTlNiek9YUGVxYm5rL3RJWmhob0RFK2o2UEd5?=
 =?iso-2022-jp?B?RmpBMXZEb2sxSVhHQmlrSlFld0Fwd0plUk11V2JTamVOM2dmelJud1RD?=
 =?iso-2022-jp?B?bXdIdTJzbGJFUGFFSm1hWnJjelRnZU9GL2N0bEdENlUyQ1UzRnVaMVBJ?=
 =?iso-2022-jp?B?VnlsZW4vK0dCeUtYZHljVEJwWGNIZEVIR2Y1bEJoL1NjeWxPNDVyWnI0?=
 =?iso-2022-jp?B?bjVlNGtxdytUTVlvQlM1elpWRVVGVTFuUlRKRWRrNmlVSnM4TldHNnJJ?=
 =?iso-2022-jp?B?czlJbC96R0ZMOXFGbjNnUXNLZk1rMnZxNmE5eVdZQWNKVWNYRU4yKzRE?=
 =?iso-2022-jp?B?Qmx0RktTa0NTWTJvZkdJUTJ2T0x2OExoc3pKbW5QT3NoWlVvbkR3VWsv?=
 =?iso-2022-jp?B?MTRLK3hhRXNKTVRzWmpDeW1zUURnT2dlRmxtbjJJWlR3VEl6Rml0OG9E?=
 =?iso-2022-jp?B?alVCdld6eW1HZ0YzNkVDVWlqQmNaQlkzRGp1SXpmTU10OGZiaWRKRUNV?=
 =?iso-2022-jp?B?K2JvdnhsOTNnd0dkaVY0WDQ3djhOTmgvTnNXeCs5bUxqb3AwcE9mQTRk?=
 =?iso-2022-jp?B?T0N0TnZJNzVVQldibXdYbmtWbFZZSDRHdmRubjNrNFlDV1hYcTl4UTdz?=
 =?iso-2022-jp?B?ODlJemNZMW1waTJHcDVud2Zmby9mRndSa0QrK2ZwR2R1bldZUUE5R1pm?=
 =?iso-2022-jp?B?aFpNUVFEQTlZWDNpM1Y3cEdOS2NIODFIZktkK21OZGN6M0VxamZBRith?=
 =?iso-2022-jp?B?bklvRXFuZW1UTXhjd3JrT3ZFL0xwaEJNNi95MGQvQkZlZDhUeXNXZmUw?=
 =?iso-2022-jp?B?aVplNjJEL25mclFGR3FqN3U1RHVLOXI3QnRZbEZ3SnIwUDRubEJzVExl?=
 =?iso-2022-jp?B?c2t2c0ZvUWtTYkxURTJIOERzYnkzMUg3L3RZWVN4dkJ5ekFScTN3RzRq?=
 =?iso-2022-jp?B?ZHQvZDAzaG1oejBhWlhiUDJHQSs0RzRFdTQyRjlpdk85SWN3NUNRdTJH?=
 =?iso-2022-jp?B?RW8rN3hUdnRIUkxiQzhMVkdxajF6S3cxSU1sYkxIQ05XOFVoY1h1bFpn?=
 =?iso-2022-jp?B?SW51dkxTT1FhNmVIWmt2UitNTUVTcUFXZWFYaG45MWtpM1loQzh2bkQr?=
 =?iso-2022-jp?B?ZGJPaTZQL0ppSzBYZ0o2ZUFQdFk2SDVuTGJRQW5vdEJXSVlCcFE2dHBu?=
 =?iso-2022-jp?B?dTB0VDRReWtzS2JJVjlveGhvM2dRMFluTFAvS1J0ak12Tnp0RXJXK094?=
 =?iso-2022-jp?B?Ti81VlVwaE1pT25vNDNPWjF1MmQ1RzdIcXZKZlBVdGIxVjhlSlkybk50?=
 =?iso-2022-jp?B?Zkh5dUNEMkxMY2VncVdBckNlMTlDMmtCcjFlZ1BxUGU4bVRZajBhMEVj?=
 =?iso-2022-jp?B?VUQ3SlBvUkk5dGZEalBwTkhFcGtrMjlPdTRoUEZOaUs5VU5DV2lrWGJ0?=
 =?iso-2022-jp?B?ZUhCYjd5SCt1V003ZndtNHM3YXNzVnd6R1JVQzlhbDZ3ODZoaUszTHky?=
 =?iso-2022-jp?B?SmhXUlJvL1liYzR4R0paNDRSdGhabCt1SFQ5b3RVZnF2czkyVWU5NjU2?=
 =?iso-2022-jp?B?RUNjVEFrN1NzUHdnRjcvWXJlUkFWb0Z6MXFhMkZCQkNVWEJndlZlTnEw?=
 =?iso-2022-jp?B?aFhVOS9PZkJEWlJmZ3ZBemlNUGFRb21sQXl2MzdROHB2UDdNN3p6blM4?=
 =?iso-2022-jp?B?NWw3VkpUV2R0RzVDYnIzUHo1WVcwRDBkVGtPaFpRTDZlMWpia2FjcjFw?=
 =?iso-2022-jp?B?TVVweUhweTg2SzNhV3hDQ2JPSTVJZWxFVnFsZWxIRlhhaFVWVzhrc056?=
 =?iso-2022-jp?B?VzQ0WGE3d2Zzc2oxcG1tbUtMQ2hPeEJTdUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc51ca7b-8a42-4470-e2cd-08db54da3fc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 00:20:55.2262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8pyWCs0JTJ80rL5wSxPFNac5XpFAybEIvVGZHPkRaz7nRnDmNnlPWDN+JxOAUIVrhBi+PrEwhxxImLGTH+lvvZ/g9Yces/aMlns0ilMz5fRscmuisWHza7Ubnl4sKDm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11075
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 00:21:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11441

Hi all,

I report about the CIP kernel release in the second week of this month (202=
3/05).
No new LTS kernel releases since the last CIP kernel release date (2023/04/=
28), so no CIP kernel releases this week.

  * latest 4.19.y
   - linux-4.19.y: v4.19.282 (Released 2023/04/26)
   - linux-4.19.y-rt: v4.19.280-rt128 (Released 2023/04/24)
   - linux-4.19.y-cip: v4.19.282-cip97 (Released 2023/04/28),
   - linux-4.19.y-cip-rt: v4.19.277-cip94-rt29 (Released 2023/03/22)
  * latest 5.10.y
   - linux-5.10.y: v5.10.179 (Released 2023/04/26)
   - linux-5.10.y-rt: v5.10.176-rt86 (Released 2023/03/24)
   - linux-5.10.y-cip: v5.10.179-cip32 (Released 2023/04/28)
   - linux-5.10.y-cip-rt: v5.10.175-cip29-rt12 (Released 2023/03/22)

(The CIP-RT kernel has a gap due to the release timing of CIP kernel and RT=
 kernel.)
However, if there is an LTS kernel release or an RT kernel release, we may =
release them accordingly.

Best regards,
  Nobuhiro


