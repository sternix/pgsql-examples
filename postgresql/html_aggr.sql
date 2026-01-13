CREATE OR REPLACE FUNCTION html_li_aggr (state text,p text) RETURNS text AS $$
  BEGIN
    IF p IS NULL THEN
      RETURN state;
    ELSE
      RETURN state || '<li>' || p || E'</li>\n';
    END IF;
  END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION html_ul_final (state text) RETURNS text AS $$
  BEGIN
    IF $1 <> '' THEN
      RETURN E'<ul>\n' || state || '</ul>';
    ELSE
      RETURN '';
    END IF;
  END;
$$ LANGUAGE plpgsql IMMUTABLE;

DROP AGGREGATE html_ul (text);

CREATE AGGREGATE html_ul (
  basetype = text,
  sfunc = html_li_aggr,
  stype = text,
  initcond = '',
  finalfunc = html_ul_final
);

