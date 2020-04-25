import React, { useState, useContext, useEffect } from 'react';
import Project from './project';
import Pagination from './pagination';
import ProjectFilterLabel from './projectFilterLabel';
import api from "../services/api";
import { ProjectContext } from './projectContext'

const ProjectList = () => {
  const [projects, setProjects] = useContext(ProjectContext);
  const [pagination, setPagination] = useState([]);
  const [count, setCounter] = useState(0);

  useEffect(() => {
    loadProjects();
  }, []);

  useEffect(() => {
    const filteredProjects = projects.filter(p => p.filtered)

    setCounter(filteredProjects.length);
  }, [projects]);

  async function loadProjects(page) {
    const response = await api.get(`/projects?page=${page}`);
    const { projects, ...pagination } = response.data;

    setProjects(projects.map(p => {
      return { ...p, filtered: true }
    }));
    setPagination(pagination);
  }

  function prevPage() {
    const { page } = pagination;

    if (pagination.page === 1) return;

    const prevPageNumber = page - 1;

    loadProjects(prevPageNumber);
  }

  function nextPage() {
    const { page, ...pages } = pagination;

    if (page === pages.total_pages) return;

    const nextPageNumber = page + 1;

    loadProjects(nextPageNumber);
  }

  return (
    <div className="container">
      <h2>Matérias Legislativas</h2>

      <ProjectFilterLabel quantity={count} />

      <table className="table table-striped table-hover mb-1">
        <thead>
          <tr>
            <th scope="col">Projeto</th>
            <th scope="col">Ementa</th>
            <th scope="col">Link</th>
          </tr>
        </thead>
        <tbody>
          { projects.map(project => {
              return <Project name={project.name}
                        description={project.description}
                        link={project.link}
                        filtered={project.filtered}
                        key={project.name} />
            })
          }
        </tbody>
      </table>

      <Pagination
         prevPage={prevPage}
         nextPage={nextPage}
         pagination={pagination}
       />
    </div>
  )
}

export default ProjectList;
