Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D45C0032E
	for <webhook@archiver.kernel.org>; Wed, 25 Oct 2023 16:33:59 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.85])
 by mx.groups.io with SMTP id smtpd.web11.48385.1698251633687995710
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Oct 2023 09:33:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XBrAGqx0;
 spf=pass (domain: siemens.com, ip: 40.107.21.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPS0X8XoxbWgL3G0v/tLn7vXNz01QlQ0JwC9kC49Goi0V4nP0RKJ7tcZoiebPPepOFG+lkov0Cflu+Vppo2WemPL8uZuw7SOwkwwO+GzlLRZDXqhLT8WROXIojUHO/pwWcc/jq4sqFocewOqHnoSViZsySNW1Vbl6gs/8GucGxP8ZNxtXbbo0swGWDZMCUG9BMMCezJFb0BgT3ewmmz3A9cfbxUm6z+omfCpmq0vztdbH6LJ8iLrRZCNdGZ7+b3miLyDzyoh6WtNzz1q0+CVoIh+6Kx9OESRqPGRXjiPJt5Zbbw3/1cH2soMY4N/OaYjrUzpaf26IzWBx77Ld/PDoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TTpJAvGG8z+FI1YU2QXn0agV+t45DVId/3Bjxkrtbs=;
 b=MuUnzEqhs5uLZzv85smTKjto5n6POWBeiu6ASoYaYmfOkqrMLh5gU/DoDbKdNu0ZN2P6ZJXShLbOZF15HyxQ/xK3xAsIvW61NeuQjGL42bmS1Wz/PknXN5ucRTqKsLUY9SEXXQNDVx3j9L6LVPnpUb9/hrbTZsspWkibBbVKC7U5cfWB+Q9Vh146qjKc0IY7j5htjcKS9VLFHuR3/pfTctpjV1453qH2lNWSHLuhnwC5sgzO5qKldEUwZc/L54mumDzJ2sGqZ/FOuzIqIBJ6itr84V3SHjWoXX/cyQI/BaXdFO37LDMPqn6eJufRPf1w6rh+LstdT967Oms8goYohg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TTpJAvGG8z+FI1YU2QXn0agV+t45DVId/3Bjxkrtbs=;
 b=XBrAGqx0jnk74nTbM5vI1/3n6S2sPZFVzFt7eIdlUGp/3zPo/hhEjpXOy4WKXTVXBCOm6FcnR2NJPLdky/Na9WOQZOHFGzWGWLxQNabReXH2sFz83TT/QLUQxkvfYOd/T7XES7PONhuFClK0JUD31ctEpS5MtVnbFe70YexfRDiFaMblLQd+7VH/k4hwvQ6BykgQKI1HZ+aUtHAJ1qbMwb6XEhbiTuErQKQmcGLAefvJALkpB2vJ+ywTtxnj1qHBo0U4d9fthrSemnf0lKaGxnYVW49Oagbo8bqADxyGYCA0MA3i5JSvroJVc+k4HkkJQHjL5haATf/uetHAvMg2Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6865.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 16:33:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ce06:5d24:9896:669c]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ce06:5d24:9896:669c%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 16:33:50 +0000
