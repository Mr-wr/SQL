- - 查 询 连 续 三 天 登 入
select
  c.id,
  count(*) as um
from(
    - - 根 据 id 分 组 查 看
    select
      *,
      (b.date - b.cum) as result
    from
      (
        - - 用 row_number 按 根 据 id 按 顺 序 排 序
        select
          *,
          row_number() over(
            partition by a.id
            order by
              a.date
          ) as cum
        from
          (
            - - 去 重 日 期
            select
              distinct DateKey as date,
              Id as id
            FROM
              tables
          ) as a
      ) as b
  ) c
group by
  id,
  result
having
  count(*) > 2