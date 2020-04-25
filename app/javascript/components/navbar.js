import React, { useState, useContext, useEffect } from 'react';
import { ProjectContext } from './projectContext'

const Navbar = () => {
  const [projects, setProjects] = useContext(ProjectContext);
  const [filter, setFilter] = useState('');

  const updateFilter = (e) => {
    setFilter(e.target.value);
  }

  const filterProjects = (e) => {
    e.preventDefault();

    if (e === "" && filter === "") return;

    const filteredProjs = projects.map((pl) =>{
      let filtered = false;

      if (pl.name.includes(filter)) { filtered = true };

      return { ...pl, filtered: filtered };
    })

    setProjects(filteredProjs);
  }

  const clearFilter = (e) => {
    e.preventDefault();

    setFilter("");

    const filteredProjs = projects.map(pl => {
      return {...pl, filtered: true };
    })

    setProjects(filteredProjs);
  }

  return (
    <nav className="navbar navbar-light bg-light justify-content-between mb-5 shadow-sm">
      <a className="navbar-brand mb-0 h1">
        CM Novo Hamburgo
      </a>

      <form className="form-inline" onSubmit={filterProjects} >
        <input className="form-control mr-sm-2" placeholder="PL 92/2019" aria-label="Pesquisar" name="filter" value={filter} onChange={updateFilter} />

        <button className="btn btn-outline-success my-2 my-sm-0" type="submit" >Buscar</button>
        { filter &&
          <button className="btn btn-outline-info my-2 my-sm-0" type="submit" onClick={clearFilter} >Limpar</button>
        }
      </form>
    </nav>
  )
}

export default Navbar;