Message-ID: <f4f3487d-a5c9-4da6-8c3c-2df750362c83@siemens.com>
Date: Wed, 25 Oct 2023 18:33:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 0/9] cleanup of customizations
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, venkata.pyla@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e5acd0-be9a-4e21-b25f-08dbd5782b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TXFiqAeoX4Dy43Vhc/GnNzgTsdmr5SiBL6WgegmPW2/5fnUXvuwZ0U0ox/l7OfLdcj84GnzfkAHWwzu8fE9StcllthW2cPtzHd8PYw+hoCouuwxrLuwJIu2Iy/TkQXOmhpe0NDa9AvxxVuvcR698x7LMUzzh2/pIx5kw66bYbDAO/RLBFZGy/lxf2rW3q78n5t5cG5ZxLsLbxWcCq7Kct3WfAdqhv4A0vy3Qed5o7BxTOZupyysp12LVNYVyLZ5TlH1AFpHwaxAGiDYIl3JnnF5iqPEGasgFTv0bJXKzIbRQ0Xz05asfkluNILjTNYMtClsYQ/YpWgd+3lXqJdCaP+f2KS+/1BMjOjHsjVPGjdqCl7x1wCIfPrrtMwZAqkLMe/vmV7r4IGxpFpH6rXjSrV9YfgI34Ys+rwWgZjOMeYlFpxywRzw4EtloOUku3Lv5XpLYzvTWkHZiHUi6nCWHTDh9d2fIzamzTi3d9tQaL44PrO+RP8Hhu6gA6nZn6nLkGJRxeWiyICklgjGOuokxuxjbOXnAd1sHX2aooE16Acuu+Qrv/sjDsr41y4uFbCNXiRhkkpWMlneNxOdltt9Ne2wzmqI17h9W9ciaMBSt40t71oBZT1ju9LuYQNnig32JlcOhPycUARbanVWZEARjrg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(83380400001)(2906002)(38100700002)(36756003)(86362001)(31696002)(82960400001)(316002)(6512007)(5660300002)(6506007)(41300700001)(44832011)(6666004)(478600001)(8676002)(8936002)(53546011)(31686004)(66556008)(66476007)(66946007)(6486002)(2616005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UjVPM2RZQVFkby9zczhlb3Y5TkpzYWxBK1ZFODR4dDE0OGVVZXd1YkZxRng4?=
 =?utf-8?B?ZDhUc3hyMHpjcS9yejVMSjJXR1VOejJaUEptSXlzcjZ6ampjSy9VY2VtZDlB?=
 =?utf-8?B?YXU4ZEVBWHZoUnRzUmg5QTZsRkVEOExCWlJFdUVEY1BNajZ1enBMb2d1OHBZ?=
 =?utf-8?B?OXhHd2o3aS80cE5iSWFPWklxa25HUHcrYTc2Szd5R0VqMjlQbWlHcnl4cENH?=
 =?utf-8?B?elBKNndOR2diZk5sT0d2NUJTaHZSNXZxZVZZQjBtUURDUGFXamJ2NlYyeFdo?=
 =?utf-8?B?RE1yOHdKUDF4dGxaQVFuR3Rnd0Rta2N1ekc2TXNJaFJXKzF0UEFMMW5GZk83?=
 =?utf-8?B?b2tUZDY0d2VwV0x3citQZ20xQ29LTEpVb3FabGQ1VEpKWHVKbjcvclpBUmtZ?=
 =?utf-8?B?ZTVXcE9XTW5mTndXYmFBRzJid2VkdUtSaWRwUmF6cEF6Zjc3UWJ6QjFGN0VF?=
 =?utf-8?B?aGxoTWJPcGRycFBOb0VWZ2VlWUk1MFVVVGN6NnY2UkRyakZkaXp6OWhhbG9v?=
 =?utf-8?B?eVZ3TjlXeDV0Sk1BenZNTDJPRXB2VytxL2ZGc0U3amRFejVMdjVhMTlSUlI3?=
 =?utf-8?B?WHV2eks5cThGc3FWam1zdmxJcFlhRzdvajhRYW1GM0JudVNyd0ovNHVnbTlZ?=
 =?utf-8?B?Nk1qdTBsbS9ZWjJmQWpIc0MxTDhSbzRERnkvRHRuby9YTlN5N1RMWVViOTR0?=
 =?utf-8?B?d3lMYnkwKzdjTjExRGVDQmJRYUNOZmFZcWtqNlVVUDJNNGtqSllGNmliRllG?=
 =?utf-8?B?Q1ZDRlJQUERUekpVYmxZRXdrQmdHbzJ0aGNRR2Frc1JUUUxBVkJhQkt6Tks0?=
 =?utf-8?B?anVhYjJVdEEvSkJra2cyOWdaNjJnUFVGREhtYnMrT1ltNC9qUVhBbmx2bnho?=
 =?utf-8?B?TG1wTzlncEdUUjVabmpZKzhQaGhVL1IvRUlRL0lWYUVDbTgwS3lqeWF6aEhP?=
 =?utf-8?B?WlJBcXc5dVBIZlJjR3prZ2hPZ0lIQmxtLzZ0TGM0b2hLZmI1SjJ2bjZxZnhP?=
 =?utf-8?B?QjVEdGU3cWhyR0F3MWZPMW03ajdQK1FkNWFlSnpEMi9vYVkwdEdLRjBsRXVa?=
 =?utf-8?B?R0hOdzlISW1MaVd2NysvZFBjYUd6MjNaUEIvYjVscG15T3hNMUljNG5uYzFu?=
 =?utf-8?B?dHVPWEJCTGcrVUl4MmZ0VmhLdzVwUTV3c2x6Zm9oMGUvZDZlaW1KZU1MUWh1?=
 =?utf-8?B?S3VEZDliRUgvbUtPS2FuK3BIcW1meEFxZ1NBbUlMT0tIVWo0TkFLUjdzaFdu?=
 =?utf-8?B?M1pmdm5zUk5tUVpMcCs0eEM2amRjbnNBdldpa2UyQTZnSWlDUWE0bTZZMEEy?=
 =?utf-8?B?NklZbytOZjRWRkhreXA5N214anVYY2ZNSzVuNURValRLdlBrbUc3eTFHMitB?=
 =?utf-8?B?YXFDL2RlSHhvV0ZnRGlMdDl6Q1Z1V0hsc3ZEZU9SUkt5S1hadlYwbGNyZ1lk?=
 =?utf-8?B?MDJTcEJWWklydlFoY29RSzA3WVVxYXNBb2tHYjY4RE5CZGVSdHYyRFgwTHYv?=
 =?utf-8?B?UUVZdEplOWlzYy9zcGVLNUNVeGt2RTA4eFAwOS9GbEs2ME1NeFIrMHhDMG5i?=
 =?utf-8?B?WHFUbGtpSUt0aWFXNGVmR01IbmhxUmpEdWtDSHZaOTlMalcxMkd0ZTdmN0h3?=
 =?utf-8?B?K3BFamZHLzFoWlgrbWxuT1dvU0VpSENGL2E1dTdvTjFIYk1yR21SeHY1VlB0?=
 =?utf-8?B?SlplQ3duWC9ZWk5vSi9wR0RTTGFoRmJCSnkxNjM0cEZiUkdvQjZHYUR2ZnF2?=
 =?utf-8?B?RkY2MHJYQXQwQ0plUko4VFZrUDYxUkhKcSszb1k3dVNRalJZcmJiWFgvdS9Q?=
 =?utf-8?B?bk5QQldWS2ZqZXViUGpqVG1tM2V1VCtGMHBhcHByOGxmakx5T05YVDFDNmtD?=
 =?utf-8?B?VzhaWEVvUkIxbnJyNkcxOW5ET3dRS3BYZ2ZlcHM5Q2cvOVdNcWNkT2lXVE92?=
 =?utf-8?B?S0VQV01qZVQ2dWlGZkxHT1RXRkxIRURmeGc4Q0lmRTlWREhZZnN0QTBGRVll?=
 =?utf-8?B?cGw0eDFGVUtwOXNPNjBlTGZBcDVNaVNiZVdPYXE2d3FVTkhmeWxqTlZ4bnp5?=
 =?utf-8?B?ajFxNUJFV3YrZTdScUxzWlRwU1lWc3hNRWFyN245WjVodEh5R2c3VWttZ0lo?=
 =?utf-8?B?aHdUWHhkTkdydFAyU3owN2FkUE93OVlPTlg3dDZoY3p3US9pQ1JMUnJpQWZk?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e5acd0-be9a-4e21-b25f-08dbd5782b54
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 16:33:50.4052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4CA1gRw3S5RpEbQgbez/gOXq1eaZpHVoDOCreipo1pPyd8p1v00gYqMbat52We/hlj9MIjSKFXS0KnZisMkcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6865
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Oct 2023 16:33:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13447

On 23.10.23 16:59, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> cleanup the customizations scripts by:
>   - Move the ssh configuration from postinst to /etc/ssh/sshd_config.d
>   - Move systemd service overrides to files instead of setting it in
>     postinst
>   - fix formatting
>   - fix scripting error in security customizations
> 
> Quirin Gylstorff (9):
>   scripts/deploy-kernelci: Format python code and remove unused import
>   customizations: Add variable to set the HOSTNAME
>   customizations: Move ssh configuration from postinst to sshd_config.d
>   security-customizations: Add dependency to customizations
>   security-customizations: Fix shell error
>   security-customizations: Extract sshd config from postinst to files
>   cip-core-image-security: Move packages to security-customization
>   customization-kernelci: Add dependency to customizations
>   kas/opt/reproducible.yml: Move SOURCE_DATE_EPOCH to layer.conf
> 
>  conf/layer.conf                               |  2 ++
>  kas/opt/reproducible.yml                      |  1 -
>  kas/opt/security.yml                          |  2 ++
>  recipes-core/customizations/common.inc        |  6 +++-
>  recipes-core/customizations/customizations.bb | 10 ++++++
>  .../files/{postinst => postinst.tmpl}         |  8 ++---
>  .../customizations/files/ssh-permit-root.conf |  1 +
>  .../images/cip-core-image-security.bb         | 12 +------
>  .../kernelci-customizations/files/postinst    | 11 -------
>  .../files/serial-getty-kernelci-override.conf |  3 ++
>  .../files/ssh-permit-empty-passwords.conf     |  2 ++
>  .../kernelci-customizations.bb                | 18 ++++++++---
>  .../security-customizations/files/postinst    | 24 ++------------
>  .../files/ssh-pam-remote.conf                 |  4 +++
>  .../files/ssh-remote-session-term.conf        |  5 +++
>  .../security-customizations.bb                | 25 ++++++++++++---
>  scripts/deploy-kernelci.py                    | 31 ++++++++++---------
>  17 files changed, 89 insertions(+), 76 deletions(-)
>  rename recipes-core/customizations/files/{postinst => postinst.tmpl} (62%)
>  create mode 100644 recipes-core/customizations/files/ssh-permit-root.conf
>  create mode 100644 recipes-core/kernelci-customizations/files/serial-getty-kernelci-override.conf
>  create mode 100644 recipes-core/kernelci-customizations/files/ssh-permit-empty-passwords.conf
>  create mode 100644 recipes-core/security-customizations/files/ssh-pam-remote.conf
>  create mode 100644 recipes-core/security-customizations/files/ssh-remote-session-term.conf
> 

Things look good to me, but I'd like to get another check/opinion.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


